import copy
from decimal import Decimal
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

SCRIPTS = Path(__file__).resolve().parents[1]/"scripts"
sys.path.insert(0, str(SCRIPTS))
import batch_image as batch
from build_spec import build

# 合同结构来自 TemplateSpec v2；所有身份均为测试专用，不含真实账号或私有模板 ID。
MODEL = "test/image-model"
SERVER = "https://example.invalid/loom/v1"
CAPS = {"matches": [
    {"authoringKind": "capabilityProfile", "operation": "text-to-image",
     "profile": {"profileId": "image.text-to-image.v1", "inputPorts": [{"portId": "prompt"}]},
     "eligibleModels": [{"modelId": MODEL}]},
    {"authoringKind": "fixedModelContract", "contract": {
        "modelId": MODEL, "operation": "text-to-image", "subjectRevisionId": "test-contract-revision",
        "inputPorts": [
            {"portId": "prompt", "required": True, "valueType": "string", "constraints": {"maxLength": 1000}},
            {"portId": "size", "valueType": "string", "constraints": {"enum": ["1328*1328", "1664*928"]}},
            {"portId": "negative_prompt", "valueType": "string", "constraints": {"maxLength": 1000}},
            {"portId": "prompt_extend", "valueType": "boolean"},
            {"portId": "n", "valueType": "integer"}]
    }}]}


class SpecTests(unittest.TestCase):
    def test_universal_direct_prompt_and_model_choice(self):
        spec = build(CAPS, "universal", MODEL)
        step = spec["steps"][0]
        self.assertEqual(len(spec["steps"]), 1)
        self.assertEqual(step["inputBindings"], {"prompt": {"source": "templateInput", "inputKey": "prompt"}})
        self.assertEqual(step["modelSelection"]["defaultModelId"], MODEL)
        self.assertNotIn("profileRevision", step["executionBinding"])
        self.assertNotIn("size", spec["templateInputs"])

    def test_native_parameters_retain_contract_constraints(self):
        spec = build(CAPS, "native", MODEL)
        self.assertEqual(spec["templateInputs"]["size"]["constraints"]["enum"], ["1328*1328", "1664*928"])
        self.assertEqual(spec["templateInputs"]["prompt"]["constraints"]["maxLength"], 1000)
        b = spec["steps"][0]["inputBindings"]
        self.assertEqual(b["prompt_extend"], {"source": "literal", "value": False})
        self.assertEqual(b["n"], {"source": "literal", "value": 1})
        self.assertEqual(b["size"], {"source": "templateInput", "inputKey": "size"})
        self.assertNotIn("modelSelection", spec["steps"][0])

    def test_no_unbound_inputs(self):
        for mode in ("universal", "native"):
            spec = build(CAPS, mode, MODEL)
            step = spec["steps"][0]
            used = {x["inputKey"] for x in step["inputBindings"].values() if x["source"] == "templateInput"}
            if "modelSelection" in step:
                used.add(step["modelSelection"]["inputKey"])
            self.assertEqual(set(spec["templateInputs"]), used)

    def test_unknown_model_and_extra_required_port_rejected(self):
        with self.assertRaises(ValueError):
            build(CAPS, "universal", "missing-model")
        caps = copy.deepcopy(CAPS)
        caps["matches"][1]["contract"]["inputPorts"].append({"portId": "image", "required": True})
        with self.assertRaises(ValueError):
            build(caps, "native", MODEL)

    def test_ambiguous_native_contract_rejected(self):
        caps = copy.deepcopy(CAPS)
        caps["matches"].append(copy.deepcopy(caps["matches"][1]))
        with self.assertRaises(ValueError):
            build(caps, "native", MODEL)

    def test_generator_cli_runs_from_checkout(self):
        with tempfile.TemporaryDirectory() as temp:
            caps, out = Path(temp)/"caps.json", Path(temp)/"spec.json"
            batch.save(caps, CAPS)
            result = subprocess.run([sys.executable, str(SCRIPTS/"build_spec.py"), "--capabilities", str(caps),
                                     "--mode", "native", "--model", MODEL, "--output", str(out)], capture_output=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(batch.read(out), build(CAPS, "native", MODEL))


class WorkflowTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.state = self.root/"state.json"
        self.book = self.root/"用户输入.xlsx"
        self.receipt = self.root/"quote.json"
        self.book.write_bytes('原始提示词\n"不改写" ${literal}'.encode())
        batch.save(self.state, {"status": "created", "server": SERVER, "templateId": "test-template", "versionId": "test-version"})
        self.calls = []
        self.amount, self.currency, self.sufficient = "0.60", "CNY", True
        self.address = SERVER
        self.valid = True
        self.submit_error = False
        self.submit_response = {"runId": "test-run"}
        self.addCleanup(patch.stopall)
        patch.object(batch, "cli", side_effect=self.fake_cli).start()

    def fake_cli(self, *args):
        self.calls.append(args)
        if args[0] == "doctor":
            return {"healthy": True, "token_valid": True, "server": self.address}
        if args[1] == "validate-workbook":
            return {"validation": {"valid": self.valid}}
        if args[1] == "precheck-workbook":
            return {"precheck": {"estimatedTotalCost": {"amount": self.amount, "currency": self.currency},
                                 "balanceCheck": {"isSufficient": self.sufficient}}}
        if args[1] == "submit-workbook":
            if self.submit_error:
                raise batch.BatchError("连接在提交后断开")
            return self.submit_response
        if args[1] == "check":
            return {"valid": True}
        if args[1] == "create":
            return {"templateId": "new-template", "versionId": "new-version"}
        raise AssertionError(args)

    def prepared(self):
        return batch.prepare(self.state, self.book, self.receipt)

    def submissions(self):
        return [c for c in self.calls if c[:2] == ("template-spec", "submit-workbook")]

    def test_prepare_never_creates_a_run_and_preserves_bytes(self):
        r = self.prepared()
        self.assertEqual(Path(r["snapshotFile"]).read_bytes(), self.book.read_bytes())
        self.assertEqual(r["amount"], "0.60")
        self.assertEqual(self.submissions(), [])

    def test_changed_original_or_snapshot_blocks_submission(self):
        r = self.prepared()
        original = self.book.read_bytes()
        for path in (self.book, Path(r["snapshotFile"])):
            path.write_bytes(b"changed")
            with self.assertRaisesRegex(batch.BatchError, "输入已改变"):
                batch.submit(self.receipt, "0.60", "CNY")
            path.write_bytes(original)
        self.assertEqual(self.submissions(), [])

    def test_changed_server_blocks_submission(self):
        self.prepared()
        self.address = "https://another.invalid/loom/v1"
        with self.assertRaisesRegex(batch.BatchError, "Server"):
            batch.submit(self.receipt, "0.60", "CNY")
        self.assertEqual(self.submissions(), [])

    def test_currency_or_amount_confirmation_mismatch_blocks(self):
        self.prepared()
        for amount, currency in (("0.06", "CNY"), ("0.60", "USD")):
            with self.assertRaisesRegex(batch.BatchError, "确认金额"):
                batch.submit(self.receipt, amount, currency)
        self.assertEqual(self.submissions(), [])

    def test_fresh_quote_change_blocks(self):
        self.prepared()
        self.amount = "0.80"
        with self.assertRaisesRegex(batch.BatchError, "最新报价"):
            batch.submit(self.receipt, "0.60", "CNY")
        self.assertEqual(self.submissions(), [])

    def test_edit_during_precheck_blocks(self):
        self.prepared()
        real = self.fake_cli
        def change_after_quote(*args):
            result = real(*args)
            if args[:2] == ("template-spec", "precheck-workbook"):
                self.book.write_bytes(b"edited while quote was running")
            return result
        with patch.object(batch, "cli", side_effect=change_after_quote):
            with self.assertRaisesRegex(batch.BatchError, "报价期间"):
                batch.submit(self.receipt, "0.60", "CNY")
        self.assertEqual(self.submissions(), [])

    def test_insufficient_balance_blocks(self):
        self.sufficient = False
        self.assertFalse(self.prepared()["balanceSufficient"])
        with self.assertRaisesRegex(batch.BatchError, "余额不足"):
            batch.submit(self.receipt, "0.60", "CNY")
        self.assertEqual(self.submissions(), [])

    def test_invalid_workbook_stops_before_quote(self):
        self.valid = False
        with self.assertRaisesRegex(batch.BatchError, "校验失败"):
            self.prepared()
        self.assertFalse(any(c[:2] == ("template-spec", "precheck-workbook") for c in self.calls))

    def test_submit_persists_id_and_rejects_duplicate(self):
        self.prepared()
        result = batch.submit(self.receipt, "0.6", "CNY")
        self.assertEqual(result["runId"], "test-run")
        self.assertIn(result["clientRequestId"], self.submissions()[0])
        self.assertEqual(batch.read(self.receipt)["status"], "submitted")
        with self.assertRaisesRegex(batch.BatchError, "已尝试提交"):
            batch.submit(self.receipt, "0.6", "CNY")
        self.assertEqual(len(self.submissions()), 1)

    def test_ambiguous_network_error_keeps_attempt_and_id(self):
        self.prepared()
        self.submit_error = True
        with self.assertRaises(batch.BatchError):
            batch.submit(self.receipt, "0.60", "CNY")
        saved = batch.read(self.receipt)
        self.assertEqual(saved["status"], "submitting")
        self.assertIn(saved["clientRequestId"], self.submissions()[0])
        with self.assertRaisesRegex(batch.BatchError, "已尝试提交"):
            batch.submit(self.receipt, "0.60", "CNY")
        self.assertEqual(len(self.submissions()), 1)

    def test_missing_run_id_is_not_success(self):
        self.prepared()
        self.submit_response = {}
        with self.assertRaisesRegex(batch.BatchError, "缺少 runId"):
            batch.submit(self.receipt, "0.60", "CNY")
        self.assertEqual(batch.read(self.receipt)["status"], "submitting")

    def test_concurrent_record_access_rejected(self):
        with batch.lock(self.receipt):
            with self.assertRaisesRegex(batch.BatchError, "另一进程"):
                self.prepared()
        self.assertFalse(Path(str(self.receipt)+".lock").exists())
        self.assertEqual(self.calls, [])

    def test_create_checks_then_saves_real_ids_and_blocks_repeat(self):
        spec = self.root/"spec.json"
        state = self.root/"new.json"
        batch.save(spec, build(CAPS, "universal", MODEL))
        result = batch.create(spec, state)
        self.assertEqual(result["templateId"], "new-template")
        self.assertEqual(result["versionId"], "new-version")
        self.assertEqual(result["specSha256"], batch.sha(spec))
        with self.assertRaisesRegex(batch.BatchError, "创建记录已存在"):
            batch.create(spec, state)

    def test_quote_missing_currency_and_nonfinite_amount_rejected(self):
        for amount,currency in (("0.6",None),("NaN","CNY"),("Infinity","CNY"),("-1","CNY")):
            with self.assertRaises(batch.BatchError):
                batch.fee({"precheck":{"estimatedTotalCost":{"amount":amount,"currency":currency}}})
        self.assertEqual(batch.fee({"precheck":{"estimatedTotalCost":{"amount":"0.6","currency":"CNY"}}})[0], Decimal("0.6"))


if __name__ == "__main__":
    unittest.main()
