"""Build TemplateSpec v2 using a saved, current capability-resolve response."""
import argparse
import json
from pathlib import Path


def field(label, order, required=False, constraints=None, description=""):
    result = {"kind": "value", "valueType": "string", "required": required,
              "blankPolicy": "error" if required else "omit",
              "presentation": {"label": label, "order": order, "description": description}}
    if constraints:
        result["constraints"] = constraints
    return result


def build(caps, mode, model_id):
    matches = caps.get("matches", [])
    prompt = field("生图提示词", 20, True, {"minLength": 1}, "原样发送；请把画面、风格、文字等要求写完整。")
    inputs = {"prompt": prompt}
    step = {"stepId": "stp_image01", "displayName": "按原始提示词生成图片",
            "inputBindings": {"prompt": {"source": "templateInput", "inputKey": "prompt"}}}
    instructions = ["每行一个独立生图任务；通过服务端结果工作簿保留的原始行核对结果。",
                    "提示词直接绑定图片生成接口，不经过文本模型改写，不追加角色或营销文案。",
                    "重复出图请复制为多行。运行前校验并查看费用估算。",
                    "结果使用服务端结果工作簿与原始输入对齐；失败行核对后单独重试，不整批盲重跑。"]
    samples = [{"values": {"prompt": "白色陶瓷咖啡杯置于浅灰背景，柔和自然侧光，产品摄影，杯身无文字，无人物。"}},
               {"values": {"prompt": "雨后的未来城市街角，蓝紫霓虹倒映在路面，电影感广角构图，无文字。"}},
               {"values": {"prompt": "橙色小猫坐在窗台看星空，温暖的儿童绘本插画，柔和笔触，无文字。"}}]
    if mode == "universal":
        profiles = [m for m in matches if m.get("authoringKind") == "capabilityProfile"
                    and m.get("operation") == "text-to-image"
                    and any(p.get("portId") == "prompt" for p in m["profile"].get("inputPorts", []))]
        chosen = next((m for m in profiles if model_id in {x["modelId"] for x in m.get("eligibleModels", [])}), None)
        if not chosen:
            raise ValueError("当前文生图 Profile 不支持指定默认模型")
        inputs["modelChoice"] = field("生图模型（可选）", 30, description="留空使用模板默认模型；只可填写当前可用模型 ID。")
        step["executionBinding"] = {"kind": "capabilityProfile", "profileId": chosen["profile"]["profileId"]}
        step["modelSelection"] = {"source": "templateInput", "inputKey": "modelChoice", "defaultModelId": model_id}
        instructions += ["通用版支持逐行选择模型；不包含精确尺寸、质量、负向提示词等原生参数列。",
                         "需要精确像素尺寸请使用匹配模型的精确参数版；在提示词中写尺寸不等于原生尺寸参数。",
                         "模板不改写提示词；模型供应商内部的处理行为取决于所选模型。"]
        title = "批量文生图（通用模型版）"
    else:
        candidates = [m["contract"] for m in matches if m.get("authoringKind") == "fixedModelContract"
                      and m.get("contract", {}).get("modelId") == model_id
                      and m.get("contract", {}).get("operation") == "text-to-image"]
        if len(candidates) != 1:
            raise ValueError("需要唯一的纯文生图模型合同；请检查当前能力响应")
        contract = candidates[0]
        ports = {p["portId"]: p for p in contract["inputPorts"]}
        if any(p.get("required") and k != "prompt" for k, p in ports.items()):
            raise ValueError("模型存在额外必填输入，不能作为本工具的纯文生图合同")
        step["executionBinding"] = {"kind": "fixedModelContract", "subjectRevisionId": contract["subjectRevisionId"]}
        prompt["constraints"] = {**ports["prompt"].get("constraints", {}), "minLength": 1}
        labels = {"size": "图片尺寸", "aspect_ratio": "画面比例", "quality": "图片质量", "negative_prompt": "负向提示词"}
        for index, (key, label) in enumerate(labels.items(), 3):
            if key in ports and ports[key].get("valueType") == "string":
                inputs[key] = field(label, index * 10, constraints=ports[key].get("constraints"), description="留空采用模型默认；可选值以当前合同及工作簿校验为准。")
                step["inputBindings"][key] = {"source": "templateInput", "inputKey": key}
        if "prompt_extend" in ports:
            step["inputBindings"]["prompt_extend"] = {"source": "literal", "value": False}
        if "n" in ports:
            step["inputBindings"]["n"] = {"source": "literal", "value": 1}
        if "size" in inputs:
            sizes = inputs["size"].get("constraints", {}).get("enum", [])
            size = next((s for s in sizes if s in ["1328*1328", "1024x1024", "1024*1024"]), None)
            if size:
                for sample in samples:
                    sample["values"]["size"] = size
        instructions += [f"本版绑定 {model_id} 的当前纯文生图合同；原生参数直接传入，不拼接到提示词。",
                         "换模型须重新解析合同、生成并检查新模板版本，再下载对应工作簿。"]
        title = f"批量文生图（精确参数版：{model_id}）"
    return {"meta": {"name": title, "description": "表格每行一个任务，保留原始提示词，生成图片并按原始输入返回结果。",
                     "primaryOutputType": "image", "displayOutputType": "图片及逐行结果工作簿", "tags": ["批量", "文生图", "Excel"]},
            "templateInputs": inputs, "steps": [step], "workbook": {"instructions": instructions, "sampleRows": samples}}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--capabilities", type=Path, required=True)
    p.add_argument("--mode", choices=["universal", "native"], required=True)
    p.add_argument("--model", required=True)
    p.add_argument("--output", type=Path, required=True)
    args = p.parse_args()
    spec = build(json.loads(args.capabilities.read_text(encoding="utf-8-sig")), args.mode, args.model)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(spec, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(args.output)


if __name__ == "__main__":
    main()
