# Excel 批量文生图

把[图像提示词工程师](../../design/design-image-prompt-engineer.md)等角色产出的最终提示词填进 Excel，每行作为一个独立任务，通过 LoomLoom 执行并下载对应原始输入的结果表和图片。

这是需要主动选择的执行集成，不修改角色正文，不增加角色数量，也不加入默认安装流程。适用于已有多条完整提示词、希望一次提交的人。源码仅依赖 Python 标准库；在线调用另需 LoomLoom CLI 和用户自己的服务账号。

## 两种输入方式

| 模板 | Excel 输入 | 行为 |
| --- | --- | --- |
| 通用模型版 | 生图提示词、可选模型 ID | 每行可选择当前 Profile 允许的模型；使用模型默认参数 |
| 精确参数版 | 生图提示词，以及模型支持的尺寸、比例、质量、负向提示词 | 固定当前模型合同，参数直接绑定真实端口 |

提示词直接传给生图端口，不经过额外文本模型翻译或润色，也不会拼接角色定义。通用 Profile 当前只有 `prompt` 端口，因此不会展示无法实际生效的尺寸列。精确参数版在模型支持 `prompt_extend` 时关闭扩写，在支持 `n` 时固定为 1；要多张图片可复制为多行。供应商内部的处理行为仍由模型决定。

## 准备

需要 Python 3.10+、[LoomLoom CLI](https://github.com/cogfoundry-labs/loomloom)（已验证 v0.5.0 的 TemplateSpec v2 接口）以及完成 `loomloom doctor --output json` 检查的 HTTPS Server。沿用用户已选环境，凭证只由 CLI 管理，不写入表格或仓库。可用 `LOOMLOOM_BIN` 指定 CLI 可执行文件路径。

从本目录执行下列命令。Windows 可将 `python` 换成 `py -3`；macOS/Linux 可换成 `python3`。

### 1. 选择模型，生成并检查模板规格

先查看当前可用模型：

```sh
loomloom template-spec models image-generate --output json
```

用返回的真实模型 ID 替换下面的 `MODEL_ID`，不要照填占位文字。脚本会查询实时能力，生成 v2 规格并调用服务端校验，此时不创建模板。

```sh
python scripts/batch_image.py spec --mode universal --model MODEL_ID --output runtime/spec.json
```

有精确尺寸要求时，把 `--mode universal` 换成 `--mode native`。不支持的模型、存在额外必填输入或不能唯一确定的模型合同会报错；不会猜测接口。表格参数选项来自该模型的当前合同。

### 2. 创建私有模板并下载 Excel

检查生成的规格后，显式创建模板。创建本身不会启动图片生成或发布市场商品。

```sh
python scripts/batch_image.py create --spec runtime/spec.json --state runtime/template.json --confirm-create
python scripts/batch_image.py workbook --state runtime/template.json --output runtime/input.xlsx
```

`template.json` 保存当前账号的模板 ID、版本 ID 和 Server；不使用仓库作者的私有模板。若记录已经存在，不覆盖或重复创建。新模板或版本需要下载其对应的正式 Excel。

### 3. 填写并报价

打开 `runtime/input.xlsx` 的 `data` 工作表。替换样例行，每行写一条最终提示词，也可以追加行。保留列名、版本元数据和隐藏选项表；留下的样例也会计入任务。

```sh
python scripts/batch_image.py prepare --state runtime/template.json --workbook runtime/input.xlsx --receipt runtime/quote.json
```

这一步校验工作簿，保存不可变输入快照，返回最新报价与币种、余额是否足够，不执行生图。`amount` 已是货币单位，例如 `0.60 CNY` 表示人民币六角。每次新报价使用新的记录路径。

### 4. 确认金额后执行

将 `AMOUNT` 和 `CURRENCY` 替换为本次报价中的精确金额和币种；此命令会产生计费任务。

```sh
python scripts/batch_image.py submit --receipt runtime/quote.json --confirm-cost AMOUNT --currency CURRENCY
```

提交前再次校验和报价。原表或快照变更、Server 改变、最新价格变化、币种不匹配、余额不足都会阻止提交。修改输入后重新 prepare 并确认新报价。

同一报价记录只允许尝试提交一次，并在网络调用前保存 `clientRequestId`。连接中断或响应缺失时，先用 `loomloom run list --output json` 等命令查询服务端；不得删除记录重新提交。确认需重试相同请求时，使用记录中的相同 Server、模板版本、快照和原请求 ID 手动调用 CLI。脚本不自动重试计费操作。

### 5. 获取结果

用提交结果的真实 `runId` 替换 `RUN_ID`：

```sh
loomloom run get RUN_ID --output json
loomloom run result-workbook RUN_ID --output-file runtime/results.xlsx
loomloom artifact download RUN_ID --output-dir runtime/images
```

以服务端结果工作簿对齐原始行、图片和失败信息。失败行核对后单独重新报价，不整批重跑。创建与提交脚本锁文件用于防止并发重复操作；进程被强制终止后，先核对远端状态再处理遗留锁。

## Agent 使用

在支持 Skill 的工具中加载本目录的 [SKILL.md](SKILL.md)，或让 Agent 读取它与本说明。不要把工具调用说明追加到通用角色正文中。`scripts/` 与 `SKILL.md` 应一起保留。默认转换和安装脚本不会安装这个可选集成。

## 测试

在仓库根目录运行：

```sh
python -m unittest discover -s integrations/loomloom/tests -v
npm run check:counts
bash scripts/lint-agents.sh
```

新增测试不需要网络、Token、余额或真实模型调用，覆盖规格生成、工作簿快照、费用单位、确认匹配、参数校验失败、输入变更、请求状态和重复提交防护。

在线验收按上面的 spec、create、workbook、prepare、submit、结果下载流程进行。将“规格/报价成功”和“实际出图成功”分别记录，不能用模拟响应代替真实模型验收。`runtime/` 已忽略，不提交账号绑定的工作簿、模板记录、费用信息或凭证。
