# agency-agents 中文版（AI 智能体专家团队）

🌐 **简体中文** | [繁體中文](README.zh-TW.md) | [English (upstream)](https://github.com/msitarzewski/agency-agents)

> **211 个即插即用的 AI 专家角色** — 覆盖工程、设计、营销、产品、游戏、安全、金融等 18 个部门。不是通用提示词模板，每个智能体都有独立的人设、专业流程和可交付成果。支持 Claude Code / Cursor / Copilot 等 16 种 AI 编程工具。

[agency-agents](https://github.com/msitarzewski/agency-agents) 的中文社区版。在完整翻译上游的基础上，新增了 46 个中国市场原创智能体（小红书、抖音、微信、B站、飞书、钉钉等平台运营，以及跨境电商、政务ToG、医疗合规等垂直领域）。

[![GitHub stars](https://img.shields.io/github/stars/jnMetaCode/agency-agents-zh?style=social)](https://github.com/jnMetaCode/agency-agents-zh)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)


### 📊 项目规模

| 🤖 AI 智能体 | 🌏 英文版翻译 | 🇨🇳 中国市场原创 | 🧠 支持工具 | 🏢 部门 |
|:---:|:---:|:---:|:---:|:---:|
| **211** | **165** | **46** | **16 种** | **18 个** |

---

## 🚀 Agency Orchestrator — 让角色库真正跑起来

> **💡 一句话，让多个 AI 专家自动协作，几分钟交付完整方案。**
>
> 角色库提供专家，[**Agency Orchestrator**](https://github.com/jnMetaCode/agency-orchestrator) 让专家们像真实团队一样协作。

```bash
npm install -g agency-orchestrator
ao compose "帮我写一篇关于 AI Agent 的深度分析文章" --run
```

```
🎭 自动选角 → 叙事学家 + 心理学家 + 内容创作者 + 叙事设计师
📊 自动编排 → DAG 工作流，检测依赖，并行执行
✅ 自动交付 → 几分钟后拿到完整成果
```

| 能力 | 说明 |
|:---|:---|
| 🎯 **零代码编排** | 纯自然语言或 YAML，一句话描述需求即可 |
| ⚡ **DAG 并行执行** | 自动检测依赖，无依赖步骤并行跑，速度翻倍 |
| 🔄 **断点续跑** | 失败步骤可单独重跑，不用从头来 |
| 🆓 **6 种免费 LLM** | Claude Code / Gemini CLI / Copilot / Codex / OpenClaw / Ollama |
| 💰 **3 种 API 接入** | DeepSeek / Claude API / OpenAI |
| 📋 **32 个现成模板** | 开发、营销、数据分析、设计、运营，开箱即用 |

<p align="center">
  <a href="https://github.com/jnMetaCode/agency-orchestrator">
    <strong>⭐ 查看 Agency Orchestrator — 让 211 个角色为你协作 →</strong>
  </a>
</p>

---

## 这是什么？

一套**开箱即用的 AI 角色库**。每个智能体都有明确的身份定义、关键规则、工作流程和交付物，安装到你的 AI 编程工具后用自然语言激活。

**和普通提示词的区别**：普通提示词告诉 AI "你是一个专家"；这里的智能体定义了专家**怎么思考、怎么做事、交付什么**。例如[安全工程师](engineering/engineering-security-engineer.md)会按 OWASP Top 10 逐项审查代码，[小红书运营专家](marketing/marketing-xiaohongshu-operator.md)会输出完整的种草笔记策略和达人合作方案。

---

## 快速开始

### 方式一：一键安装到你的 AI 工具

支持 **16 种主流 AI 编程工具**，一条命令搞定：

```bash
# 自动检测已安装的工具，一键安装
./scripts/install.sh

# 或指定安装到特定工具
./scripts/install.sh --tool openclaw       # OpenClaw ⭐ 推荐
./scripts/install.sh --tool claude-code    # Claude Code
./scripts/install.sh --tool copilot        # GitHub Copilot
./scripts/install.sh --tool cursor         # Cursor
./scripts/install.sh --tool kiro           # Kiro (Amazon)
./scripts/install.sh --tool trae           # Trae
./scripts/install.sh --tool opencode       # OpenCode
./scripts/install.sh --tool aider          # Aider
./scripts/install.sh --tool windsurf       # Windsurf
./scripts/install.sh --tool antigravity    # Antigravity
./scripts/install.sh --tool gemini-cli     # Gemini CLI
./scripts/install.sh --tool qwen           # Qwen Code
./scripts/install.sh --tool codex          # Codex CLI
./scripts/install.sh --tool deerflow       # DeerFlow 2.0 (ByteDance)
./scripts/install.sh --tool workbuddy      # WorkBuddy (Tencent)
./scripts/install.sh --tool hermes         # Hermes Agent (NousResearch)
```

> Claude Code 和 GitHub Copilot 可直接安装；其他工具需先运行 `./scripts/convert.sh` 转换格式。

### 🔥 OpenClaw 用户快速上手

OpenClaw 是目前社区用户最多的集成方式，每个智能体会拆分为三个文件：`SOUL.md`（身份人设）+ `AGENTS.md`（业务能力）+ `IDENTITY.md`（简介），天然支持多智能体协作编排。

```bash
./scripts/convert.sh --tool openclaw   # 第一步：转换为 SOUL.md 格式
./scripts/install.sh --tool openclaw   # 第二步：安装到 ~/.openclaw/
```

安装后重启 OpenClaw 网关即可使用。

### 方式二：手动复制

```bash
# Claude Code / GitHub Copilot（直接复制即可）
cp -r marketing/*.md ~/.claude/agents/

# 在 Claude Code 中激活：
# "激活前端开发者模式，帮我构建一个 React 组件"
```

### 方式三：作为提示词参考

浏览下方智能体列表，复制/改编你需要的内容！

---

## 智能体阵容

### 🛠️ 工程部

构建未来，一个 commit 一个脚印。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [前端开发者](engineering/engineering-frontend-developer.md) | React/Vue、UI 实现、性能优化 | 现代 Web 应用、像素级 UI |
| [后端架构师](engineering/engineering-backend-architect.md) | API 设计、数据库架构、可扩展性 | 服务端系统、微服务 |
| [AI 工程师](engineering/engineering-ai-engineer.md) | 机器学习、模型部署、AI 集成 | ML 功能、数据管线 |
| [DevOps 自动化师](engineering/engineering-devops-automator.md) | CI/CD、基础设施自动化 | 流水线开发、部署自动化 |
| [安全工程师](engineering/engineering-security-engineer.md) | 威胁建模、代码审计、安全架构 | 应用安全、漏洞评估 |
| [快速原型师](engineering/engineering-rapid-prototyper.md) | 快速 POC、MVP 开发 | 概念验证、黑客马拉松 |
| [高级开发者](engineering/engineering-senior-developer.md) | Laravel/Livewire/FluxUI、高端 CSS、Three.js | 高品质 Web 体验 |
| [移动应用开发者](engineering/engineering-mobile-app-builder.md) | iOS/Android 原生、跨平台框架 | 移动端开发、App 性能优化 |
| [数据工程师](engineering/engineering-data-engineer.md) | ETL/ELT、数据湖、Spark/dbt | 数据管线、数据仓库 |
| [技术文档工程师](engineering/engineering-technical-writer.md) | API 文档、开发者文档、docs-as-code | 技术文档、知识库 |
| [自主优化架构师](engineering/engineering-autonomous-optimization-architect.md) | 自适应系统、自动调优 | 智能运维、自愈系统 |
| [嵌入式固件工程师](engineering/engineering-embedded-firmware-engineer.md) | RTOS、外设驱动、低功耗设计 | IoT、嵌入式系统 |
| [嵌入式 Linux 驱动工程师](engineering/engineering-embedded-linux-driver-engineer.md) ⭐ | 内核模块、设备树、Platform/I2C/SPI 驱动 | 嵌入式 Linux BSP 开发 |
| [FPGA/ASIC 数字设计工程师](engineering/engineering-fpga-digital-design-engineer.md) ⭐ | Verilog/SystemVerilog、时序收敛、AXI 总线 | FPGA 开发、数字逻辑设计 |
| [IoT 方案架构师](engineering/engineering-iot-solution-architect.md) ⭐ | MQTT/CoAP、边缘计算、设备管理、云平台 | 物联网端到端方案设计 |
| [故障响应指挥官](engineering/engineering-incident-response-commander.md) | 故障处置、SLO 管理、事后复盘 | 线上故障、应急响应 |
| [威胁检测工程师](engineering/engineering-threat-detection-engineer.md) | SIEM、威胁狩猎、检测规则 | 安全运营、威胁检测 |
| [Solidity 智能合约工程师](engineering/engineering-solidity-smart-contract-engineer.md) | Solidity、EVM、Gas 优化、DeFi | 智能合约开发、Web3 |
| [微信小程序开发者](engineering/engineering-wechat-mini-program-developer.md) ⭐ | WXML/WXSS、微信支付、云开发 | 微信小程序全栈开发 |
| [代码审查员](engineering/engineering-code-reviewer.md) | 代码审查、安全审计、质量把关 | PR 审查、代码质量 |
| [数据库优化师](engineering/engineering-database-optimizer.md) | Schema 设计、查询优化、索引策略 | 数据库性能调优 |
| [Git 工作流大师](engineering/engineering-git-workflow-master.md) | 分支策略、约定式提交、变基 | Git 工作流规范 |
| [软件架构师](engineering/engineering-software-architect.md) | 系统设计、DDD、架构决策 | 系统架构设计 |
| [SRE (站点可靠性工程师)](engineering/engineering-sre.md) | SLO、可观测性、混沌工程 | 站点可靠性工程 |
| [AI 数据修复工程师](engineering/engineering-ai-data-remediation-engineer.md) | 自愈管道、SLM 语义聚类、零数据丢失 | 大规模数据异常修复 |
| [飞书集成开发工程师](engineering/engineering-feishu-integration-developer.md) ⭐ | 飞书机器人、审批流、多维表格 | 飞书生态集成开发 |
| [钉钉集成开发工程师](engineering/engineering-dingtalk-integration-developer.md) ⭐ | 钉钉机器人、酷应用、连接器 | 钉钉生态集成开发 |
| [CMS 开发者](engineering/engineering-cms-developer.md) | Drupal/WordPress、主题开发、自定义插件 | CMS 站点开发与内容架构 |
| [邮件智能工程师](engineering/engineering-email-intelligence-engineer.md) | 邮件解析、结构化提取、AI 推理数据 | 智能体邮件集成 |
| [Filament 优化专家](engineering/engineering-filament-optimization-specialist.md) | Filament PHP 后台重构、高影响力改造 | PHP 后台管理优化 |

### 🎨 设计部

让产品好看、好用、有惊喜。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [UI 设计师](design/design-ui-designer.md) | 视觉设计、组件库、设计系统 | 界面设计、品牌一致性 |
| [UX 研究员](design/design-ux-researcher.md) | 用户测试、行为分析 | 用户研究、可用性测试 |
| [UX 架构师](design/design-ux-architect.md) | 信息架构、交互设计、导航系统 | 复杂产品的 UX 架构 |
| [品牌守护者](design/design-brand-guardian.md) | 品牌标识、一致性、定位 | 品牌策略、视觉规范 |
| [图像提示词工程师](design/design-image-prompt-engineer.md) | AI 图像生成、提示词优化 | Midjourney/DALL-E 出图 |
| [视觉叙事师](design/design-visual-storyteller.md) | 数据可视化、视觉叙事 | 信息图、演示文稿 |
| [趣味注入师](design/design-whimsy-injector.md) | 微交互、彩蛋、趣味元素 | 产品细节体验提升 |
| [包容性视觉专家](design/design-inclusive-visuals-specialist.md) | 多元化视觉、无障碍设计 | 包容性设计、全球化视觉 |

### 📢 营销部

一个真实互动一个粉丝地增长。

**国内平台：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [小红书运营专家](marketing/marketing-xiaohongshu-operator.md) ⭐ | 种草笔记、达人合作、爆款内容 | 小红书获客、品牌种草 |
| [抖音策略师](marketing/marketing-douyin-strategist.md) ⭐ | 短视频策划、算法优化、直播带货 | 抖音增长、短视频营销 |
| [微信公众号运营](marketing/marketing-wechat-operator.md) ⭐ | 公众号内容、社群运营、裂变增长 | 微信生态营销 |
| [B站内容策略师](marketing/marketing-bilibili-strategist.md) ⭐ | UP主运营、弹幕文化、中长视频 | B站内容增长、品牌合作 |
| [快手策略师](marketing/marketing-kuaishou-strategist.md) ⭐ | 下沉市场、老铁文化、直播电商 | 快手运营、社区信任 |
| [中国电商运营专家](marketing/marketing-china-ecommerce-operator.md) | 淘宝/拼多多/京东、广告投放、大促作战 | 电商全链路深度运营 |
| [电商运营师](marketing/marketing-ecommerce-operator.md) ⭐ | 淘宝/拼多多/京东、直播带货、大促 | 电商全平台运营（简洁版） |
| [百度 SEO 专家](marketing/marketing-baidu-seo-specialist.md) ⭐ | 百度优化、百科/知道/贴吧生态 | 百度搜索营销 |
| [私域流量运营师](marketing/marketing-private-domain-operator.md) ⭐ | 企微SCRM、社群运营、用户生命周期 | 私域体系搭建、复购增长 |
| [直播电商主播教练](marketing/marketing-livestream-commerce-coach.md) ⭐ | 直播话术、选品排品、千川投放 | 直播带货、主播孵化 |
| [跨境电商运营专家](marketing/marketing-cross-border-ecommerce.md) ⭐ | Amazon/Shopee/Lazada、海外仓、品牌出海 | 跨境电商全链路运营 |
| [短视频剪辑指导师](marketing/marketing-short-video-editing-coach.md) ⭐ | 剪映/PR/达芬奇、调色、音频、特效 | 短视频剪辑技术指导 |
| [微博运营策略师](marketing/marketing-weibo-strategist.md) ⭐ | 热搜运营、超话、舆情公关、粉丝经济 | 微博全链路运营 |
| [播客内容策略师](marketing/marketing-podcast-strategist.md) ⭐ | 小宇宙/喜马拉雅、音频制作、商业化 | 播客内容创作与增长 |
| [微信视频号运营策略师](marketing/marketing-weixin-channels-strategist.md) ⭐ | 视频号直播、社交裂变、私域闭环 | 视频号运营与变现 |
| [知识付费产品策划师](marketing/marketing-knowledge-commerce-strategist.md) ⭐ | 得到/知识星球/小鹅通、内容定价 | 知识付费产品运营 |
| [小红书专家](marketing/marketing-xiaohongshu-specialist.md) | 生活方式内容、趋势策略 | 小红书品牌建设 |
| [微信公众号管理](marketing/marketing-wechat-official-account.md) | 订阅者运营、内容营销 | 微信公众号增长 |
| [知乎策略师](marketing/marketing-zhihu-strategist.md) | 知识型内容、思想领袖建设 | 知乎品牌权威 |
| [中国市场本地化策略师](marketing/marketing-china-market-localization-strategist.md) ⭐ | 抖音/小红书/微信/B站全栈本地化 | 中国市场进入策略 |

> ⭐ 标记的是本项目原创，更贴合国内实操。其余为上游英文版翻译。

**出海营销：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [TikTok 策略师](marketing/marketing-tiktok-strategist.md) | 病毒式内容、算法优化 | 出海短视频营销 |
| [Twitter 互动官](marketing/marketing-twitter-engager.md) | 实时互动、思想领袖 | 出海品牌社交 |
| [Instagram 策展师](marketing/marketing-instagram-curator.md) | 视觉叙事、社区运营 | 出海视觉营销 |
| [Reddit 社区运营](marketing/marketing-reddit-community-builder.md) | 社区文化、真实互动 | 出海社区营销 |
| [应用商店优化师](marketing/marketing-app-store-optimizer.md) | ASO、转化优化 | App 出海推广 |
| [视频优化专家](marketing/marketing-video-optimization-specialist.md) | YouTube 算法、观众留存、跨平台分发 | 视频营销与 SEO |

**通用：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [增长黑客](marketing/marketing-growth-hacker.md) | 快速获客、病毒循环、实验 | 用户增长、转化优化 |
| [内容创作者](marketing/marketing-content-creator.md) | 多平台内容、编辑日历 | 内容策略、品牌故事 |
| [社交媒体策略师](marketing/marketing-social-media-strategist.md) | 跨平台策略、整合营销 | 全渠道社交运营 |
| [SEO 专家](marketing/marketing-seo-specialist.md) | 搜索引擎优化、技术 SEO | Google SEO、内容优化 |
| [轮播图增长引擎](marketing/marketing-carousel-growth-engine.md) | 轮播图内容、自动化投放 | 社交媒体轮播素材 |
| [LinkedIn 内容创作专家](marketing/marketing-linkedin-content-creator.md) | LinkedIn 职场内容、B2B 获客 | LinkedIn 品牌建设 |
| [图书联合作者](marketing/marketing-book-co-author.md) | 思想领袖力图书、代笔协作 | 图书策划与撰写 |
| [AI 引文策略师](marketing/marketing-ai-citation-strategist.md) | AEO/GEO 优化、AI 平台可见性审计 | AI 搜索引擎品牌可见性 |

### 💰 付费媒体部

精准投放，每一分预算都花在刀刃上。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [付费媒体审计师](paid-media/paid-media-auditor.md) | 广告账户审计、预算优化 | 广告效果诊断、降本增效 |
| [广告创意策略师](paid-media/paid-media-creative-strategist.md) | 广告素材策划、A/B 测试 | 广告创意优化 |
| [社交广告策略师](paid-media/paid-media-paid-social-strategist.md) | 社交平台广告投放 | Meta/TikTok/LinkedIn 广告 |
| [PPC 竞价策略师](paid-media/paid-media-ppc-strategist.md) | 搜索竞价、关键词管理 | Google Ads、百度推广 |
| [程序化广告采买专家](paid-media/paid-media-programmatic-buyer.md) | DSP、RTB、程序化购买 | 程序化广告投放 |
| [搜索词分析师](paid-media/paid-media-search-query-analyst.md) | 搜索词挖掘、否词优化 | 搜索广告精细化运营 |
| [追踪与归因专家](paid-media/paid-media-tracking-specialist.md) | 转化追踪、归因模型 | 广告效果衡量、数据打通 |

### 💼 销售部

从线索到成交，让每一单都有章法。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [客户拓展策略师](sales/sales-account-strategist.md) | 大客户拓展、ABM 策略 | 重点客户攻关 |
| [销售教练](sales/sales-coach.md) | 销售辅导、技能提升 | 团队销售能力建设 |
| [赢单策略师](sales/sales-deal-strategist.md) | 成交策略、MEDDPICC | 复杂销售推进 |
| [Discovery 教练](sales/sales-discovery-coach.md) | 需求挖掘、客户洞察 | 销售前期沟通 |
| [售前工程师](sales/sales-engineer.md) | 技术方案、Demo 演示 | 技术售前支持 |
| [Outbound 策略师](sales/sales-outbound-strategist.md) | 外呼策略、Cold outreach | 新客户开拓 |
| [Pipeline 分析师](sales/sales-pipeline-analyst.md) | 销售漏斗、预测分析 | 销售数据分析、预测 |
| [投标策略师](sales/sales-proposal-strategist.md) | 投标方案、提案撰写 | 招投标、方案竞标 |

### 🏦 金融部

让每一笔钱都清清楚楚。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [财务预测分析师](finance/finance-financial-forecaster.md) ⭐ | 收入预测、场景建模、现金流 | SaaS 财务规划、融资对接 |
| [发票管理专家](finance/finance-invoice-manager.md) ⭐ | 增值税发票、金税系统、三单匹配 | 发票全生命周期管理 |
| [金融风控分析师](finance/finance-fraud-detector.md) ⭐ | 交易风控、反洗钱、电信诈骗 | 支付风控、合规审查 |

### 👔 人力资源部

找对人、用好人、留住人。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [招聘专家](hr/hr-recruiter.md) ⭐ | Boss直聘/猎聘、校招社招、背调 | 招聘全流程管理 |
| [绩效管理专家](hr/hr-performance-reviewer.md) ⭐ | OKR/KPI、361分布、晋升答辩 | 绩效体系搭建与评估 |

### ⚖️ 法务部

合规是底线，风控是生命线。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [合同审查专家](legal/legal-contract-reviewer.md) ⭐ | 民法典合同编、电子签章、风险评估 | 合同审查与风控 |
| [制度文件撰写专家](legal/legal-policy-writer.md) ⭐ | PIPL/数据安全法、隐私政策 | 合规制度与政策撰写 |

### 🚚 供应链部

从工厂到用户，每一环都不掉链子。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [库存预测专家](supply-chain/supply-chain-inventory-forecaster.md) ⭐ | 需求预测、安全库存、618/双11备货 | 库存管理与补货优化 |
| [供应商评估专家](supply-chain/supply-chain-vendor-evaluator.md) ⭐ | 1688供应商、验厂、国标质检 | 供应商准入与分级管理 |
| [物流路线优化师](supply-chain/supply-chain-route-optimizer.md) ⭐ | 顺丰/通达系、冷链、跨境物流 | 物流成本优化与路线规划 |

### 📦 产品部

在正确的时间做正确的事。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [Sprint 排序师](product/product-sprint-prioritizer.md) | 敏捷规划、功能优先级 | Sprint 规划、资源分配 |
| [趋势研究员](product/product-trend-researcher.md) | 市场情报、竞品分析 | 市场调研、机会评估 |
| [反馈分析师](product/product-feedback-synthesizer.md) | 用户反馈分析、洞察提取 | 反馈分析、产品优先级 |
| [行为助推引擎](product/product-behavioral-nudge-engine.md) | 行为心理学、用户引导 | 用户行为设计、转化提升 |
| [产品经理](product/product-manager.md) | 产品全生命周期、PRD、路线图 | 产品策略与交付管理 |

### 📋 项目管理部

让项目按时按质交付。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [高级项目经理](project-management/project-manager-senior.md) | 需求拆解、范围管控 | 大型项目管理 |
| [项目牧羊人](project-management/project-management-project-shepherd.md) | 跨团队协调、进度跟踪 | 多团队项目协调 |
| [实验追踪员](project-management/project-management-experiment-tracker.md) | A/B 测试、实验管理 | 数据驱动决策 |
| [工作室制片人](project-management/project-management-studio-producer.md) | 创意项目管理、资源调度 | 内容/创意项目 |
| [工作室运营](project-management/project-management-studio-operations.md) | 工作室日常运营管理 | 团队运营效率 |
| [Jira 工作流管家](project-management/project-management-jira-workflow-steward.md) | Jira 配置、工作流优化 | Jira 项目管理 |

### 🧪 测试部

打破一切，让用户不必承受。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [证据收集者](testing/testing-evidence-collector.md) | 截图 QA、视觉验证 | UI 测试、Bug 文档 |
| [现实检验者](testing/testing-reality-checker.md) | 证据驱动认证、质量关卡 | 生产就绪评估 |
| [API 测试员](testing/testing-api-tester.md) | API 验证、集成测试 | 接口测试、端点验证 |
| [性能基准师](testing/testing-performance-benchmarker.md) | 性能测试、优化 | 压测、性能调优 |
| [无障碍审核员](testing/testing-accessibility-auditor.md) | WCAG 审核、辅助技术测试 | 无障碍合规、包容性设计 |
| [测试结果分析师](testing/testing-test-results-analyzer.md) | 测试数据分析、质量度量 | 质量趋势、发布决策 |
| [工具评估师](testing/testing-tool-evaluator.md) | 工具选型、功能对比 | 技术选型、工具采购 |
| [工作流优化师](testing/testing-workflow-optimizer.md) | 流程分析、自动化 | 效率提升、流程改进 |
| [嵌入式测试工程师](testing/testing-embedded-qa-engineer.md) ⭐ | HIL 测试、固件自动化测试、EMC 测试 | 嵌入式质量保障、量产测试 |

### 🤝 支持部

运营的中流砥柱。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [客服响应者](support/support-support-responder.md) | 客户服务、工单处理 | 客户支持、用户体验 |
| [数据分析师](support/support-analytics-reporter.md) | 数据分析、仪表盘 | 商业智能、KPI 追踪 |
| [法务合规员](support/support-legal-compliance-checker.md) | 合规审查、法规检查 | 法律合规、风险管理 |
| [高管摘要师](support/support-executive-summary-generator.md) | 业务摘要、战略沟通 | 高管汇报、决策支持 |
| [财务追踪员](support/support-finance-tracker.md) | 财务分析、预算管理 | 财务规划、成本管控 |
| [基础设施运维师](support/support-infrastructure-maintainer.md) | 系统运维、可靠性工程 | 基础设施管理、故障排查 |
| [招聘运营专家](support/support-recruitment-specialist.md) ⭐ | Boss直聘/猎聘、劳动法、校招社招 | 招聘全流程与HR合规 |
| [供应链采购策略师](support/support-supply-chain-strategist.md) ⭐ | 1688采购、质检、供应商管理、ERP | 供应链与采购管理 |

### 🔬 专项部

不走寻常路的专家。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [智能体编排者](specialized/agents-orchestrator.md) | 多智能体协调、工作流管理 | 复杂项目的多智能体协作 |
| [提示词工程师](specialized/prompt-engineer.md) ⭐ | LLM 提示词设计、优化、评测 | 提示词开发、AI 应用优化 |
| [身份信任架构师](specialized/agentic-identity-trust.md) | AI 身份验证、信任框架 | AI 系统安全与信任 |
| [数据整合师](specialized/data-consolidation-agent.md) | 多源数据整合、仪表盘 | 数据汇总与可视化 |
| [LSP 索引工程师](specialized/lsp-index-engineer.md) | 代码智能、语义索引 | 代码导航、IDE 集成 |
| [报告分发师](specialized/report-distribution-agent.md) | 报告分发、多渠道推送 | 自动化报告分发 |
| [销售数据提取师](specialized/sales-data-extraction-agent.md) | 销售数据采集、结构化 | CRM 数据处理 |
| [合规审计师](specialized/compliance-auditor.md) | SOC 2/ISO 27001/HIPAA 合规 | 合规审计、安全认证 |
| [应付账款智能体](specialized/accounts-payable-agent.md) | 发票处理、付款自动化 | 财务流程自动化 |
| [身份图谱操作员](specialized/identity-graph-operator.md) | 身份解析、多源匹配 | 用户身份治理 |
| [文化智能策略师](specialized/specialized-cultural-intelligence-strategist.md) | 文化洞察、跨文化设计 | 全球化产品、本地化策略 |
| [开发者布道师](specialized/specialized-developer-advocate.md) | 开发者关系、DX 工程 | 开发者社区、技术推广 |
| [模型 QA 专家](specialized/specialized-model-qa.md) | ML 模型审计、质量验证 | 模型上线前检查 |
| [ZK 管家](specialized/zk-steward.md) | Zettelkasten 知识管理 | 知识库构建、笔记系统 |
| [区块链安全审计师](specialized/blockchain-security-auditor.md) | 智能合约审计、漏洞检测 | 合约安全、DeFi 审计 |
| [留学规划顾问](specialized/study-abroad-advisor.md) ⭐ | 多国申请策略、选校定位 | 留学规划、文书指导 |
| [政务数字化售前顾问](specialized/government-digital-presales-consultant.md) ⭐ | 方案设计、标书、等保/信创 | 政务ToG项目售前 |
| [企业培训课程设计师](specialized/corporate-training-designer.md) ⭐ | ADDIE/SAM、企业学习平台、TTT | 培训体系搭建与课程开发 |
| [MCP 构建器](specialized/specialized-mcp-builder.md) | MCP 服务器、工具设计、API 集成 | MCP 开发、AI 工具扩展 |
| [文档生成器](specialized/specialized-document-generator.md) | PDF/PPTX/DOCX/XLSX 生成 | 程序化文档创建 |
| [工作流架构师](specialized/specialized-workflow-architect.md) | 工作流树设计、交接契约、故障恢复 | 系统流程规格化 |
| [自动化治理架构师](specialized/automation-governance-architect.md) | 自动化审计、n8n 工作流治理、风险评估 | 业务自动化决策 |
| [Salesforce 架构师](specialized/specialized-salesforce-architect.md) | Salesforce 多云设计、集成、数据模型 | 企业级 Salesforce 架构 |
| [医疗健康营销合规师](specialized/healthcare-marketing-compliance.md) ⭐ | 医疗广告法、NMPA、互联网医疗 | 医疗健康营销合规 |
| [高考志愿填报顾问](specialized/gaokao-college-advisor.md) ⭐ | 平行志愿、位次法、冲稳保策略 | 高考志愿填报规划 |
| [动态定价策略师](specialized/specialized-pricing-optimizer.md) ⭐ | 淘宝/京东/拼多多定价、大促机制 | 电商定价与促销策略 |
| [AI 治理政策专家](specialized/specialized-ai-policy-writer.md) ⭐ | 算法备案、生成式AI管理、伦理审查 | AI 合规与治理框架 |
| [企业风险评估师](specialized/specialized-risk-assessor.md) ⭐ | COSO本土化、国企风控、ESG | 企业风险管理与审计 |
| [会议效率专家](specialized/specialized-meeting-assistant.md) ⭐ | 飞书/钉钉/腾讯会议、OKR周会 | 会议管理与纪要输出 |
| [土木工程师](specialized/specialized-civil-engineer.md) | Eurocode/DIN/ACI/GB 多标准结构分析 | 土木与结构工程设计 |
| [法国咨询市场专家](specialized/specialized-french-consulting-market.md) | ESN/SI 生态、Malt 平台、薪资代管 | 法国自由职业市场导航 |
| [韩国商务专家](specialized/specialized-korean-business-navigator.md) | 품의流程、KakaoTalk 礼仪、层级关系 | 韩国商务文化导航 |
| [招聘专家](specialized/recruitment-specialist.md) ⭐ | 国内招聘平台、人才评估、劳动法合规 | 招聘运营与雇主品牌 |
| [技术翻译专家](specialized/technical-translator-agent.md) | 中英文双向翻译、编程/AI/云计算术语 | 技术文档翻译 |

### 🥽 空间计算部

构建下一代空间交互体验。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [visionOS 空间工程师](spatial-computing/visionos-spatial-engineer.md) | visionOS、SwiftUI 空间 UI | Apple Vision Pro 开发 |
| [macOS Metal 空间工程师](spatial-computing/macos-spatial-metal-engineer.md) | Metal、GPU 渲染 | macOS 高性能图形 |
| [XR 界面架构师](spatial-computing/xr-interface-architect.md) | 空间 UI 架构、交互设计 | XR 应用界面设计 |
| [XR 沉浸式开发者](spatial-computing/xr-immersive-developer.md) | WebXR、沉浸式体验 | VR/AR 应用开发 |
| [XR 座舱交互专家](spatial-computing/xr-cockpit-interaction-specialist.md) | 座舱 UI、多模态交互 | 汽车/航空 XR 交互 |
| [终端集成专家](spatial-computing/terminal-integration-specialist.md) | 终端模拟、系统集成 | 空间计算终端工具 |

### 🎮 游戏开发部

从独立游戏到 3A 大作，全引擎覆盖。

**通用：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [游戏设计师](game-development/game-designer.md) | 游戏机制、系统设计、平衡性 | 游戏核心玩法设计 |
| [关卡设计师](game-development/level-designer.md) | 关卡布局、节奏控制、空间叙事 | 关卡设计、场景构建 |
| [叙事设计师](game-development/narrative-designer.md) | 剧情设计、对话系统、世界观 | 游戏剧情、互动叙事 |
| [技术美术](game-development/technical-artist.md) | Shader、渲染管线、美术工具 | 画面效果、性能优化 |
| [游戏音频工程师](game-development/game-audio-engineer.md) | 音效设计、音频引擎、空间音频 | 游戏音效、配乐 |

**Unity：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [Unity 架构师](game-development/unity/unity-architect.md) | Unity 架构、ECS、性能优化 | Unity 项目架构 |
| [Unity 编辑器工具开发者](game-development/unity/unity-editor-tool-developer.md) | 编辑器扩展、自定义工具 | Unity 工具链开发 |
| [Unity 多人游戏工程师](game-development/unity/unity-multiplayer-engineer.md) | Netcode、同步、网络架构 | Unity 联机游戏 |
| [Unity Shader Graph 美术师](game-development/unity/unity-shader-graph-artist.md) | Shader Graph、URP/HDRP | Unity 视觉效果 |

**Unreal Engine：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [Unreal 多人游戏架构师](game-development/unreal-engine/unreal-multiplayer-architect.md) | Replication、网络同步 | UE 联机架构 |
| [Unreal 系统工程师](game-development/unreal-engine/unreal-systems-engineer.md) | Gameplay 框架、C++ 系统 | UE 核心系统开发 |
| [Unreal 技术美术](game-development/unreal-engine/unreal-technical-artist.md) | 材质、Niagara、渲染管线 | UE 画面与性能 |
| [Unreal 世界构建师](game-development/unreal-engine/unreal-world-builder.md) | 开放世界、地形、关卡串流 | UE 场景构建 |

**Blender：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [Blender 插件工程师](game-development/blender/blender-addon-engineer.md) | Python 插件、资源验证、导出自动化 | Blender 管线工具开发 |

**Godot：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [Godot 游戏脚本开发者](game-development/godot/godot-gameplay-scripter.md) | GDScript、场景树、信号系统 | Godot 游戏逻辑 |
| [Godot 多人游戏工程师](game-development/godot/godot-multiplayer-engineer.md) | MultiplayerAPI、网络同步 | Godot 联机游戏 |
| [Godot Shader 开发者](game-development/godot/godot-shader-developer.md) | Godot Shader Language、视觉效果 | Godot 画面效果 |

**Roblox Studio：**

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [Roblox 虚拟形象创作者](game-development/roblox-studio/roblox-avatar-creator.md) | 虚拟形象、UGC 资产 | Roblox 角色设计 |
| [Roblox 体验设计师](game-development/roblox-studio/roblox-experience-designer.md) | 体验设计、游戏循环 | Roblox 游戏设计 |
| [Roblox 系统脚本工程师](game-development/roblox-studio/roblox-systems-scripter.md) | Luau 脚本、数据存储 | Roblox 游戏开发 |

### 📖 学术部

为叙事设计、世界构建和文化研究提供学术级支撑。

| 智能体 | 专长 | 适用场景 |
|--------|------|----------|
| [人类学家](academic/academic-anthropologist.md) | 文化体系、仪式、民族志 | 世界观设计、文化构建 |
| [地理学家](academic/academic-geographer.md) | 自然与人文地理、空间分析 | 地图构建、场景设计 |
| [历史学家](academic/academic-historian.md) | 历史分析、史料考证 | 历史题材验证、年代设定 |
| [叙事学家](academic/academic-narratologist.md) | 叙事理论、故事结构 | 剧情设计、角色弧线 |
| [心理学家](academic/academic-psychologist.md) | 行为心理、人格理论 | 角色心理塑造、动机设计 |
| [学习规划师](academic/academic-study-planner.md) ⭐ | 考研/考公/法考备考、学习方法论 | 个性化学习计划与备考规划 |

### 🎯 战略部

从发现到运营的全流程战略指导。详见 [strategy/](strategy/) 目录。

| 文档 | 内容 |
|------|------|
| [高管简报](strategy/EXECUTIVE-BRIEF.md) | NEXUS 战略概览 |
| [快速上手](strategy/QUICKSTART.md) | 5 分钟上手指南 |
| [完整战略](strategy/nexus-strategy.md) | 运营纲领全文 |
| [智能体激活提示词](strategy/coordination/agent-activation-prompts.md) | 各智能体的激活指令 |
| [交接模板](strategy/coordination/handoff-templates.md) | 智能体间的交接规范 |
| Phase 0-6 Playbooks | [发现](strategy/playbooks/phase-0-discovery.md) · [策略](strategy/playbooks/phase-1-strategy.md) · [基础](strategy/playbooks/phase-2-foundation.md) · [构建](strategy/playbooks/phase-3-build.md) · [加固](strategy/playbooks/phase-4-hardening.md) · [上线](strategy/playbooks/phase-5-launch.md) · [运营](strategy/playbooks/phase-6-operate.md) |
| 场景 Runbook | [创业 MVP](strategy/runbooks/scenario-startup-mvp.md) · [企业功能](strategy/runbooks/scenario-enterprise-feature.md) · [事故响应](strategy/runbooks/scenario-incident-response.md) · [营销活动](strategy/runbooks/scenario-marketing-campaign.md) |

---

## 工具集成

支持 **16 种主流 AI 编程工具**，通过 `scripts/` 目录下的脚本实现格式转换和一键安装。

### 支持的工具

| 工具 | 安装位置 | 类型 |
|------|----------|------|
| **OpenClaw** ⭐ | `~/.openclaw/agency-agents/` | 全局，需转换 |
| **Claude Code** | `~/.claude/agents/` | 全局，直接复制 |
| **GitHub Copilot** | `~/.github/agents/` + `~/.copilot/agents/` | 全局，直接复制 |
| **Kiro** (Amazon) | `~/.kiro/agents/` | 全局，需转换 |
| **Antigravity** | `~/.gemini/antigravity/skills/` | 全局，需转换 |
| **Gemini CLI** | `~/.gemini/extensions/agency-agents/` | 全局，需转换 |
| **Qwen Code** | `.qwen/agents/` | 项目级，需转换 |
| **Cursor** | `.cursor/rules/` | 项目级，需转换 |
| **Trae** | `.trae/rules/` | 项目级，需转换 |
| **OpenCode** | `.opencode/agents/` | 项目级，需转换 |
| **Aider** | `CONVENTIONS.md` | 项目级，需转换 |
| **Windsurf** | `.windsurfrules` | 项目级，需转换 |
| **Codex CLI** | `.codex/agents/` | 项目级，需转换 |
| **WorkBuddy** (腾讯) | `~/.workbuddy/skills/` | 全局，需转换 |
| **Hermes Agent** (NousResearch) | `~/.hermes/skills/` | 全局，需转换 |
| **DeerFlow 2.0** (字节跳动) | `skills/custom/` | 项目级，需转换 |

### 使用方法

```bash
# 第一步：转换格式（Claude Code 和 GitHub Copilot 可跳过此步）
./scripts/convert.sh                    # 转换为所有工具格式
./scripts/convert.sh --tool cursor      # 只转换 Cursor 格式

# 第二步：安装到本地
./scripts/install.sh                    # 自动检测并安装
./scripts/install.sh --tool cursor      # 安装到指定工具

# 检查智能体文件格式
./scripts/lint-agents.sh
```

### 各工具安装说明

<details open>
<summary><strong>⭐ OpenClaw（推荐）</strong></summary>

OpenClaw 会将每个智能体拆分为三个文件，天然支持多智能体协作：
- `SOUL.md` — 身份、记忆、沟通风格、关键规则
- `AGENTS.md` — 核心使命、技术交付物、工作流程
- `IDENTITY.md` — 名称与简介

```bash
./scripts/convert.sh --tool openclaw
./scripts/install.sh --tool openclaw

# 安装后重启 OpenClaw 网关
openclaw gateway restart
```
</details>

<details>
<summary><strong>Claude Code</strong></summary>

智能体直接从仓库复制到 `~/.claude/agents/`，无需转换。

```bash
./scripts/install.sh --tool claude-code
```

在 Claude Code 中激活：
```
激活前端开发者模式，帮我审查这个组件。
```
</details>

<details>
<summary><strong>GitHub Copilot</strong></summary>

智能体直接从仓库复制到 `~/.github/agents/` 和 `~/.copilot/agents/`，无需转换。

```bash
./scripts/install.sh --tool copilot
```

在 GitHub Copilot 中激活：
```
使用前端开发者智能体帮我审查这个组件。
```
</details>

<details>
<summary><strong>Antigravity (Gemini)</strong></summary>

转换为 Antigravity skill 格式并安装到 `~/.gemini/antigravity/skills/`。

```bash
./scripts/convert.sh --tool antigravity
./scripts/install.sh --tool antigravity
```
</details>

<details>
<summary><strong>Gemini CLI</strong></summary>

转换为 Gemini CLI 扩展格式并安装到 `~/.gemini/extensions/agency-agents/`。

```bash
./scripts/convert.sh --tool gemini-cli
./scripts/install.sh --tool gemini-cli
```
</details>

<details>
<summary><strong>Qwen Code</strong></summary>

转换为 Qwen Code SubAgent 格式并安装到项目目录 `.qwen/agents/`。

```bash
./scripts/convert.sh --tool qwen
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool qwen
```

在 Qwen Code 中激活：
```
使用前端开发者智能体帮我审查这个组件。
```

> 提示：安装后在 Qwen Code 中运行 `/agents manage` 刷新，或重启会话。
</details>

<details>
<summary><strong>Cursor</strong></summary>

每个智能体会变成一个 `.mdc` 规则文件，安装到项目目录 `.cursor/rules/`。

Cursor 使用 **"智能匹配"模式**（`alwaysApply: false`）：AI 根据每个规则的 `description` 字段自动判断是否相关，相关时自动引用完整内容。

**安装：**
```bash
# 第一步：转换格式（在仓库目录运行）
./scripts/convert.sh --tool cursor

# 第二步：安装到项目（在你的项目目录运行）
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool cursor
```

**⚠️ 重要：建议精选安装**

全部安装 186 个规则会导致 Cursor 需要扫描大量 description 来判断相关性，**可能影响匹配准确度**。推荐做法：

```bash
# 方法一：全量安装后删除不需要的
/path/to/agency-agents-zh/scripts/install.sh --tool cursor
# 然后手动删除 .cursor/rules/ 中不需要的 .mdc 文件，保留 10-20 个常用的

# 方法二：只复制你需要的智能体（转换后）
./scripts/convert.sh --tool cursor
mkdir -p /your/project/.cursor/rules
cp integrations/cursor/rules/engineering-frontend-developer.mdc /your/project/.cursor/rules/
cp integrations/cursor/rules/engineering-code-reviewer.mdc /your/project/.cursor/rules/
# ... 按需复制
```

**安装后如何使用：**

1. 安装后 `.cursor/rules/` 中的 `.mdc` 文件会自动被 Cursor 识别
2. 在 Chat 或 Composer 中正常提问，Cursor **自动匹配**相关智能体：
   ```
   帮我审查这个组件的性能问题   → 自动匹配前端开发者
   这段代码有安全漏洞吗         → 自动匹配安全审计员
   ```
3. 也可以在 **Cursor Settings**（`Cmd+,`）→ **Rules** → **Project Rules** 中查看所有规则
4. 还可以在 Chat 中用 `@规则名` 手动指定引用某个智能体

> **排查**：如果看不到规则，确认 `.cursor/rules/` 在项目根目录、文件扩展名是 `.mdc`、已重新打开项目。
</details>

<details>
<summary><strong>Trae</strong></summary>

转换为 Trae rule 文件并安装到项目目录 `.trae/rules/`。格式与 Cursor 类似。

```bash
./scripts/convert.sh --tool trae
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool trae
```
</details>

<details>
<summary><strong>OpenCode</strong></summary>

转换为 OpenCode agent 文件并安装到项目目录 `.opencode/agents/`。

```bash
./scripts/convert.sh --tool opencode
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool opencode
```
</details>

<details>
<summary><strong>Aider</strong></summary>

所有智能体编译为单个 `CONVENTIONS.md` 文件，Aider 会自动读取。

```bash
./scripts/convert.sh --tool aider
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool aider
```

在 Aider 会话中激活：
```
使用前端开发者智能体帮我重构这个组件。
```
</details>

<details>
<summary><strong>Windsurf</strong></summary>

所有智能体编译为单个 `.windsurfrules` 文件。

```bash
./scripts/convert.sh --tool windsurf
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool windsurf
```
</details>

<details>
<summary><strong>Codex CLI</strong></summary>

转换为 OpenAI Codex CLI agent 文件（TOML 格式）并安装到项目目录 `.codex/agents/`。

```bash
./scripts/convert.sh --tool codex
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool codex
```

在 Codex 中使用时，智能体会作为 subagent 被调用。也可以在 `AGENTS.md` 中引用。
</details>

<details>
<summary><strong>Kiro (Amazon)</strong></summary>

Amazon 的 Spec 驱动 AI IDE，基于 Claude 模型。每个智能体转换为 JSON 配置 + 提示词文件，安装到 `~/.kiro/agents/`（全局）。

```bash
./scripts/convert.sh --tool kiro
./scripts/install.sh --tool kiro
```

在 Kiro 中切换智能体：
```
/agent swap
```

或启动时直接指定：
```bash
kiro-cli --agent engineering-frontend-developer
```
</details>

<details>
<summary><strong>WorkBuddy (腾讯)</strong></summary>

腾讯推出的全场景 AI 桌面智能体，兼容 OpenClaw 技能，支持多模型切换。每个智能体转换为 `SKILL.md` 技能文件，安装到 `~/.workbuddy/skills/`（全局）。

```bash
./scripts/convert.sh --tool workbuddy
./scripts/install.sh --tool workbuddy
```

安装后重启 WorkBuddy 即可在技能列表中看到所有智能体。
</details>

<details>
<summary><strong>Hermes Agent (NousResearch)</strong></summary>

NousResearch 的开源 AI 智能体框架，支持技能系统、子代理编排、会话记忆。每个智能体转换为 `SKILL.md` 技能文件，按分类目录安装到 `~/.hermes/skills/`（全局）。

```bash
./scripts/convert.sh --tool hermes
./scripts/install.sh --tool hermes
```

安装后**推荐在 Hermes CLI** 中通过 `hermes skills` 查看和管理所有技能，或在对话中自然语言激活。

> ⚠️ **Discord 模式下不要一次性全量安装**
>
> Hermes 的 Discord 集成会把每一个 skill 注册成 Discord 斜杠命令，Discord API 对 bot 所有命令的 JSON 序列化总长度有 **8000 字符硬上限**，超过后会返回 `error code 50035`（见 [issue #45](https://github.com/jnMetaCode/agency-agents-zh/issues/45)）。本仓库有近 200 个 skill，一次装全会直接炸 Discord。
>
> 解决办法：在 Discord 中使用时请按**分类**分批安装，用 `--category` 参数（可多次传入）：
>
> ```bash
> # 只装 marketing 分类
> ./scripts/install.sh --tool hermes --category marketing
>
> # 同时装 engineering 和 design
> ./scripts/install.sh --tool hermes --category engineering --category design
> ```
>
> 可选分类：`academic, blender, design, engineering, finance, game-development, godot, hr, legal, marketing, paid-media, product, project-management, roblox-studio, sales, spatial-computing, specialized, supply-chain, support, testing, unity, unreal-engine`。
>
> Hermes CLI 本身没有此限制，全量安装可以继续使用。
</details>

<details>
<summary><strong>DeerFlow 2.0 (字节跳动)</strong></summary>

字节跳动的开源 SuperAgent 框架，支持子代理、沙箱、持久记忆。每个智能体转换为 `SKILL.md` 技能文件。

```bash
./scripts/convert.sh --tool deerflow
./scripts/install.sh --tool deerflow
```

默认安装到当前目录的 `skills/custom/`。可通过环境变量自定义路径：

```bash
DEERFLOW_SKILLS_DIR=/path/to/deerflow/skills/custom ./scripts/install.sh --tool deerflow
```

安装后在 DeerFlow 的任务中，相关技能会自动加载。
</details>

### 修改智能体后重新生成

添加新智能体或编辑现有智能体后，重新生成集成文件：

```bash
./scripts/convert.sh               # 重新生成所有工具
./scripts/convert.sh --tool cursor  # 只重新生成指定工具
```

---

## 🇨🇳 中国市场原创智能体

除翻译外，本项目包含 **46 个原创智能体**，专为中国平台和业务场景打造：

- **平台运营**：小红书、抖音、微信公众号/视频号/小程序、B站、快手、微博、知乎
- **企业协作**：飞书、钉钉集成开发
- **垂直领域**：跨境电商、政务ToG、医疗合规、高考志愿、留学规划
- **业务支撑**：私域流量、直播电商、库存预测、合同审查、发票管理

> 在上方智能体阵容中标有 ⭐ 的即为原创智能体。

---

## 实战案例

### 场景一：出海产品 MVP

**你的团队**：
1. **前端开发者** — 构建 React 应用
2. **后端架构师** — 设计 API 和数据库
3. **增长黑客** — 规划用户获取
4. **快速原型师** — 快速迭代
5. **现实检验者** — 上线前质量把关

### 场景二：[小红书品牌推广](examples/workflow-xiaohongshu-launch.md)（完整流程）

**你的团队**：
1. **小红书运营专家** — 种草内容策略和达人合作
2. **内容创作者** — 产出种草笔记
3. **品牌守护者** — 品牌调性把关
4. **数据分析师** — 追踪投放数据、出复盘报告
5. **增长黑客** — 设计转化和裂变路径

---

## 贡献

欢迎参与！翻译智能体、改进内容、新增中国平台智能体都行。详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

---

## 交流 · Community

微信公众号 **「AI不止语」**（微信搜索 `AI_BuZhiYu`）— 技术问答 · 项目更新 · 实战文章

| 渠道 | 加入方式 |
|------|---------|
| QQ 群 | [点击加入](https://qm.qq.com/q/EeNQA9xCxy)（群号 1071280067） |
| 微信群 | 关注公众号后回复「群」获取入群方式 |

---

## 姊妹项目

| 项目 | 说明 |
|------|------|
| [ai-coding-guide](https://github.com/jnMetaCode/ai-coding-guide) | AI 编程工具实战指南 — 66 个 Claude Code 技巧 + 9 款工具最佳实践 + 可复制配置模板 |
| [agency-orchestrator](https://github.com/jnMetaCode/agency-orchestrator) | 🚀 多智能体编排引擎 — 一句话调度 211+ 角色自动协作，DAG 并行执行，6 种免费 LLM + 3 种 API，32 个现成模板 |
| [superpowers-zh](https://github.com/jnMetaCode/superpowers-zh) | AI 编程超能力 · 中文版 — 20 个 skills，让你的 AI 编程助手真正会干活 |
| [shellward](https://github.com/jnMetaCode/shellward) | AI 智能体安全中间件 — 注入检测、数据防泄露、命令安全、零依赖、MCP Server |

---

## 致谢

- 原始英文版：[msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents)（MIT 协议）
- 感谢原作者 [@msitarzewski](https://github.com/msitarzewski) 创建了这个优秀的项目

---

## 许可证

MIT License — 自由使用，商业或个人均可。

---

<div align="center">

**211 个 AI 专家角色，16 种工具支持，即装即用**

[⭐ Star 本项目](https://github.com/jnMetaCode/agency-agents-zh) · [提交 Issue](https://github.com/jnMetaCode/agency-agents-zh/issues) · [贡献代码](https://github.com/jnMetaCode/agency-agents-zh/pulls)

基于 [agency-agents](https://github.com/msitarzewski/agency-agents) 翻译并本土化

</div>

---

## ⭐ Star 趋势

[![Star History Chart](https://api.star-history.com/svg?repos=jnMetaCode/agency-agents-zh&type=Date)](https://star-history.com/#jnMetaCode/agency-agents-zh&Date)
