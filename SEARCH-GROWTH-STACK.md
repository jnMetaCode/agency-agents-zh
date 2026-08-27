# Search Growth Stack — SEO / GEO / AEO / Agentic Search

本文件是 `agency-agents-zh` 中搜索增长相关 Agent 的专用索引，用于快速选择正确角色并避免职责重叠。

> 核心原则：不要把 SEO、GEO、AEO 和浏览型 Agent 优化混成一个“AI SEO”概念。它们共享技术与内容基础，但目标、测量口径和验证方法不同。

---

## 1. SEO 与自然搜索增长专家

文件：`marketing/marketing-seo-specialist.md`

### 负责

- Google Search 抓取与索引
- Technical SEO
- Search Demand / Keyword / Intent
- 内容架构与 Topic Cluster
- Internal Linking
- Structured Data 治理
- Authority / Digital PR 协同
- Google AI Overviews / AI Mode 的 Search 基础
- Search Console / GA4 / Lead / Revenue 归因

### 不负责

- 把 ChatGPT/Claude/Perplexity 单次回答当排名结果
- 保证 AI Citation
- 训练爬虫授权决策
- 浏览型 Agent 自动完成购买/预约任务

---

## 2. AI 搜索可见性与 GEO 策略师

文件：`marketing/marketing-ai-citation-strategist.md`

### 负责

- ChatGPT / Claude / Gemini/Google AI Search / Perplexity 可见性
- Prompt Universe / Prompt Family
- Prompt Provenance
- Mention Rate
- Recommendation Rate
- Owned Citation / Earned Citation
- Lost Prompt
- Source Graph
- Competitor AI Share of Voice
- 多次独立 Run 与 snapshot / stable measurement 区分
- AI Referral / Conversion

### 不负责

- 把 Schema 当固定 Citation 因果
- 虚构行业 Citation benchmark
- 用单次截图宣称 GEO 成功/失败
- 把训练 Bot 与 Search Bot 混为一谈

---

## 3. AEO 基础架构师

文件：`marketing/marketing-aeo-foundations.md`

### 负责

- Search / User-triggered / Training crawler 边界
- robots.txt
- noindex / canonical / HTTP status
- WAF / CDN / Bot Management
- JavaScript / Renderability / Parseability
- crawler logs
- OpenAI / Anthropic / Perplexity / Google 的访问策略核查
- 可选 discovery assets 的平台支持验证

### 特别规则

- `llms.txt` 不是 Google Search / AI Overview 必需项
- 不设跨平台固定 token budget
- 不默认所有 AI Bot 全部 Allow
- `GPTBot` ≠ `OAI-SearchBot`
- `ClaudeBot` ≠ `Claude-SearchBot`
- `Google-Extended` ≠ Google Search 排名开关

---

## 4. 搜索增长编排器

文件：`marketing/marketing-search-growth-orchestrator.md`

### 负责

根据任务自动判断：

- SEO-only
- GEO-only
- SEO + GEO
- AEO Foundation
- Agentic Search handoff

并统一：

- Evidence State
- Business Impact
- Confidence
- Effort
- Validation
- 90-day backlog
- Lead / Revenue attribution

推荐把它作为大型客户项目的入口 Agent。

---

## 5. 智能搜索优化师 / Agentic Search

文件：`marketing/marketing-agentic-search-optimizer.md`

### 目标

关注 AI 浏览型 Agent 是否能真正完成业务任务，例如：

- 填表
- 注册
- 预约
- 购买
- 下载
- 结账

它与 SEO/GEO 的主要区别是：

- SEO：用户/搜索系统能否找到页面
- GEO：AI 回答是否提及、推荐、引用品牌
- Agentic：AI Agent 能否完成任务

涉及具体 Agent 协议和浏览器能力时，必须核对当前标准/草案与浏览器实际支持情况，不得把实验协议冒充已普及标准。

---

# 推荐调用路径

## 网站完全没做过搜索增长

```text
AEO Foundations
      ↓
SEO Specialist
      ↓
GEO Strategist
      ↓
Search Growth Orchestrator
      ↓
Measurement / Iteration
```

## 已有成熟 SEO，想进入 AI Search

```text
AEO quick audit
      ↓
GEO baseline
      ↓
Lost Prompt + Source Graph
      ↓
SEO/GEO shared fix pack
      ↓
Recheck + AI referral attribution
```

## B2B SaaS / 企业服务

```text
Search Growth Orchestrator
      ├── SEO: commercial demand + comparison/use-case pages
      ├── GEO: recommendation prompts + third-party sources
      ├── AEO: crawler/access verification
      └── Authority: PR / reviews / research / case studies
```

## 电商

```text
SEO: product/category/search demand
GEO: product recommendation / comparison prompts
AEO: crawler + product content accessibility
Agentic: purchase / checkout task completion
```

---

# 统一证据等级

整个 Search Growth Stack 优先使用：

- `VERIFIED`
- `PROVIDED`
- `OBSERVED`
- `INFERRED`
- `HYPOTHESIS`
- `UNKNOWN`

任何 Agent 都不得把 `INFERRED` / `HYPOTHESIS` / `UNKNOWN` 写成确定事实。

---

# 商业化交付建议

可以把这套 Agent 包装成三个客户产品：

### Search Foundation Audit

AEO + Technical SEO

检查：crawler、robots、indexability、WAF/CDN、网站结构和测量基础。

### AI Search Visibility Audit

GEO + SEO

检查：Prompt visibility、Mention、Recommendation、Citation、Source Graph、Lost Prompt 和竞争品牌。

### Search Everywhere Retainer

Orchestrator + SEO + GEO + AEO + Authority + Analytics

持续执行：

- Technical fixes
- Content strategy
- AI visibility measurement
- Digital PR / authority
- Conversion / revenue attribution
- Monthly recheck

---

# 回归评测

相关 eval：

- `evals/marketing/seo-specialist-v2.md`
- `evals/marketing/ai-citation-strategist-v2.md`
- `evals/marketing/aeo-foundations-v2.md`

在修改这些 Agent 的核心规则后，应重新检查对应 eval，重点防止：

- 私有数据幻觉
- 平台 crawler 混淆
- Schema 因果神话
- 固定 Citation uplift
- 固定 token budget
- llms.txt 必需论
- 单次 AI 回答当稳定指标
- 时间先后被误写成因果
