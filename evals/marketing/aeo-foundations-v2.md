# AEO Foundations v2 — Evaluation Fixtures

## Purpose

测试 AEO 基础架构师是否能区分搜索、用户触发检索、训练抓取和可选 discovery 资产，并避免把社区提案或固定阈值当作平台事实。

---

## Case 1 — llms.txt as a Google requirement

**User:**  
“为了进 Google AI Overview，我们必须先做 llms.txt，对吧？”

**Pass conditions:**
- 明确拒绝“Google Search 必须使用 llms.txt”的说法。
- 说明 Google Search / AI Overviews 的基础仍是普通 Search 抓取、索引、质量和 Search eligibility。
- 只有在其他目标系统有明确支持或实验目的时，才把 llms.txt 作为可选资产。

**Critical failure:**
- 声称 llms.txt 会直接提升 Google 排名、AI Overview 收录或 citation rate。

---

## Case 2 — GPTBot confusion

**User:**  
“我们屏蔽 GPTBot 以后，ChatGPT Search 肯定就看不到我们了吧？”

**Pass conditions:**
- 区分 `GPTBot` 与 `OAI-SearchBot`。
- 不把训练 opt-out 等同于 Search opt-out。
- 建议核对当前 OpenAI 官方 crawler 文档与实际 robots/log evidence。

---

## Case 3 — Claude crawler confusion

**User:**  
“ClaudeBot 就是 Claude 搜索爬虫，所以训练和搜索只能一起开或一起关。”

**Pass conditions:**
- 区分 `ClaudeBot`、`Claude-SearchBot`、`Claude-User`。
- 说明可分别做训练、搜索和用户触发访问策略。

---

## Case 4 — Google-Extended confusion

**User:**  
“把 Google-Extended Disallow 掉，就可以禁止 AI Overviews 展示我们，同时普通搜索排名不受影响，对吧？”

**Pass conditions:**
- 不把 Google-Extended 描述为 AI Overviews / AI Mode 的直接 Search inclusion 开关。
- 把 Google Search visibility 放回 Googlebot/Search 控制与当前 Search Console 官方能力中判断。
- 要求核对最新 Google 官方说明。

---

## Case 5 — Fixed token budget

**User:**  
“落地页超过 8,000 token AI 就不会引用，是不是应该全部压到 8K 以下？”

**Pass conditions:**
- 拒绝跨平台固定 token 上限。
- 不把 LLM context window 等同于 crawler 页面处理上限。
- 按用户需求、信息架构和真实平台测试决定是否拆分内容。

---

## Case 6 — Mandatory discovery files

**User:**  
“客户缺少 llms-full.txt、AGENTS.md、agent-permissions.json 和 mcp-actions.json，这算四个 P0 吗？”

**Pass conditions:**
- 不自动判定 P0/P1。
- 要求先确认目标平台是否支持、客户是否需要。
- 将没有明确采用证据的资产视为 optional / experimental。
- Agent task 能力应移交 Agentic Search workflow。

---

## Case 7 — Robots default allow-all

**User:**  
“做 GEO 就把所有 AI Bot 全部 Allow 最保险吧？”

**Pass conditions:**
- 不默认全部放行。
- 区分 Search、User-triggered、Training 等用途。
- 要求结合版权、隐私、法务、带宽和增长目标做授权决策。

---

## Case 8 — User-Agent spoofing

**User:**  
“日志里出现 GPTBot 字符串，所以这肯定是 OpenAI 官方爬虫。”

**Pass conditions:**
- 指出 User-Agent 可以伪造。
- 高风险判断应结合官方验证方法、网络证据或其他日志信号（如平台提供）。

---

## Case 9 — JavaScript absolute rule

**User:**  
“关掉 JavaScript 页面没有正文，所以所有 AI 搜索肯定抓不到。”

**Pass conditions:**
- 拒绝绝对结论。
- 说明不同系统渲染能力不同。
- 要求测试目标系统、HTML/渲染结果和日志，而不是只做 no-JS 推断。

---

## Case 10 — FAQ Schema as AEO requirement

**User:**  
“每个页面都加 FAQ Schema，能提高 AI 引用率和 Google 富结果，对吧？”

**Pass conditions:**
- 不承诺 AI citation uplift。
- Structured Data 必须与页面内容和目标平台当前支持范围一致。
- 不把已废弃/不展示的 Rich Result 当作收益承诺。

---

## Case 11 — Fake foundation score

**User:**  
“没有 llms.txt、没有 ClaudeBot Allow、没有 Markdown 端点，所以我们 AEO 基础分只有 25%，对吗？”

**Pass conditions:**
- 不接受没有定义权重、业务目标和平台范围的百分制。
- 使用 Access Matrix、Evidence State、Priority 和实际目标平台结果替代伪精确评分。

---

## Case 12 — Implementation is not validation

**User:**  
“robots.txt 已改成 Allow，所以现在 ChatGPT/Claude/Perplexity 都一定能引用我们了。”

**Pass conditions:**
- 明确区分配置实施与真实平台结果。
- 要求 HTTP/WAF/CDN/log/实际查询等验证。
- 不保证 Citation / Recommendation。

---

## Critical failures

以下任一情况视为严重失败：

- 把训练 Bot 和搜索 Bot 混为一谈
- 声称 llms.txt 是 Google Search / AI Overview 必需项
- 固定 token budget 被当作跨平台事实
- 缺少可选 discovery 文件被自动判为 P0
- 自动建议所有 AI Bot 全部放行
- Structured Data 被描述为固定 Citation 提升手段
- 无验证证据即宣布 crawler / citation 修复成功
