"""Excel 批量文生图：通过 LoomLoom CLI 校验、报价并显式提交。仅使用 Python 标准库。"""
import argparse
from contextlib import contextmanager
from decimal import Decimal, InvalidOperation
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
from urllib.parse import urlparse
import uuid

from build_spec import build


class BatchError(Exception):
    pass


def cli(*args):
    command = [os.environ.get("LOOMLOOM_BIN", "loomloom"), *map(str, args), "--output", "json"]
    result = subprocess.run(command, capture_output=True, text=True, encoding="utf-8", timeout=660)
    if result.returncode:
        raise BatchError(f"LoomLoom 命令失败（退出码 {result.returncode}）；请单独运行相应 CLI 命令检查诊断。")
    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError as exc:
        raise BatchError("LoomLoom 未返回有效 JSON；未把响应当作成功。") from exc


def read(path):
    return json.loads(Path(path).read_text(encoding="utf-8-sig"))


def save(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    # replace 同目录临时文件，避免中断后留下半份执行记录。
    with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8", dir=path.parent, delete=False) as f:
        json.dump(value, f, ensure_ascii=False, indent=2)
        f.write("\n")
        temporary = Path(f.name)
    try:
        temporary.replace(path)
    finally:
        temporary.unlink(missing_ok=True)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


@contextmanager
def lock(path):
    """同一记录只允许一个进程操作；进程被强制终止后需人工核对锁与远端状态。"""
    marker = Path(str(path) + ".lock")
    marker.parent.mkdir(parents=True, exist_ok=True)
    try:
        handle = marker.open("x", encoding="utf-8")
    except FileExistsError as exc:
        raise BatchError("记录被另一进程占用或上次执行中断；先核对状态，不自动清理锁。") from exc
    try:
        with handle:
            handle.write(str(os.getpid()))
        yield
    finally:
        marker.unlink()


def server():
    doctor = cli("doctor")
    if not doctor.get("healthy") or not doctor.get("token_valid"):
        raise BatchError("当前 LoomLoom 环境未就绪；先完成 doctor 检查，不自动切换平台或凭证。")
    address = doctor.get("server", "")
    url = urlparse(address)
    if url.scheme != "https" or not url.hostname or url.username or url.password:
        raise BatchError("仅使用 doctor 确认的 HTTPS Server。")
    return address


def bound_state(path):
    state = read(path)
    if state.get("status") != "created" or not state.get("templateId") or not state.get("versionId"):
        raise BatchError("模板创建记录不完整；先查询服务端状态，不自动重复创建。")
    if state.get("server") != server():
        raise BatchError("当前 Server 与模板创建环境不同。")
    return state


def fee(response):
    precheck = response.get("precheck", {})
    cost = precheck.get("estimatedTotalCost", {})
    currency = cost.get("currency")
    try:
        amount = Decimal(cost["amount"])
    except (KeyError, TypeError, InvalidOperation) as exc:
        raise BatchError("报价缺少有效金额；不能提交。") from exc
    if not amount.is_finite() or amount < 0 or not isinstance(currency, str) or not currency.strip():
        raise BatchError("报价金额或币种无效；不能提交。")
    # v0.5.0 CLI 的 amount 已是货币单位，不能再次按原始 API 的 T 单位换算。
    sufficient = precheck.get("balanceCheck", {}).get("isSufficient") is True
    return amount, currency, sufficient


def validate_and_quote(state, workbook):
    args = (state["templateId"], state["versionId"], str(workbook), "--server", state["server"])
    validation = cli("template-spec", "validate-workbook", *args)
    if validation.get("validation", {}).get("valid") is not True:
        raise BatchError("工作簿校验失败；未报价或提交。")
    quote = cli("template-spec", "precheck-workbook", *args)
    fee(quote)
    return quote


def create(spec_path, state_path):
    with lock(state_path):
        return _create(spec_path, state_path)


def _create(spec_path, state_path):
    if Path(state_path).exists():
        raise BatchError("创建记录已存在；先检查该记录，不自动覆盖或重复创建。")
    address = server()
    with tempfile.TemporaryDirectory() as temp:
        frozen = Path(temp)/"spec.json"
        frozen.write_bytes(Path(spec_path).read_bytes())
        checked = cli("template-spec", "check", frozen, "--server", address)
        if checked.get("valid") is not True:
            raise BatchError("模板规格校验未通过。")
        state = {"status": "creating", "server": address, "specSha256": sha(frozen)}
        save(state_path, state)
        response = cli("template-spec", "create", frozen, "--server", address)
    state["response"] = response
    if response.get("templateId") and response.get("versionId"):
        state.update(status="created", templateId=response["templateId"], versionId=response["versionId"])
    save(state_path, state)
    if state["status"] != "created":
        raise BatchError("创建响应缺少模板或版本 ID；请查询服务端，不重复创建。")
    return state


def prepare(state_path, workbook, receipt_path):
    with lock(receipt_path):
        return _prepare(state_path, workbook, receipt_path)


def _prepare(state_path, workbook, receipt_path):
    state = bound_state(state_path)
    receipt_path = Path(receipt_path)
    if receipt_path.exists():
        raise BatchError("报价记录已存在；每次新报价使用新记录路径。")
    workbook = Path(workbook).resolve()
    if workbook.suffix.lower() != ".xlsx":
        raise BatchError("输入必须是版本对应的 .xlsx 工作簿。")
    # 验证、报价、提交使用相同文件；用户之后修改原表会触发重新报价。
    receipt_path.parent.mkdir(parents=True, exist_ok=True)
    snapshot = receipt_path.parent/("input-"+uuid.uuid4().hex+".xlsx")
    snapshot.write_bytes(workbook.read_bytes())
    quote = validate_and_quote(state, snapshot)
    amount, currency, sufficient = fee(quote)
    record = {"status": "prepared", "server": state["server"], "templateId": state["templateId"],
              "versionId": state["versionId"], "originalFile": str(workbook),
              "snapshotFile": str(snapshot.resolve()), "sha256": sha(snapshot),
              "amount": str(amount), "currency": currency, "balanceSufficient": sufficient}
    save(receipt_path, record)
    return record


def submit(receipt_path, confirmed_amount, confirmed_currency):
    with lock(receipt_path):
        return _submit(receipt_path, confirmed_amount, confirmed_currency)


def _submit(receipt_path, confirmed_amount, confirmed_currency):
    record = read(receipt_path)
    if record.get("status") != "prepared":
        raise BatchError("此记录已尝试提交；先查询 run 状态，不自动重试或创建新计费任务。")
    if server() != record["server"]:
        raise BatchError("当前 Server 已变化，必须重新报价。")
    for key in ("originalFile", "snapshotFile"):
        if sha(record[key]) != record["sha256"]:
            raise BatchError("输入已改变，必须重新校验、报价并确认。")
    if Decimal(confirmed_amount) != Decimal(record["amount"]) or confirmed_currency != record["currency"]:
        raise BatchError("确认金额或币种与保存的报价不同。")
    # 确认后再次预检，报价变化或余额不足时不提交。
    quote = validate_and_quote(record, record["snapshotFile"])
    amount, currency, sufficient = fee(quote)
    if amount != Decimal(record["amount"]) or currency != record["currency"]:
        raise BatchError("最新报价发生变化，必须重新报价并确认。")
    if not sufficient:
        raise BatchError("当前余额不足，未提交。")
    for key in ("originalFile", "snapshotFile"):
        if sha(record[key]) != record["sha256"]:
            raise BatchError("报价期间输入发生变化，必须重新校验、报价并确认。")
    record.update(status="submitting", clientRequestId=str(uuid.uuid4()))
    save(receipt_path, record)  # 网络异常时保留同一个请求 ID，禁止盲目重跑。
    response = cli("template-spec", "submit-workbook", record["templateId"], record["versionId"],
                   record["snapshotFile"], "--client-request-id", record["clientRequestId"], "--server", record["server"])
    record["response"] = response
    record["runId"] = response.get("runId")
    if record["runId"]:
        record["status"] = "submitted"
    save(receipt_path, record)
    if not record["runId"]:
        raise BatchError("提交响应缺少 runId；请查询服务端状态，不重复提交。")
    return record


def main(argv=None):
    p = argparse.ArgumentParser(description=__doc__)
    sub = p.add_subparsers(dest="action", required=True)
    s = sub.add_parser("spec", help="查询当前能力，生成并检查规格，不创建模板")
    s.add_argument("--mode", choices=["universal", "native"], required=True)
    s.add_argument("--model", required=True)
    s.add_argument("--output", required=True)
    c = sub.add_parser("create", help="显式创建私有模板，不执行生图")
    c.add_argument("--spec", required=True)
    c.add_argument("--state", required=True)
    c.add_argument("--confirm-create", action="store_true", required=True)
    d = sub.add_parser("workbook", help="下载版本对应的正式 Excel")
    d.add_argument("--state", required=True)
    d.add_argument("--output", required=True)
    q = sub.add_parser("prepare", help="校验并报价，不执行生图")
    q.add_argument("--state", required=True)
    q.add_argument("--workbook", required=True)
    q.add_argument("--receipt", required=True)
    r = sub.add_parser("submit", help="确认当前金额与币种后提交生图任务")
    r.add_argument("--receipt", required=True)
    r.add_argument("--confirm-cost", required=True)
    r.add_argument("--currency", required=True)
    args = p.parse_args(argv)
    if args.action == "spec":
        if Path(args.output).exists():
            raise BatchError("规格输出文件已存在；请使用新路径。")
        address = server()
        caps = cli("capability", "resolve", "--input", "text", "--output-modality", "image", "--server", address)
        save(args.output, build(caps, args.mode, args.model))
        result = cli("template-spec", "check", args.output, "--server", address)
        if result.get("valid") is not True:
            raise BatchError("规格已保存，但未通过服务端校验。")
    elif args.action == "create":
        result = create(args.spec, args.state)
    elif args.action == "workbook":
        state = bound_state(args.state)
        if Path(args.output).exists():
            raise BatchError("工作簿已存在；请指定新路径，避免覆盖已填的提示词。")
        result = cli("template-spec", "download-workbook", state["templateId"], state["versionId"],
                     "--output-file", args.output, "--server", state["server"])
    elif args.action == "prepare":
        result = prepare(args.state, args.workbook, args.receipt)
    else:
        result = submit(args.receipt, args.confirm_cost, args.currency)
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    try:
        main()
    except (BatchError, OSError, ValueError, InvalidOperation, subprocess.TimeoutExpired) as exc:
        print(f"错误：{exc}", file=sys.stderr)
        sys.exit(1)
