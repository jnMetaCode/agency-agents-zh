# agency-agents 中文版（AI 智能體專家團隊）繁體中文

🌐 [簡體中文](README.md) | **繁體中文** | [English (upstream)](https://github.com/msitarzewski/agency-agents)

> **328 個即插即用的 AI 專家角色** — 覆蓋公司經營（CEO/CTO/CMO/COO/CPO/CFO）、工程、設計、營銷、產品、遊戲、安全、GIS、金融等 22 個部門。不是通用提示詞模板，每個智能體都有獨立的人設、專業流程和可交付成果。支援 Claude Code / Cursor / Copilot 等 20 種 AI 程式設計工具。

[agency-agents](https://github.com/msitarzewski/agency-agents) 的中文社群版。在已有上游翻譯的基礎上，新增了 67 個中國市場原創智能體（小紅書、抖音、微信、B站、飛書、釘釘等平臺運營，以及跨境電商、政務ToG、醫療合規、Qt 工業上位機、機械設計、畜禽養殖檔案核對等垂直領域）。

想更好地用起來，或想給團隊打造統一的智能體工作臺？[下載桌面客戶端](https://github.com/jnMetaCode/agency-orchestrator/releases/latest)（原生 App，免裝 Node，macOS / Windows / Linux），或線上體驗 [ao.aiolaola.com/experts](https://ao.aiolaola.com/experts)。

[![GitHub stars](https://img.shields.io/github/stars/jnMetaCode/agency-agents-zh?style=social)](https://github.com/jnMetaCode/agency-agents-zh)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)
[![npm](https://img.shields.io/npm/v/agency-agents-zh?color=cb3837&logo=npm)](https://www.npmjs.com/package/agency-agents-zh)
[![桌面客戶端](https://img.shields.io/badge/桌面客戶端-macOS%20%7C%20Windows%20%7C%20Linux-2563eb?logo=github)](https://github.com/jnMetaCode/agency-orchestrator/releases/latest)
[![線上體驗](https://img.shields.io/badge/線上體驗-ao.aiolaola.com-8b5cf6)](https://ao.aiolaola.com/experts)


> 🧠 **新：讓 Claude Code / Codex / Cursor / Gemini CLI 不再失憶** → [engram](https://github.com/jnMetaCode/engram)：一條 `npx @jnmetacode/engram install`，自動記住每次會話問過什麼、改了哪些檔案、最後怎麼解決的，下次開會話自動帶回（帶出處）。**記憶跨工具共享**——Codex 裡定的事，Claude Code 也知道。全本地、零依賴、中文友好。

### 📊 專案規模

| 🤖 AI 智能體 | 🌏 英文版翻譯 | 🇨🇳 中國市場原創 | 🧠 支援工具 | 🏢 部門 |
|:---:|:---:|:---:|:---:|:---:|
| **328** | **261** | **67** | **20 種** | **22 個** |

> 📖 **官方配套課程** → [AI 專家團隊實戰](https://aiolaola.com/course/ai-agency?utm_source=github&utm_campaign=agents)（35 節，免費）：手把手把這倉 328 位專家用成一支團隊——單兵點名、自動組隊、一人公司全流程，桌面端零程式碼教學。另有 [從零學會 AI 程式設計](https://aiolaola.com/?utm_source=github&utm_campaign=agents)（182 節）＋ [從零構建 AI 智能體](https://aiolaola.com/course/ai-agent?utm_source=github&utm_campaign=agents)（40 節）（站上共 14 門課、700 節，**全部 ¥0**——另有 大模型原理 / AI 繪畫 / 寫小說 / 漫劇 / 量化 / DeepSeek / 深度專注 等）
>
> 🌍 Also available in [English](https://aiolaola.com/en?utm_source=github&utm_campaign=agents) · [日本語](https://aiolaola.com/ja?utm_source=github&utm_campaign=agents) · [Español](https://aiolaola.com/es?utm_source=github&utm_campaign=agents) · [한국어](https://aiolaola.com/ko?utm_source=github&utm_campaign=agents) · [繁體中文](https://aiolaola.com/zh-Hant?utm_source=github&utm_campaign=agents)

---

## 🙏 贊助商 &nbsp;<sub>想出現在這裡？聯絡 [jnMetaCode@qq.com](mailto:jnMetaCode@qq.com)</sub>

<p align="center">
  <a href="https://apinebula.ai/V6ekjG">
    <img src="assets/sponsor-apinebula.jpeg" alt="APINEBULA — 企業級 AI 聚合平臺，聚合 Claude / GPT / Gemini 滿血模型，一個介面接入全球頂尖大模型，價格低至 1 折起" width="100%">
  </a>
</p>

感謝 [APINEBULA](https://apinebula.ai/V6ekjG) 大屏贊助本專案！APINEBULA 是銀河錄影局旗下的企業級 AI 聚合平臺，背靠大平臺資源，面向開發者、團隊與企業使用者提供穩定、高性價比的大模型 API 接入服務。平臺聚合 Claude、GPT、Gemini 等主流滿血模型，一個介面接入全球頂尖 AI 大模型，各大模型價格低至 1 折起，支援企業級高併發、正式合同、對公打款與開票服務，適合 AI 程式設計、Agent 開發、業務系統整合等多種場景！

🎁 **透過[此連結](https://apinebula.ai/V6ekjG)註冊並在充值時填寫 "agent" 優惠碼可享九折優惠！**

<hr>

<table>
<tr>
<td width="25%">
  <a href="https://cubence.com/signup?code=SCW29JP9">
    <img src="assets/sponsor-cubence.jpeg" alt="Cubence — 專業 AI API 閘道器，穩定高效的 API 中轉服務，支援 Claude Code、Codex、Gemini 等多種模型" width="100%">
  </a>
</td>
<td width="75%" valign="middle">

感謝 [Cubence](https://cubence.com/signup?code=SCW29JP9) 對本專案的支援。Cubence 是一家致力為客戶提供穩定、高效的 API 中轉服務商。從 25 年 9 月運營至今，提供了 Claude Code、Codex、Gemini 等多種模型支援。🎁 **透過[此連結](https://cubence.com/signup?code=SCW29JP9)註冊的使用者，首次購買時填寫專屬優惠碼 `AGENCY` 即可享受 9 折優惠！**

</td>
</tr>
</table>

<table>
<tr>
<td width="25%">
  <a href="https://lanox.ai/?c=X3RD38F7&inviteCode=A3HRUB6M">
    <img src="assets/sponsor-lanox.jpeg" alt="LanoX AI — 全球模型接入服務，聚合 GPT / Claude / Gemini / Qwen / Grok 及多模態模型，頂級模型低至官方價 1 折起" width="100%">
  </a>
</td>
<td width="75%" valign="middle">

感謝 [LanoX AI](https://lanox.ai/?c=X3RD38F7&inviteCode=A3HRUB6M) 贊助了本專案！LanoX AI 為開發者、團隊與企業提供穩定、高性價比的全球模型接入服務，覆蓋 GPT、Claude、Gemini、Qwen、Grok 等主流模型，以及 Seedance 2.0、GPT Image、Gemini Nano Banana 等多模態創作能力。高可用、原生能力輸出、不降智、不混模、呼叫與計費透明，頂級模型低至官方價 1 折起，文件清晰、接入簡單，支援開票與企業批次呼叫，適用於 AI 產品、Agent、內容平臺與研發團隊。🎁 **透過[此連結](https://lanox.ai/?c=X3RD38F7&inviteCode=A3HRUB6M)註冊的使用者，可獲贈 5 美金體驗額度與百萬免費 Token，另有 500+ 免費模型可用！**

</td>
</tr>
</table>

<table>
<tr>
<td width="25%">
  <a href="https://www.shengsuanyun.com/?from=CH_QKH696UI">
    <img src="assets/sponsor-shengsuanyun.jpeg" alt="勝算雲 — 面向 AI 原生團隊的模型 API 聚合平臺，彙集 Claude / ChatGPT / Gemini 等海內外大模型，提供企業級定製閘道器" width="100%">
  </a>
</td>
<td width="75%" valign="middle">

感謝[勝算雲](https://www.shengsuanyun.com/?from=CH_QKH696UI)對本專案的贊助！勝算雲是面向 AI 原生團隊的模型 API 聚合平臺，彙集 Claude、ChatGPT、Gemini 等海內外大語言模型及多媒體模型，支援統一接入與按量呼叫。平臺堅持合規 API 服務，杜絕逆向工程和資源稀釋。此外平臺提供企業級定製閘道器，包括團隊成本與許可權管理、智慧路由、安全防護及 BYOK 金鑰託管，並提供發票服務。🎁 **新使用者透過[此連結](https://www.shengsuanyun.com/?from=CH_QKH696UI)註冊，即可領取 5 元 Token 體驗額度！**

</td>
</tr>
</table>

<table>
<tr>
<td width="25%">
  <a href="https://go.apimart.ai/gh-agency-agents-zh">
    <img src="assets/sponsor-apimart.jpeg" alt="APIMart — 專注 AI 圖片/影片生成的低價 API 平臺，GPT-Image-2 低至 $0.006/張，圖片與影片共用一套非同步 API" width="100%">
  </a>
</td>
<td width="75%" valign="middle">

感謝 [APIMart](https://go.apimart.ai/gh-agency-agents-zh) 贊助了本專案！APIMart 是專注 AI 圖片/影片生成的低價 API 平臺，GPT-Image-2 低至 $0.006/張，1 美元可出圖 160+ 張。圖片、影片共用一套非同步 API，提交任務拿 ID、輪詢或回撥取結果，跑批萬張不超時、換模型不改程式碼。按量付費、無月費。🎁 **透過[此連結](https://go.apimart.ai/gh-agency-agents-zh)註冊即可開用！**

</td>
</tr>
</table>

<table>
<tr>
<td width="25%">
  <a href="https://www.packyapi.ai/register?aff=Zpx1">
    <img src="assets/sponsor-packycode.jpeg" alt="PackyCode — 穩定高效的 API 中轉服務，統一域名與金鑰接入主流大模型，97% 可用性，多分組低至 2 折，提供 Codex / Claude Code 高速通道" width="100%">
  </a>
</td>
<td width="75%" valign="middle">

感謝 [PackyCode](https://www.packyapi.ai/register?aff=Zpx1) 贊助了本專案！PackyCode 是一家穩定、高效的 API 中轉服務商，一句話接入主流大模型。統一域名、統一金鑰、智慧容災切換，97% 可用性。人民幣 1:1 儲值，無匯率、無手續費坑，多分組折扣低至 2 折起，提供專屬 Codex / Claude Code 高速通道。支援 Stripe、支付寶、微信、銀行卡、對公付款，對公付款可開票。🎁 **新使用者透過[此連結](https://www.packyapi.ai/register?aff=Zpx1)註冊，首儲立享折扣，另贈 $1 免費體驗額度！**

</td>
</tr>
</table>

<table>
<tr>
<td width="25%" align="center" valign="middle">
  <a href="https://www.ucloud.cn/site/active/astraflow-credit?ytag=geo_waituo_agencyagentszh">
    <img src="assets/sponsor-astraflow.png" alt="星圖 AstraFlow — 影片模型一站式呼叫，200+ 大模型一鍵接入" width="100">
    <br><br>
    <strong>星圖&nbsp;AstraFlow</strong>
  </a>
</td>
<td width="75%" valign="middle">

感謝 [星圖 AstraFlow](https://www.ucloud.cn/site/active/astraflow-credit?ytag=geo_waituo_agencyagentszh) 贊助本專案！星圖 AstraFlow 由 UCloud 上市公司出品，聚合 MiniMax-H3、Seedance-2.5 等主流影片生成模型，文案生成與影片生成一個平臺全搞定，無需多端註冊、多處對接。支援 DeepSeek V4.1、Kimi K3、Qwen 3.8 Max、GLM 5.3、GPT-6、Claude 等 200+ 主流大模型，新模型上線當天即可接入。按 Key 級別計費，呼叫明細全程可查，費用透明可控。🎁 **新使用者透過[專屬連結](https://www.ucloud.cn/site/active/astraflow-credit?ytag=geo_waituo_agencyagentszh)註冊，即可領取 50 元算力金，開箱即用！**

</td>
</tr>
</table>

---

## 🚀 讓角色庫跑起來 · Agency Orchestrator

> 一句話，讓多個 AI 專家自動組隊協作，幾分鐘交付完整方案。

```bash
npm install -g agency-orchestrator
ao compose "幫我寫一篇關於 AI Agent 的深度分析文章" --run
```

**不想用命令列？** [**下載桌面客戶端**](https://github.com/jnMetaCode/agency-orchestrator/releases/latest)（原生 App，免裝 Node，macOS / Windows / Linux），或線上體驗 [ao.aiolaola.com/experts](https://ao.aiolaola.com/experts)。

零程式碼編排 · DAG 並行 · 斷點續跑 · 10 種大模型（7 種免 key）· 現成模板開箱即用 —— [**瞭解 Agency Orchestrator →**](https://github.com/jnMetaCode/agency-orchestrator)

---

## 🖼️ 線上瀏覽全部專家（無需安裝）

搜尋 / 按部門篩選 / 檢視與**複製每位專家的完整提示詞**，直接在瀏覽器裡看（線上收錄數量以頁面為準）：

<p align="center">
  <a href="https://ao.aiolaola.com/experts">
    <img src="assets/experts-gallery.png" alt="agency-agents 專家庫線上瀏覽" width="640"><br/>
    <strong>🔗 線上專家庫 ao.aiolaola.com/experts →</strong>
  </a>
</p>

---

## 這是什麼？

一套**開箱即用的 AI 角色庫**。每個智能體都有明確的身份定義、關鍵規則、工作流程和交付物，安裝到你的 AI 程式設計工具後用自然語言啟用。

**和普通提示詞的區別**：普通提示詞告訴 AI "你是一個專家"；這裡的智能體定義了專家**怎麼思考、怎麼做事、交付什麼**。例如[安全工程師](engineering/engineering-security-engineer.md)會按 OWASP Top 10 逐項審查程式碼，[小紅書運營專家](marketing/marketing-xiaohongshu-operator.md)會輸出完整的種草筆記策略和達人合作方案。

---

## 快速開始

### 方式一：一鍵安裝到你的 AI 工具

支援 **20 種主流 AI 程式設計工具**，一條命令搞定：

```bash
# 自動檢測已安裝的工具，一鍵安裝
./scripts/install.sh

# 或指定安裝到特定工具
./scripts/install.sh --tool openclaw       # OpenClaw ⭐ 推薦
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
./scripts/install.sh --tool zcode          # ZCode (智譜)
./scripts/install.sh --tool qwenpaw        # QwenPaw (阿里)
./scripts/install.sh --tool codex          # Codex CLI
./scripts/install.sh --tool deerflow       # DeerFlow 2.0 (ByteDance)
./scripts/install.sh --tool workbuddy      # WorkBuddy (Tencent)
./scripts/install.sh --tool codewhale      # CodeWhale (原 DeepSeek-TUI)
./scripts/install.sh --tool hermes         # Hermes Agent (NousResearch)
./scripts/install.sh --tool qoder          # Qoder
```

> Claude Code 和 GitHub Copilot 可直接安裝；其他工具需先執行 `./scripts/convert.sh` 轉換格式。

### 🔥 OpenClaw 使用者快速上手

OpenClaw 是目前社群使用者最多的整合方式，每個智能體會拆分為三個檔案：`SOUL.md`（身份人設）+ `AGENTS.md`（業務能力）+ `IDENTITY.md`（簡介），天然支援多智能體協作編排。

```bash
./scripts/convert.sh --tool openclaw   # 第一步：轉換為 SOUL.md 格式
./scripts/install.sh --tool openclaw   # 第二步：安裝到 ~/.openclaw/
```

安裝後重啟 OpenClaw 閘道器即可使用。

### 方式二：手動複製

```bash
# Claude Code / GitHub Copilot（直接複製即可）
cp -r marketing/*.md ~/.claude/agents/

# 在 Claude Code 中啟用：
# "啟用前端開發者模式，幫我構建一個 React 元件"
```

### 方式三：作為提示詞參考

瀏覽下方智能體列表，複製/改編你需要的內容！

---

### 方式四：透過 npm 取得角色庫

```bash
npm install agency-agents-zh
```

角色檔案位於 `node_modules/agency-agents-zh/`，可直接讀取或複製對應 Markdown。安裝 Agency Orchestrator 後，也可指定此目錄：

```bash
ao roles --agents-dir ./node_modules/agency-agents-zh
```

npm 套件提供角色內容，不會自動修改你的 AI 工具設定。上面的 `install.sh` / `convert.sh` 安裝流程需要複製 GitHub 儲存庫後執行。

## 智能體陣容

### 🏢 公司經營部

一個人的公司也有高管層——定方向、做取捨、對結果負責。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [執行長 CEO](company/chief-executive-officer.md) ⭐ | 戰略方向、資源配置、組織節奏、對外敘事 | 定方向、做重大取捨、把願景翻成優先順序 |
| [首席技術官 CTO](company/chief-technology-officer.md) ⭐ | 技術路線、架構決策、研發組織、技術債 | 選型評審、技術債取捨、研發效能 |
| [首席產品官 CPO](company/chief-product-officer.md) ⭐ | 產品戰略、路線圖取捨、產品組織 | 需求裁決、路線圖排期、產品覆盤 |
| [首席營銷官 CMO](company/chief-marketing-officer.md) ⭐ | 定位、渠道組合、營銷預算、品牌資產 | 增長打法、預算分配、品牌建設 |
| [營運長 COO](company/chief-operating-officer.md) ⭐ | 流程、指標、執行節奏 | 把戰略落成 SOP、消滅組織摩擦 |
| [首席財務官 CFO](company/chief-financial-officer.md) | 資本配置、資金運營、財務規劃、投資者關係 | 融資、預算、董事會彙報 |
| [幕僚長](company/chief-of-staff.md) | 戰略運營、跨部門協調、OKR 追蹤 | 高管例會、組織變革推進 |

> 想開一次"高管例會"？把這幾位放進同一個工作流，讓他們分別從戰略/技術/產品/增長/運營/財務視角過同一個議題——這正是 [Agency Orchestrator](https://github.com/jnMetaCode/agency-orchestrator) 的用法。

### 🛠️ 工程部

構建未來，一個 commit 一個腳印。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [前端開發者](engineering/engineering-frontend-developer.md) | React/Vue、UI 實現、效能最佳化 | 現代 Web 應用、畫素級 UI |
| [後端架構師](engineering/engineering-backend-architect.md) | API 設計、資料庫架構、可擴充套件性 | 服務端系統、微服務 |
| [AI 工程師](engineering/engineering-ai-engineer.md) | 機器學習、模型部署、AI 整合 | ML 功能、資料管線 |
| [DevOps 自動化師](engineering/engineering-devops-automator.md) | CI/CD、基礎設施自動化 | 流水線開發、部署自動化 |
| [安全工程師](engineering/engineering-security-engineer.md) | 威脅建模、程式碼審計、安全架構 | 應用安全、漏洞評估 |
| [快速原型師](engineering/engineering-rapid-prototyper.md) | 快速 POC、MVP 開發 | 概念驗證、駭客馬拉松 |
| [高階開發者](engineering/engineering-senior-developer.md) | Laravel/Livewire/FluxUI、高階 CSS、Three.js | 高品質 Web 體驗 |
| [移動應用開發者](engineering/engineering-mobile-app-builder.md) | iOS/Android 原生、跨平臺框架 | 移動端開發、App 效能最佳化 |
| [資料工程師](engineering/engineering-data-engineer.md) | ETL/ELT、資料湖、Spark/dbt | 資料管線、資料倉庫 |
| [技術文件工程師](engineering/engineering-technical-writer.md) | API 文件、開發者文件、docs-as-code | 技術文件、知識庫 |
| [自主最佳化架構師](engineering/engineering-autonomous-optimization-architect.md) | 自適應系統、自動調優 | 智慧運維、自愈系統 |
| [桌面應用工程師](engineering/engineering-desktop-app-engineer.md) | Electron/Tauri、安全 IPC、簽章公證、自動更新 | 桌面用戶端開發與發布 |
| [API 平台工程師](engineering/engineering-api-platform-engineer.md) | OpenAPI/gRPC、版本與棄用、SDK 生成、限流 | 公開 API、合作方 API 與開發者入口網站 |
| [資料庫可靠性工程師](engineering/engineering-database-reliability-engineer.md) | 高可用、備份還原、零停機遷移、災備演練 | 資料庫維運與災備 |
| [平台工程師](engineering/engineering-platform-engineer.md) | 黃金路徑、自助式基礎設施、Backstage | 內部開發者平台、研發效能 |
| [開發者工具工程師](engineering/engineering-developer-tooling-engineer.md) | CLI 設計、錯誤訊息、啟動速度、shell 補全 | 內部 CLI、開發者工具鏈 |
| [FinOps 工程師](engineering/engineering-finops-engineer.md) | 成本分攤、規格調整、預留執行個體/節省計畫 | 雲端成本治理與最佳化 |
| [隱私工程師](engineering/engineering-privacy-engineer.md) | PII 發現、同意執行、被遺忘權、假名化 | 隱私合規落地、資料刪除 |
| [國際化工程師](engineering/engineering-i18n-engineer.md) | ICU、CLDR 複數、RTL 版面、偽在地化 | 多語言產品、出海國際化 |
| [知識圖譜工程師](engineering/engineering-knowledge-graph-engineer.md) | Neo4j、實體擷取、溯源、GraphRAG | 知識庫建構、降低幻覺 |
| [搜尋相關性工程師](engineering/engineering-search-relevance-engineer.md) | ES/OpenSearch、BM25 調校、混合檢索、nDCG | 站內搜尋、商品搜尋最佳化 |
| [LLM 後訓練工程師](engineering/engineering-llm-post-training-engineer.md) | SFT/DPO/GRPO、故障診斷、檢查點完整性 | 模型微調與對齊、訓練事故排查 |
| [即時協作工程師](engineering/engineering-realtime-collaboration-engineer.md) | CRDT/OT、可安全重連協定、線上狀態 | 協同文件、即時多人應用 |
| [WebAssembly 工程師](engineering/engineering-webassembly-engineer.md) | Wasm、WASI、wasm-bindgen、體積最佳化 | 瀏覽器高效能運算、外掛沙箱 |
| [影音串流工程師](engineering/engineering-video-streaming-engineer.md) | ffmpeg、HLS/DASH/CMAF、DRM、ABR | 點播/直播平台、影片分發降本 |
| [行動端發布工程師](engineering/engineering-mobile-release-engineer.md) | 程式碼簽章、fastlane、分階段發布、商店送審 | App 上架與版本發布 |
| [資料視覺化工程師](engineering/engineering-data-visualization-engineer.md) | D3/Vega/ECharts、配色、大資料量渲染 | 資料儀表板、報表圖表 |
| [IoT 裝置群工程師](engineering/engineering-iot-fleet-engineer.md) | OTA 放量與回滾、裝置身分、MQTT 遙測 | 大規模裝置維運、韌體升級 |
| [Rust 重構專家](engineering/engineering-rust-refactoring-specialist.md) | 倉庫級重構、所有權、Clippy、SemVer | Rust 程式碼庫治理與遷移 |
| [PDF 引擎架構師](engineering/engineering-pdf-engine-architect.md) | HTML 轉 PDF、Playwright、PDF/A、向量完整性 | 履歷/合約/報表產生 |
| [通用文件編譯器](engineering/engineering-universal-document-compiler.md) | 文件 AST、版面推斷、YAML 雙向同步 | 任意資料產生履歷/報告/提案 |
| [ATS 校驗架構師](engineering/engineering-ats-validator-architect.md) | ATS 解析、BM25、X-Y-Z 評分、AI 招聘合規 | 海外求職履歷最佳化、招聘系統 |
| [網路工程師](engineering/engineering-network-engineer.md) | Cisco/Juniper/Palo Alto、BGP/OSPF、變更回滾 | 國外廠商設備的企業網維運 |
| [GaussDB 專家](engineering/engineering-gaussdb-expert.md) | 分佈鍵、CN/DN 執行計畫、UStore、國密 | 信創資料庫選型與調校 |
| [Drupal 效能工程師](engineering/engineering-drupal-performance.md) | 快取標籤/上下文、BigPipe、Views 最佳化 | Drupal 網站提速 |
| [WordPress 效能工程師](engineering/engineering-wordpress-performance.md) | 物件快取、WP_Query、Core Web Vitals | WordPress/WooCommerce 網站提速 |
| [Section 508 無障礙專家](engineering/engineering-section-508-specialist.md) | Section 508/ADA、螢幕閱讀器測試、VPAT | 美國政府與企業網站無障礙合規 |
| [ServiceNow 開發導師](engineering/engineering-servicenow-developer-mentor.md) | Business Rule、GlideAggregate、ACL 排障 | ServiceNow 平台開發與維運 |
| [USWDS 開發工程師](engineering/engineering-uswds-developer.md) | 設計權杖、官方元件、聯邦設計語言 | 美國聯邦/公部門網站 |
| [RAG 管線工程師](engineering/engineering-rag-pipeline-engineer.md) | 文件切分、混合檢索、重排與評測 | 知識庫問答、證據檢索 |
| [身分與存取工程師](engineering/engineering-identity-access-engineer.md) | OAuth/OIDC、SSO、SCIM、工作階段與多租戶授權 | 登入系統、企業身分與權限隔離 |
| [支付與計費工程師](engineering/engineering-payments-billing-engineer.md) | 冪等支付、可靠回呼、訂閱與對帳 | 支付整合、訂閱和退款 |
| [嵌入式演算法工程師](engineering/engineering-embedded-algorithm-engineer.md) ⭐ | DSP、感測器融合、定點化、TinyML | 演算法移植、精度與板端資源驗證 |
| [嵌入式應用工程師](engineering/engineering-embedded-application-engineer.md) ⭐ | RTOS/Linux 應用、狀態機、裝置協定、恢復 | 裝置業務開發、整機聯調與升級恢復 |
| [嵌入式韌體工程師](engineering/engineering-embedded-firmware-engineer.md) | RTOS、外設驅動、低功耗設計 | IoT、嵌入式系統 |
| [上位機工程師](engineering/engineering-pc-host-engineer.md) ⭐ | Qt/QML、QSerialPort、Modbus/CAN、QChart 即時視覺化 | 工業上位機、檢測裝置、HMI |
| [機械設計工程師](engineering/engineering-mechanical-design-engineer.md) ⭐ | 傳動選型、強度剛度疲勞振動校核、DFMA、GB/ISO 標準件 | 工業裝備、自動化產線、檢測儀器 |
| [嵌入式 Linux 驅動工程師](engineering/engineering-embedded-linux-driver-engineer.md) ⭐ | 核心模組、裝置樹、Platform/I2C/SPI 驅動 | 嵌入式 Linux BSP 開發 |
| [FPGA/ASIC 數字設計工程師](engineering/engineering-fpga-digital-design-engineer.md) ⭐ | Verilog/SystemVerilog、時序收斂、AXI 匯流排 | FPGA 開發、數字邏輯設計 |
| [IoT 方案架構師](engineering/engineering-iot-solution-architect.md) ⭐ | MQTT/CoAP、邊緣計算、裝置管理、雲平臺 | 物聯網端到端方案設計 |
| [國內網路工程師](engineering/engineering-network-engineer-china.md) ⭐ | 華為 VRP/華三 Comware/銳捷、VLAN/OSPF/BGP/VXLAN、信創國產化、等保組網 | 國產裝置園區網/資料中心/廣域網 |
| [故障響應指揮官](engineering/engineering-incident-response-commander.md) | 故障處置、SLO 管理、事後覆盤 | 線上故障、應急響應 |
| [威脅檢測工程師（工程側）](engineering/engineering-threat-detection-engineer.md) | SIEM、威脅狩獵、檢測規則 | 安全運營、威脅檢測 |
| [Solidity 智慧合約工程師](engineering/engineering-solidity-smart-contract-engineer.md) | Solidity、EVM、Gas 最佳化、DeFi | 智慧合約開發、Web3 |
| [微信小程式開發者](engineering/engineering-wechat-mini-program-developer.md) ⭐ | WXML/WXSS、微信支付、雲開發 | 微信小程式全棧開發 |
| [程式碼審查員](engineering/engineering-code-reviewer.md) | 程式碼審查、安全審計、質量把關 | PR 審查、程式碼質量 |
| [資料庫最佳化師](engineering/engineering-database-optimizer.md) | Schema 設計、查詢最佳化、索引策略 | 資料庫效能調優 |
| [Git 工作流大師](engineering/engineering-git-workflow-master.md) | 分支策略、約定式提交、變基 | Git 工作流規範 |
| [軟體架構師](engineering/engineering-software-architect.md) | 系統設計、DDD、架構決策 | 系統架構設計 |
| [SRE (站點可靠性工程師)](engineering/engineering-sre.md) | SLO、可觀測性、混沌工程 | 站點可靠性工程 |
| [AI 資料修復工程師](engineering/engineering-ai-data-remediation-engineer.md) | 自愈管道、SLM 語義聚類、零資料丟失 | 大規模資料異常修復 |
| [飛書整合開發工程師](engineering/engineering-feishu-integration-developer.md) ⭐ | 飛書機器人、審批流、多維表格 | 飛書生態整合開發 |
| [釘釘整合開發工程師](engineering/engineering-dingtalk-integration-developer.md) ⭐ | 釘釘機器人、酷應用、聯結器 | 釘釘生態整合開發 |
| [CMS 開發者](engineering/engineering-cms-developer.md) | Drupal/WordPress、主題開發、自定義外掛 | CMS 站點開發與內容架構 |
| [郵件智慧工程師](engineering/engineering-email-intelligence-engineer.md) | 郵件解析、結構化提取、AI 推理資料 | 智能體郵件整合 |
| [Filament 最佳化專家](engineering/engineering-filament-optimization-specialist.md) | Filament PHP 後臺重構、高影響力改造 | PHP 後臺管理最佳化 |
| [程式碼庫入職引導工程師](engineering/engineering-codebase-onboarding-engineer.md) | 讀原始碼、追蹤呼叫路徑、只講程式碼事實 | 新人上手陌生程式碼庫 |
| [最小變更工程師](engineering/engineering-minimal-change-engineer.md) | 最小可行差異、拒絕範圍蔓延 | Bug 修復、需要小而穩的 PR |
| [多智能體系統架構師](engineering/engineering-multi-agent-systems-architect.md) | 多智能體拓撲、上下文管理、人工審核關卡 | 生產級多智能體系統設計 |
| [Prompt 工程師](engineering/engineering-prompt-engineer.md) | 提示詞打磨、測試與系統化最佳化 | 把 AI 功能做到可上線 |
| [語音 AI 整合工程師](engineering/engineering-voice-ai-integration-engineer.md) | Whisper、雲端 ASR、說話人分離、字幕生成 | 影音轉錄與字幕流水線 |
| [IT 服務經理](engineering/engineering-it-service-manager.md) | ITIL 4、事件/問題/變更管理、SLA、CMDB | 企業 IT 服務管理 |
| [OrgScript 工程師](engineering/engineering-orgscript-engineer.md) | OrgScript 語法、解析器、AST 校驗 | 用 OrgScript 定義業務邏輯 |
| [WordPress 購物車工程師](engineering/engineering-wordpress-shopping-cart.md) | WooCommerce、支付閘道、checkout 定製 | WordPress 電商店鋪搭建 |
| [Drupal 購物車工程師](engineering/engineering-drupal-shopping-cart.md) | Drupal Commerce、支付閘道、checkout 流程 | Drupal 電商店鋪搭建 |

### 🎨 設計部

讓產品好看、好用、有驚喜。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [UI 設計師](design/design-ui-designer.md) | 視覺設計、元件庫、設計系統 | 介面設計、品牌一致性 |
| [UX 研究員](design/design-ux-researcher.md) | 使用者測試、行為分析 | 使用者研究、可用性測試 |
| [UX 架構師](design/design-ux-architect.md) | 資訊架構、互動設計、導航系統 | 複雜產品的 UX 架構 |
| [品牌守護者](design/design-brand-guardian.md) | 品牌標識、一致性、定位 | 品牌策略、視覺規範 |
| [影像提示詞工程師](design/design-image-prompt-engineer.md) | AI 影像生成、提示詞最佳化 | Midjourney/DALL-E 出圖 |
| [影片提示詞工程師](design/design-video-prompt-engineer.md) ⭐ | 文生影片提示詞、5 段式結構、運鏡與負面詞 | Sora / 可靈 / Veo / Seedance 出片 |
| [視覺敘事師](design/design-visual-storyteller.md) | 資料視覺化、視覺敘事 | 資訊圖、簡報 |
| [趣味注入師](design/design-whimsy-injector.md) | 微互動、彩蛋、趣味元素 | 產品細節體驗提升 |
| [UI 收尾審查員](design/design-ui-finish-gate-reviewer.md) | 設計契約、收尾關卡、反千篇一律 | 介面上線前審查 |
| [包容性視覺專家](design/design-inclusive-visuals-specialist.md) | 多元化視覺、無障礙設計 | 包容性設計、全球化視覺 |
| [Persona 走查專家](design/design-persona-walkthrough.md) | 畫像視角認知走查、LIFT/Cialdini/Fogg 框架 | 落地頁轉化診斷、CRO 報告 |

### 📢 營銷部

一個真實互動一個粉絲地增長。

**國內平臺：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [小紅書運營專家](marketing/marketing-xiaohongshu-operator.md) ⭐ | 種草筆記、達人合作、爆款內容 | 小紅書獲客、品牌種草 |
| [抖音策略師](marketing/marketing-douyin-strategist.md) ⭐ | 短影片策劃、演算法最佳化、直播帶貨 | 抖音增長、短影片營銷 |
| [微信公眾號運營](marketing/marketing-wechat-operator.md) ⭐ | 公眾號內容、社群運營、裂變增長 | 微信生態營銷 |
| [B站內容策略師](marketing/marketing-bilibili-strategist.md) ⭐ | UP主運營、彈幕文化、中長影片 | B站內容增長、品牌合作 |
| [快手策略師](marketing/marketing-kuaishou-strategist.md) ⭐ | 下沉市場、老鐵文化、直播電商 | 快手運營、社群信任 |
| [中國電商運營專家](marketing/marketing-china-ecommerce-operator.md) | 淘寶/拼多多/京東、廣告投放、大促作戰 | 電商全鏈路深度運營 |
| [電商運營師](marketing/marketing-ecommerce-operator.md) ⭐ | 淘寶/拼多多/京東、直播帶貨、大促 | 電商全平臺運營（簡潔版） |
| [百度 SEO 專家](marketing/marketing-baidu-seo-specialist.md) ⭐ | 百度最佳化、百科/知道/貼吧生態 | 百度搜索營銷 |
| [私域流量運營師](marketing/marketing-private-domain-operator.md) ⭐ | 企微SCRM、社群運營、使用者生命週期 | 私域體系搭建、復購增長 |
| [直播電商主播教練](marketing/marketing-livestream-commerce-coach.md) ⭐ | 直播話術、選品排品、千川投放 | 直播帶貨、主播孵化 |
| [跨境電商運營專家](marketing/marketing-cross-border-ecommerce.md) ⭐ | Amazon/Shopee/Lazada、海外倉、品牌出海 | 跨境電商全鏈路運營 |
| [短影片剪輯指導師](marketing/marketing-short-video-editing-coach.md) ⭐ | 剪映/PR/達芬奇、調色、音訊、特效 | 短影片剪輯技術指導 |
| [微博運營策略師](marketing/marketing-weibo-strategist.md) ⭐ | 熱搜運營、超話、輿情公關、粉絲經濟 | 微博全鏈路運營 |
| [播客內容策略師](marketing/marketing-podcast-strategist.md) ⭐ | 小宇宙/喜馬拉雅、音訊製作、商業化 | 播客內容創作與增長 |
| [微信影片號運營策略師](marketing/marketing-weixin-channels-strategist.md) ⭐ | 影片號直播、社交裂變、私域閉環 | 影片號運營與變現 |
| [知識付費產品策劃師](marketing/marketing-knowledge-commerce-strategist.md) ⭐ | 得到/知識星球/小鵝通、內容定價 | 知識付費產品運營 |
| [小紅書專家](marketing/marketing-xiaohongshu-specialist.md) | 生活方式內容、趨勢策略 | 小紅書品牌建設 |
| [微信公眾號管理](marketing/marketing-wechat-official-account.md) | 訂閱者運營、內容營銷 | 微信公眾號增長 |
| [知乎策略師](marketing/marketing-zhihu-strategist.md) | 知識型內容、思想領袖建設 | 知乎品牌權威 |
| [中國市場本地化策略師](marketing/marketing-china-market-localization-strategist.md) ⭐ | 抖音/小紅書/微信/B站全棧本地化 | 中國市場進入策略 |
| [新聞情報官](marketing/marketing-daily-news-briefing.md) ⭐ | 國內外多源新聞採集、交叉驗證、結構化簡報 | 內容生產線上遊素材供應 |
| [AEO 基礎架構師](marketing/marketing-aeo-foundations.md) | AI 爬蟲訪問、robots.txt、索引與渲染可訪問性 | 讓 AI 搜尋能抓取和理解你的網站 |
| [智能搜尋最佳化師](marketing/marketing-agentic-search-optimizer.md) | WebMCP、智能體任務完成率 | 讓 AI 智能體能在網站上完成預約、購買 |
| [郵件營銷策略師](marketing/marketing-email-strategist.md) | 生命週期自動化、分群、可送達性 | 郵件營銷序列設計 |
| [PR 與傳播經理](marketing/marketing-pr-communications-manager.md) | 媒體關係、新聞稿、危機傳播 | 品牌聲譽管理與公關活動 |
| [全球播客策略師](marketing/marketing-global-podcast-strategist.md) | 節目定位、受眾增長、變現 | Spotify/Apple Podcasts/YouTube 播客運營 |
| [X/Twitter 情報分析師](marketing/marketing-x-twitter-intelligence-analyst.md) | X/Twitter 調研、趨勢識別、帳號監測 | 海外社媒輿情與受眾洞察 |
| [多平台發布編排官](marketing/marketing-multi-platform-publisher.md) | Wechatsync 多平台分發、草稿優先 | 一篇文章同步發到知乎/小紅書/公眾號等 |

> ⭐ 標記的是本專案原創，更貼合國內實操。其餘為上游英文版翻譯。

**出海營銷：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [TikTok 策略師](marketing/marketing-tiktok-strategist.md) | 病毒式內容、演算法最佳化 | 出海短影片營銷 |
| [Twitter 互動官](marketing/marketing-twitter-engager.md) | 即時互動、思想領袖 | 出海品牌社交 |
| [Instagram 策展師](marketing/marketing-instagram-curator.md) | 視覺敘事、社群運營 | 出海視覺營銷 |
| [Reddit 社群運營](marketing/marketing-reddit-community-builder.md) | 社群文化、真實互動 | 出海社群營銷 |
| [開發者社群建設專家](marketing/marketing-developer-community-builder.md) | Discord/GitHub 社群、貢獻者計畫、健康度 | 開源與開發者產品社群營運 |
| [應用商店最佳化師](marketing/marketing-app-store-optimizer.md) | ASO、轉化最佳化 | App 出海推廣 |
| [影片最佳化專家](marketing/marketing-video-optimization-specialist.md) | YouTube 演算法、觀眾留存、跨平臺分發 | 影片營銷與 SEO |

**通用：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [增長駭客](marketing/marketing-growth-hacker.md) | 快速獲客、病毒迴圈、實驗 | 使用者增長、轉化最佳化 |
| [內容創作者](marketing/marketing-content-creator.md) | 多平臺內容、編輯日曆 | 內容策略、品牌故事 |
| [社交媒體策略師](marketing/marketing-social-media-strategist.md) | 跨平臺策略、整合營銷 | 全渠道社交運營 |
| [SEO 與自然搜尋增長專家](marketing/marketing-seo-specialist.md) | 技術 SEO、搜尋意圖、內容架構、收入歸因 | Google 自然搜尋增長 |
| [輪播圖增長引擎](marketing/marketing-carousel-growth-engine.md) | 輪播圖內容、自動化投放 | 社交媒體輪播素材 |
| [LinkedIn 內容創作專家](marketing/marketing-linkedin-content-creator.md) | LinkedIn 職場內容、B2B 獲客 | LinkedIn 品牌建設 |
| [圖書聯合作者](marketing/marketing-book-co-author.md) | 思想領袖力圖書、代筆協作 | 圖書策劃與撰寫 |
| [AI 搜尋可見性與 GEO 策略師](marketing/marketing-ai-citation-strategist.md) | AEO/GEO 最佳化、AI 平臺可見性審計 | AI 搜尋引擎品牌可見性 |
| [搜尋增長編排器](marketing/marketing-search-growth-orchestrator.md) ⭐ | AEO/SEO/GEO/Agentic 四層路由與統一路線圖 | 搜尋增長專案總協調 |

> 🔍 搞不清 SEO / GEO / AEO / Agentic Search 該找誰？看 [Search Growth Stack](SEARCH-GROWTH-STACK.md) —— 五個搜尋相關角色的職責邊界與選人指南。

### 💰 付費媒體部

精準投放，每一分預算都花在刀刃上。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [付費媒體審計師](paid-media/paid-media-auditor.md) | 廣告賬戶審計、預算最佳化 | 廣告效果診斷、降本增效 |
| [廣告創意策略師](paid-media/paid-media-creative-strategist.md) | 廣告素材策劃、A/B 測試 | 廣告創意最佳化 |
| [社交廣告策略師](paid-media/paid-media-paid-social-strategist.md) | 社交平臺廣告投放 | Meta/TikTok/LinkedIn 廣告 |
| [PPC 競價策略師](paid-media/paid-media-ppc-strategist.md) | 搜尋競價、關鍵詞管理 | Google Ads、百度推廣 |
| [程式化廣告採買專家](paid-media/paid-media-programmatic-buyer.md) | DSP、RTB、程式化購買 | 程式化廣告投放 |
| [搜尋詞分析師](paid-media/paid-media-search-query-analyst.md) | 搜尋詞挖掘、否詞最佳化 | 搜尋廣告精細化運營 |
| [追蹤與歸因專家](paid-media/paid-media-tracking-specialist.md) | 轉化追蹤、歸因模型 | 廣告效果衡量、資料打通 |

### 💼 銷售部

從線索到成交，讓每一單都有章法。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [客戶拓展策略師](sales/sales-account-strategist.md) | 大客戶拓展、ABM 策略 | 重點客戶攻關 |
| [銷售教練](sales/sales-coach.md) | 銷售輔導、技能提升 | 團隊銷售能力建設 |
| [贏單策略師](sales/sales-deal-strategist.md) | 成交策略、MEDDPICC | 複雜銷售推進 |
| [Discovery 教練](sales/sales-discovery-coach.md) | 需求挖掘、客戶洞察 | 銷售前期溝通 |
| [售前工程師](sales/sales-engineer.md) | 技術方案、Demo 演示 | 技術售前支援 |
| [Outbound 策略師](sales/sales-outbound-strategist.md) | 外呼策略、Cold outreach | 新客戶開拓 |
| [Pipeline 分析師](sales/sales-pipeline-analyst.md) | 銷售漏斗、預測分析 | 銷售資料分析、預測 |
| [投標策略師](sales/sales-proposal-strategist.md) | 投標方案、提案撰寫 | 招投標、方案競標 |
| [Offer 與 Lead Gen 策略師](sales/sales-offer-lead-gen-strategist.md) | Offer 設計、lead magnet、多渠道獲客 | 漏斗頂端獲客策略 |

### 🏦 金融部

讓每一筆錢都清清楚楚。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [財務預測分析師](finance/finance-financial-forecaster.md) ⭐ | 收入預測、場景建模、現金流 | SaaS 財務規劃、融資對接 |
| [發票管理專家](finance/finance-invoice-manager.md) ⭐ | 增值稅發票、金稅系統、三單匹配 | 發票全生命週期管理 |
| [金融風控分析師](finance/finance-fraud-detector.md) ⭐ | 交易風控、反洗錢、電信詐騙 | 支付風控、合規審查 |
| [簿記與財務總監](finance/finance-bookkeeper-controller.md) | 日常記帳、對帳、月末結帳、內控 | 帳務規範與審計準備 |
| [財務分析師](finance/finance-financial-analyst.md) | 財務建模、估值、報表分析 | 經營分析與投資決策支援 |
| [FP&A 分析師](finance/finance-fpa-analyst.md) | 預算編制、滾動預測、差異分析 | 年度預算與經營績效跟蹤 |
| [投資研究員](finance/finance-investment-researcher.md) | 行業研究、盡職調查、估值 | 投資研究與組合分析 |
| [稅務策略師](finance/finance-tax-strategist.md) | 稅務籌劃、跨境稅務結構、轉讓定價 | 企業稅務規劃與合規 |
| [香港股市合規審查專家](finance/finance-hk-stock-compliance-reviewer.md) ⭐ | HKEX 上市規則、SFC 監管、關聯交易 | 港股上市與持續合規審查 |

### 👔 人力資源部

找對人、用好人、留住人。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [招聘專家](hr/hr-recruiter.md) ⭐ | Boss直聘/獵聘、校招社招、背調 | 招聘全流程管理 |
| [績效管理專家](hr/hr-performance-reviewer.md) ⭐ | OKR/KPI、361分佈、晉升答辯 | 績效體系搭建與評估 |

### ⚖️ 法務部

合規是底線，風控是生命線。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [合同審查專家](legal/legal-contract-reviewer.md) ⭐ | 民法典合同編、電子簽章、風險評估 | 合同審查與風控 |
| [制度檔案撰寫專家](legal/legal-policy-writer.md) ⭐ | PIPL/資料安全法、隱私政策 | 合規制度與政策撰寫 |

### 🚚 供應鏈部

從工廠到使用者，每一環都不掉鏈子。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [庫存預測專家](supply-chain/supply-chain-inventory-forecaster.md) ⭐ | 需求預測、安全庫存、618/雙11備貨 | 庫存管理與補貨最佳化 |
| [供應商評估專家](supply-chain/supply-chain-vendor-evaluator.md) ⭐ | 1688供應商、驗廠、國標質檢 | 供應商准入與分級管理 |
| [物流路線最佳化師](supply-chain/supply-chain-route-optimizer.md) ⭐ | 順豐/通達系、冷鏈、跨境物流 | 物流成本最佳化與路線規劃 |
| [供應鏈採購策略師](supply-chain/supply-chain-strategist.md) ⭐ | 1688採購、質檢、供應商管理、ERP | 供應鏈與採購管理 |
| [服裝工廠規劃工程師](supply-chain/supply-chain-garment-factory-planning-engineer.md) ⭐ | 牛仔/羽絨服/針織產線設計、產能測算、多國合規 | 服裝工廠新建與產線規劃 |

### 📦 產品部

在正確的時間做正確的事。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [Sprint 排序師](product/product-sprint-prioritizer.md) | 敏捷規劃、功能優先順序 | Sprint 規劃、資源分配 |
| [趨勢研究員](product/product-trend-researcher.md) | 市場情報、競品分析 | 市場調研、機會評估 |
| [反饋分析師](product/product-feedback-synthesizer.md) | 使用者反饋分析、洞察提取 | 反饋分析、產品優先順序 |
| [行為助推引擎](product/product-behavioral-nudge-engine.md) | 行為心理學、使用者引導 | 使用者行為設計、轉化提升 |
| [產品經理](product/product-manager.md) | 產品全生命週期、PRD、路線圖 | 產品策略與交付管理 |
| [DX 工程師](product/product-dx-engineer.md) | 上手摩擦稽核、SDK 設計、錯誤訊息 | 開發者產品的上手體驗 |

### 📋 專案管理部

讓專案按時按質交付。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [高階專案經理](project-management/project-manager-senior.md) | 需求拆解、範圍管控 | 大型專案管理 |
| [專案牧羊人](project-management/project-management-project-shepherd.md) | 跨團隊協調、進度跟蹤 | 多團隊專案協調 |
| [實驗追蹤員](project-management/project-management-experiment-tracker.md) | A/B 測試、實驗管理 | 資料驅動決策 |
| [工作室製片人](project-management/project-management-studio-producer.md) | 創意專案管理、資源排程 | 內容/創意專案 |
| [工作室運營](project-management/project-management-studio-operations.md) | 工作室日常運營管理 | 團隊運營效率 |
| [Jira 工作流管家](project-management/project-management-jira-workflow-steward.md) | Jira 配置、工作流最佳化 | Jira 專案管理 |
| [會議紀要專家](project-management/project-management-meeting-notes-specialist.md) | 決議、待辦、待解決問題提取 | 把會議記錄整理成紀要 |

### 🧪 測試部

打破一切，讓使用者不必承受。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [證據收集者](testing/testing-evidence-collector.md) | 截圖 QA、視覺驗證 | UI 測試、Bug 文件 |
| [現實檢驗者](testing/testing-reality-checker.md) | 證據驅動認證、質量關卡 | 生產就緒評估 |
| [API 測試員](testing/testing-api-tester.md) | API 驗證、整合測試 | 介面測試、端點驗證 |
| [效能基準師](testing/testing-performance-benchmarker.md) | 效能測試、最佳化 | 壓測、效能調優 |
| [無障礙稽核員](testing/testing-accessibility-auditor.md) | WCAG 稽核、輔助技術測試 | 無障礙合規、包容性設計 |
| [測試結果分析師](testing/testing-test-results-analyzer.md) | 測試資料分析、質量度量 | 質量趨勢、釋出決策 |
| [工具評估師](testing/testing-tool-evaluator.md) | 工具選型、功能對比 | 技術選型、工具採購 |
| [工作流最佳化師](testing/testing-workflow-optimizer.md) | 流程分析、自動化 | 效率提升、流程改進 |
| [測試自動化工程師](testing/testing-test-automation-engineer.md) | Playwright/Cypress、資料隔離、CI 與失敗診斷 | 端到端測試、回歸與偶發失敗治理 |
| [嵌入式測試工程師](testing/testing-embedded-qa-engineer.md) ⭐ | HIL 測試、韌體自動化測試、EMC 測試 | 嵌入式質量保障、量產測試 |

### 🤝 支援部

運營的中流砥柱。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [客服響應者](support/support-support-responder.md) | 客戶服務、工單處理 | 客戶支援、使用者體驗 |
| [資料分析師](support/support-analytics-reporter.md) | 資料分析、儀表盤 | 商業智慧、KPI 追蹤 |
| [法務合規員](support/support-legal-compliance-checker.md) | 合規審查、法規檢查 | 法律合規、風險管理 |
| [高管摘要師](support/support-executive-summary-generator.md) | 業務摘要、戰略溝通 | 高管彙報、決策支援 |
| [財務追蹤員](support/support-finance-tracker.md) | 財務分析、預算管理 | 財務規劃、成本管控 |
| [基礎設施運維師](support/support-infrastructure-maintainer.md) | 系統運維、可靠性工程 | 基礎設施管理、故障排查 |
| [招聘運營專家](support/support-recruitment-specialist.md) ⭐ | Boss直聘/獵聘、勞動法、校招社招 | 招聘全流程與HR合規 |

### 🔬 專項部

不走尋常路的專家。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [智能體編排者](specialized/agents-orchestrator.md) | 多智能體協調、工作流管理 | 複雜專案的多智能體協作 |
| [提示詞工程師](specialized/prompt-engineer.md) ⭐ | LLM 提示詞設計、最佳化、評測 | 提示詞開發、AI 應用最佳化 |
| [身份信任架構師](specialized/agentic-identity-trust.md) | AI 身份驗證、信任框架 | AI 系統安全與信任 |
| [資料整合師](specialized/data-consolidation-agent.md) | 多源資料整合、儀表盤 | 資料彙總與視覺化 |
| [LSP 索引工程師](specialized/lsp-index-engineer.md) | 程式碼智慧、語義索引 | 程式碼導航、IDE 整合 |
| [報告分發師](specialized/report-distribution-agent.md) | 報告分發、多渠道推送 | 自動化報告分發 |
| [銷售資料提取師](specialized/sales-data-extraction-agent.md) | 銷售資料採集、結構化 | CRM 資料處理 |
| [應付賬款智能體](specialized/accounts-payable-agent.md) | 發票處理、付款自動化 | 財務流程自動化 |
| [身份圖譜操作員](specialized/identity-graph-operator.md) | 身份解析、多源匹配 | 使用者身份治理 |
| [文化智慧策略師](specialized/specialized-cultural-intelligence-strategist.md) | 文化洞察、跨文化設計 | 全球化產品、本地化策略 |
| [開發者佈道師](specialized/specialized-developer-advocate.md) | 開發者關係、DX 工程 | 開發者社群、技術推廣 |
| [模型 QA 專家](specialized/specialized-model-qa.md) | ML 模型審計、質量驗證 | 模型上線前檢查 |
| [ZK 管家](specialized/zk-steward.md) | Zettelkasten 知識管理 | 知識庫構建、筆記系統 |
| [留學規劃顧問](specialized/study-abroad-advisor.md) ⭐ | 多國申請策略、選校定位 | 留學規劃、文書指導 |
| [政務數字化售前顧問](specialized/government-digital-presales-consultant.md) ⭐ | 方案設計、標書、等保/信創 | 政務ToG專案售前 |
| [企業培訓課程設計師](specialized/corporate-training-designer.md) ⭐ | ADDIE/SAM、企業學習平臺、TTT | 培訓體系搭建與課程開發 |
| [MCP 構建器](specialized/specialized-mcp-builder.md) | MCP 伺服器、工具設計、API 整合 | MCP 開發、AI 工具擴充套件 |
| [履歷定製師](specialized/resume-tailor.md) | JD 分析、屬實的關鍵詞匹配、要點改寫 | 針對具體職位投遞履歷 |
| [總體規劃架構師](specialized/specialized-master-plan-architect.md) | 架構精講、紅隊演練、實施計畫 | 動手開發前的方案設計與評審 |
| [程式碼庫考古專家](specialized/specialized-codebase-archaeologist.md) | 跨會話漂移檢測、四視圖登記表 | 多 AI 工具協作專案的程式碼體檢 |
| [專注音樂架構師](specialized/specialized-focus-music-architect.md) | 專注音樂、生成式音訊提示詞 | 工作學習背景音樂生成 |
| [年邁父母照護助手](specialized/healthcare-aging-parent-care-companion.md) | 用藥與就診追蹤、緊急情況識別、照護者支持 | 照顧年邁父母 |
| [FedRAMP 與 RMF 合規工程師](specialized/specialized-fedramp-rmf-compliance.md) | FedRAMP、NIST 800-53、ATO、POA&M | 向美國聯邦機構提供雲端服務 |
| [文件生成器](specialized/specialized-document-generator.md) | PDF/PPTX/DOCX/XLSX 生成 | 程式化文件建立 |
| [工作流架構師](specialized/specialized-workflow-architect.md) | 工作流樹設計、交接契約、故障恢復 | 系統流程規格化 |
| [自動化治理架構師](specialized/automation-governance-architect.md) | 自動化審計、n8n 工作流治理、風險評估 | 業務自動化決策 |
| [Salesforce 架構師](specialized/specialized-salesforce-architect.md) | Salesforce 多雲設計、整合、資料模型 | 企業級 Salesforce 架構 |
| [醫療健康營銷合規師](specialized/healthcare-marketing-compliance.md) ⭐ | 醫療廣告法、NMPA、網際網路醫療 | 醫療健康營銷合規 |
| [高考志願填報顧問](specialized/gaokao-college-advisor.md) ⭐ | 平行志願、位次法、衝穩保策略 | 高考志願填報規劃 |
| [動態定價策略師](specialized/specialized-pricing-optimizer.md) ⭐ | 淘寶/京東/拼多多定價、大促機制 | 電商定價與促銷策略 |
| [AI 治理政策專家](specialized/specialized-ai-policy-writer.md) ⭐ | 演算法備案、生成式AI管理、倫理審查 | AI 合規與治理框架 |
| [企業風險評估師](specialized/specialized-risk-assessor.md) ⭐ | COSO本土化、國企風控、ESG | 企業風險管理與審計 |
| [會議效率專家](specialized/specialized-meeting-assistant.md) ⭐ | 飛書/釘釘/騰訊會議、OKR週會 | 會議管理與紀要輸出 |
| [土木工程師](specialized/specialized-civil-engineer.md) | Eurocode/DIN/ACI/GB 多標準結構分析 | 土木與結構工程設計 |
| [法國諮詢市場專家](specialized/specialized-french-consulting-market.md) | ESN/SI 生態、Malt 平臺、薪資代管 | 法國自由職業市場導航 |
| [韓國商務專家](specialized/specialized-korean-business-navigator.md) | 품의流程、KakaoTalk 禮儀、層級關係 | 韓國商務文化導航 |
| [人才獲取專家](specialized/recruitment-specialist.md) ⭐ | 國內招聘平臺、人才評估、勞動法合規 | 招聘運營與僱主品牌 |
| [技術翻譯專家](specialized/technical-translator-agent.md) ⭐ | 中英文雙向翻譯、程式設計/AI/雲計算術語 | 技術文件翻譯 |
| [商業戰略家](specialized/business-strategist.md) | 競爭分析、市場進入、商業模式設計 | 戰略規劃與重大業務決策 |
| [運營經理](specialized/operations-manager.md) | 精益/六西格瑪、產能規劃、KPI 治理 | 業務運營流程最佳化 |
| [變革管理顧問](specialized/change-management-consultant.md) | ADKAR、Kotter、Prosci | 組織變革、新系統落地 |
| [M&A 整合經理](specialized/ma-integration-manager.md) | Day 1 就緒、百日計劃、協同效應追蹤 | 併購後整合 |
| [組織心理學家](specialized/organizational-psychologist.md) | 團隊動力、心理安全、倦怠風險 | 團隊診斷與組織文化建設 |
| [客戶成功經理](specialized/customer-success-manager.md) | 新客導入、健康度評分、續約與擴張 | SaaS 客戶留存與增購 |
| [定價分析師](specialized/specialized-pricing-analyst.md) | 競品定價、成本結構、利潤率最佳化 | 產品定價模型 |
| [策略對決推演師](specialized/specialized-strategy-duel-agent.md) | 博弈論、三十六計 | 競爭對抗推演 |
| [資料隱私官](specialized/data-privacy-officer.md) | GDPR/CCPA、隱私影響評估、同意管理 | 海外隱私合規體系建設 |
| [ESG 與可持續發展官](specialized/esg-sustainability-officer.md) | ESG 披露、脫碳路徑、利益相關方溝通 | 可持續發展戰略與 ESG 報告 |
| [資助申請撰稿人](specialized/grant-writer.md) | 資助方調研、申請書撰寫、預算說明 | 基金會與科研專案資助申請 |
| [HR 入職管理專家](specialized/hr-onboarding.md) | 入職文件、合規追蹤、文化融入 | 新員工入職全流程 |
| [律所客戶接案專家](specialized/legal-client-intake.md) | 資質審核、利益衝突篩查、接案摘要 | 律所新案件接待 |
| [法律文書審查專家](specialized/legal-document-review.md) | 合同摘要、風險條款標記、版本比對 | 合同與法律文件審查 |
| [律所計費與工時專家](specialized/legal-billing-time-tracking.md) | 工時記錄、帳單生成、信託帳戶合規 | 律所計費與收款 |
| [信貸經理助手](specialized/loan-officer-assistant.md) | 借款人資格預審、文件收集、合規追蹤 | 住宅、商業與消費信貸辦理 |
| [房地產經紀助手](specialized/real-estate-buyer-seller.md) | 買賣方代理、報價談判、過戶協調 | 房產買賣交易支援 |
| [醫療帳單與編碼專員](specialized/medical-billing-coding-specialist.md) | ICD-10/CPT 編碼、理賠提交、拒付管理 | 美國醫療機構收入週期管理 |
| [醫療客服專家](specialized/healthcare-customer-service.md) | 預約、保險、帳單與投訴處理 | 醫療機構患者服務 |
| [酒店賓客服務專家](specialized/hospitality-guest-services.md) | 預訂、禮賓、投訴處理、會員計劃 | 酒店與餐飲賓客服務 |
| [零售退貨專家](specialized/retail-customer-returns.md) | 退換貨、防欺詐、客戶挽留 | 零售與電商售後 |
| [語言翻譯專家](specialized/language-translator.md) | 西英互譯、方言與文化語境 | 西班牙語旅行與商務溝通 |
| [個人成長導師](specialized/personal-growth-mentor.md) | 目標釐清、習慣設計、責任督促 | 個人成長規劃 |
| [旅行規劃師](specialized/travel-planner.md) ⭐ | 逐日行程、交通住宿、簽證與預算 | 國內外旅行行程規劃 |
| [鑑定評估師](specialized/authenticity-appraiser.md) ⭐ | 真偽要點、行情估值、交易避坑 | 二手與收藏品交易前的鑑定參考 |
| [養殖檔案核對員](specialized/livestock-archive-auditor.md) ⭐ | 養殖檔案 Excel 核對、FIFO 批號複核 | 畜禽養殖檔案自查與整改 |

### 🛡️ 安全部

守住程式碼、雲和資料的每一道防線。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [安全架構師](security/security-architect.md) | 威脅建模、信任邊界、縱深防禦 | 系統安全架構設計與評審 |
| [應用安全工程師](security/security-appsec-engineer.md) | 威脅建模、安全程式碼審查、SAST/DAST | 把安全融入研發流程 |
| [雲安全架構師](security/security-cloud-security-architect.md) | 零信任、AWS/Azure/GCP 安全、IaC 安全 | 雲原生安全架構 |
| [高階安全運營工程師](security/security-senior-secops.md) | 提交級金鑰掃描、認證授權、安全頭與限流 | 應用安全控制實施與審計 |
| [滲透測試員](security/security-penetration-tester.md) | 授權滲透測試、紅隊行動、漏洞評估 | 上線前與定期的攻防測試 |
| [威脅檢測工程師（安全運營）](security/security-threat-detection-engineer.md) | SIEM 規則、MITRE ATT&CK 覆蓋、檢測即程式碼 | 安全運營檢測體系建設 |
| [威脅情報分析師](security/security-threat-intelligence-analyst.md) | 對手追蹤、ATT&CK 對映、情報報告 | 威脅情報研判與檢測規則 |
| [事件響應專家](security/security-incident-responder.md) | 數位鑑識、威脅遏制、事後復盤 | 資料洩露與安全事件處置 |
| [合規審計師](security/security-compliance-auditor.md) | SOC 2/ISO 27001/HIPAA 合規 | 合規審計、安全認證 |
| [區塊鏈安全審計師](security/security-blockchain-security-auditor.md) | 智慧合約審計、漏洞檢測 | 合約安全、DeFi 審計 |
| [AI 生成程式碼安全審計師](security/security-ai-generated-code-auditor.md) | 硬編碼金鑰、Supabase RLS、提示詞注入 | vibe coding 應用上線前安全審查 |
| [金鑰與憑證治理工程師](security/security-secrets-credential-engineer.md) | 金鑰掃描、Vault 託管、動態憑證、洩露回應 | 金鑰治理、憑證輪換 |

### 🗺️ GIS 部

地理資訊系統全棧團隊：從製圖、空間分析到 Web GIS 與三維視覺化。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [GIS 分析師](gis/gis-analyst.md) | 製圖、圖層管理、空間查詢 | 日常 GIS 作業與資料維護 |
| [地圖製圖設計師](gis/gis-cartography-designer.md) | 配色、字型排印、標註佈局、視覺層次 | 印刷與 Web 地圖設計 |
| [空間資料工程師](gis/gis-spatial-data-engineer.md) | 格式轉換、重投影、屬性歸一化、ETL 管線 | 多源空間資料清洗入庫 |
| [空間資料科學家](gis/gis-spatial-data-scientist.md) | 空間統計、空間計量、聚類與預測 | 選址分析、空間規律挖掘 |
| [地理處理專家](gis/gis-geoprocessing-specialist.md) | ArcPy、.pyt 工具箱、Model Builder | ArcGIS Pro 工作流自動化 |
| [GIS 質檢工程師](gis/gis-qa-engineer.md) | 拓撲檢查、元資料審計、座標系一致性、精度評估 | 空間資料質檢與驗收 |
| [Web GIS 開發工程師](gis/gis-web-gis-developer.md) | MapLibre、ArcGIS JS API、Leaflet、即時儀表板 | 互動式 Web 地圖應用 |
| [三維場景開發者](gis/gis-3d-scene-developer.md) | Cesium、ArcGIS 三維場景、點雲與地形 | 三維 Web 場景與數位孿生展示 |
| [GeoAI/ML 工程師](gis/gis-geoai-ml-engineer.md) | 遙感影像目標檢測、分割、地表覆蓋分類 | 衛星與航拍影像智慧解譯 |
| [無人機實景測繪專家](gis/gis-drone-reality-mapping.md) | 攝影測量、正射影像、點雲、三維網格 | 無人機航測成果生產 |
| [BIM/GIS 專家](gis/gis-bim-specialist.md) | Revit/IFC 轉換、室內地圖、數位孿生 | BIM 與 GIS 資料打通 |
| [技術顧問](gis/gis-technical-consultant.md) | 差距分析、技術路線圖、RFP 應答 | GIS 規劃與數位轉型諮詢 |
| [解決方案工程師](gis/gis-solution-engineer.md) | Demo 與 PoC 搭建、Esri 與開源技術棧 | GIS 方案驗證與售前演示 |

### 🥽 空間計算部

構建下一代空間互動體驗。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [visionOS 空間工程師](spatial-computing/visionos-spatial-engineer.md) | visionOS、SwiftUI 空間 UI | Apple Vision Pro 開發 |
| [macOS Metal 空間工程師](spatial-computing/macos-spatial-metal-engineer.md) | Metal、GPU 渲染 | macOS 高效能圖形 |
| [XR 介面架構師](spatial-computing/xr-interface-architect.md) | 空間 UI 架構、互動設計 | XR 應用介面設計 |
| [XR 沉浸式開發者](spatial-computing/xr-immersive-developer.md) | WebXR、沉浸式體驗 | VR/AR 應用開發 |
| [XR 座艙互動專家](spatial-computing/xr-cockpit-interaction-specialist.md) | 座艙 UI、多模態互動 | 汽車/航空 XR 互動 |
| [終端整合專家](spatial-computing/terminal-integration-specialist.md) | 終端模擬、系統整合 | 空間計算終端工具 |

### 🎮 遊戲開發部

從獨立遊戲到 3A 大作，全引擎覆蓋。

**通用：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [遊戲設計師](game-development/game-designer.md) | 遊戲機制、系統設計、平衡性 | 遊戲核心玩法設計 |
| [遊戲經濟設計師](game-development/economy-designer.md) | 貨幣體系、產出/消耗、付費建模 | 長線營運遊戲的經濟平衡 |
| [關卡設計師](game-development/level-designer.md) | 關卡布局、節奏控制、空間敘事 | 關卡設計、場景構建 |
| [敘事設計師](game-development/narrative-designer.md) | 劇情設計、對話系統、世界觀 | 遊戲劇情、互動敘事 |
| [技術美術](game-development/technical-artist.md) | Shader、渲染管線、美術工具 | 畫面效果、效能最佳化 |
| [遊戲音訊工程師](game-development/game-audio-engineer.md) | 音效設計、音訊引擎、空間音訊 | 遊戲音效、配樂 |

**Unity：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [Unity 架構師](game-development/unity/unity-architect.md) | Unity 架構、ECS、效能最佳化 | Unity 專案架構 |
| [Unity 編輯器工具開發者](game-development/unity/unity-editor-tool-developer.md) | 編輯器擴充套件、自定義工具 | Unity 工具鏈開發 |
| [Unity 多人遊戲工程師](game-development/unity/unity-multiplayer-engineer.md) | Netcode、同步、網路架構 | Unity 聯機遊戲 |
| [Unity Shader Graph 美術師](game-development/unity/unity-shader-graph-artist.md) | Shader Graph、URP/HDRP | Unity 視覺效果 |

**Unreal Engine：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [Unreal 多人遊戲架構師](game-development/unreal-engine/unreal-multiplayer-architect.md) | Replication、網路同步 | UE 聯機架構 |
| [Unreal 系統工程師](game-development/unreal-engine/unreal-systems-engineer.md) | Gameplay 框架、C++ 系統 | UE 核心系統開發 |
| [Unreal 技術美術](game-development/unreal-engine/unreal-technical-artist.md) | 材質、Niagara、渲染管線 | UE 畫面與效能 |
| [Unreal 世界構建師](game-development/unreal-engine/unreal-world-builder.md) | 開放世界、地形、關卡串流 | UE 場景構建 |

**Blender：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [Blender 外掛工程師](game-development/blender/blender-addon-engineer.md) | Python 外掛、資源驗證、匯出自動化 | Blender 管線工具開發 |

**Godot：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [Godot 遊戲指令碼開發者](game-development/godot/godot-gameplay-scripter.md) | GDScript、場景樹、訊號系統 | Godot 遊戲邏輯 |
| [Godot 多人遊戲工程師](game-development/godot/godot-multiplayer-engineer.md) | MultiplayerAPI、網路同步 | Godot 聯機遊戲 |
| [Godot Shader 開發者](game-development/godot/godot-shader-developer.md) | Godot Shader Language、視覺效果 | Godot 畫面效果 |

**Roblox Studio：**

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [Roblox 虛擬形象創作者](game-development/roblox-studio/roblox-avatar-creator.md) | 虛擬形象、UGC 資產 | Roblox 角色設計 |
| [Roblox 體驗設計師](game-development/roblox-studio/roblox-experience-designer.md) | 體驗設計、遊戲迴圈 | Roblox 遊戲設計 |
| [Roblox 系統指令碼工程師](game-development/roblox-studio/roblox-systems-scripter.md) | Luau 指令碼、資料儲存 | Roblox 遊戲開發 |

### 📖 學術部

為敘事設計、世界構建和文化研究提供學術級支撐。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [人類學家](academic/academic-anthropologist.md) | 文化體系、儀式、民族誌 | 世界觀設計、文化構建 |
| [地理學家](academic/academic-geographer.md) | 自然與人文地理、空間分析 | 地圖構建、場景設計 |
| [歷史學家](academic/academic-historian.md) | 歷史分析、史料考證 | 歷史題材驗證、年代設定 |
| [敘事學家](academic/academic-narratologist.md) | 敘事理論、故事結構 | 劇情設計、角色弧線 |
| [心理學家](academic/academic-psychologist.md) | 行為心理、人格理論 | 角色心理塑造、動機設計 |
| [統計學家](academic/academic-statistician.md) | 實驗設計、因果推斷、效應量與區間 | 資料論斷審視、A/B 測試設計 |
| [學習規劃師](academic/academic-study-planner.md) ⭐ | 考研/考公/法考備考、學習方法論 | 個性化學習計劃與備考規劃 |

### 🏥 醫療健康部

面向醫療科技團隊的臨床證據、戰略敘事與政府衛生體系對接。內容基於美國、歐盟及新興市場的監管語境，國內使用請注意適用範圍。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [臨床證據專家](healthcare/healthcare-clinical-evidence-agent.md) | 臨床論斷分級、證據標準、決策支援定位 | 醫療 AI 對外材料審核 |
| [醫療創新戰略師](healthcare/healthcare-innovation-strategist.md) | 敘事架構、資歷錨點、監管應對 | 醫療科技融資與對外敘事 |
| [主權衛生體系專家](healthcare/healthcare-sovereign-health-systems-agent.md) | UHC 職責契合、政府合作、雙市場順序 | 新興市場衛生專案與政府合作 |

### 🔍 研究部

面向文獻綜述與證據綜合的研究方法支援。

| 智能體 | 專長 | 適用場景 |
|--------|------|----------|
| [研究綜合專家](research/research-synthesist.md) | 文獻綜述、來源分級、證據綜合 | 調研報告、決策前的證據梳理 |

### 🎯 戰略部

從發現到運營的全流程戰略指導。詳見 [strategy/](strategy/) 目錄。

| 文件 | 內容 |
|------|------|
| [高管簡報](strategy/EXECUTIVE-BRIEF.md) | NEXUS 戰略概覽 |
| [快速上手](strategy/QUICKSTART.md) | 5 分鐘上手指南 |
| [完整戰略](strategy/nexus-strategy.md) | 運營綱領全文 |
| [智能體啟用提示詞](strategy/coordination/agent-activation-prompts.md) | 各智能體的啟用指令 |
| [交接模板](strategy/coordination/handoff-templates.md) | 智能體間的交接規範 |
| Phase 0-6 Playbooks | [發現](strategy/playbooks/phase-0-discovery.md) · [策略](strategy/playbooks/phase-1-strategy.md) · [基礎](strategy/playbooks/phase-2-foundation.md) · [構建](strategy/playbooks/phase-3-build.md) · [加固](strategy/playbooks/phase-4-hardening.md) · [上線](strategy/playbooks/phase-5-launch.md) · [運營](strategy/playbooks/phase-6-operate.md) |
| 場景 Runbook | [創業 MVP](strategy/runbooks/scenario-startup-mvp.md) · [企業功能](strategy/runbooks/scenario-enterprise-feature.md) · [事故響應](strategy/runbooks/scenario-incident-response.md) · [營銷活動](strategy/runbooks/scenario-marketing-campaign.md) |

---

## 工具整合

支援 **20 種主流 AI 程式設計工具**，透過 `scripts/` 目錄下的指令碼實現格式轉換和一鍵安裝。

### 支援的工具

| 工具 | 安裝位置 | 型別 |
|------|----------|------|
| **OpenClaw** ⭐ | `~/.openclaw/agency-agents/` | 全域性，需轉換 |
| **Claude Code** | `~/.claude/agents/` | 全域性，直接複製 |
| **GitHub Copilot** | `~/.github/agents/` + `~/.copilot/agents/` | 全域性，直接複製 |
| **Kiro** (Amazon) | `~/.kiro/agents/` | 全域性，需轉換 |
| **Antigravity** | `~/.gemini/antigravity/skills/` | 全域性，需轉換 |
| **Gemini CLI** | `~/.gemini/extensions/agency-agents/` | 全域性，需轉換 |
| **Qwen Code** | `.qwen/agents/` | 專案級，需轉換 |
| **Cursor** | `.cursor/rules/` | 專案級，需轉換 |
| **Trae** | `.trae/rules/` | 專案級，需轉換 |
| **OpenCode** | `.opencode/agents/` | 專案級，需轉換 |
| **Aider** | `CONVENTIONS.md` | 專案級，需轉換 |
| **Windsurf** | `.windsurfrules` | 專案級，需轉換 |
| **Codex CLI** | `.codex/agents/` | 專案級，需轉換 |
| **WorkBuddy** (騰訊) | `~/.workbuddy/skills/` | 全域性，需轉換 |
| **CodeWhale** (原 DeepSeek-TUI) | `~/.codewhale/skills/` | 全域性，需轉換 |
| **Hermes Agent** (NousResearch) | `~/.hermes/skills/` | 全域性，需轉換 |
| **DeerFlow 2.0** (字節跳動) | `skills/custom/` | 專案級，需轉換 |
| **Qoder** | `~/.qoder/agents/` 或 `.qoder/agents/` | 全域性/專案級，需轉換 |
| **ZCode** (智譜) | `~/.zcode/agents/` | 全域性，需轉換 |
| **QwenPaw** (阿里) | `~/.qwenpaw/skill_pool/` | 全域性，需轉換 |

### 使用方法

```bash
# 第一步：轉換格式（Claude Code 和 GitHub Copilot 可跳過此步）
./scripts/convert.sh                    # 轉換為所有工具格式
./scripts/convert.sh --tool cursor      # 只轉換 Cursor 格式

# 第二步：安裝到本地
./scripts/install.sh                    # 自動檢測並安裝
./scripts/install.sh --tool cursor      # 安裝到指定工具

# 檢查智能體檔案格式
./scripts/lint-agents.sh
```

### 各工具安裝說明

<details open>
<summary><strong>⭐ OpenClaw（推薦）</strong></summary>

OpenClaw 會將每個智能體拆分為三個檔案，天然支援多智能體協作：
- `SOUL.md` — 身份、記憶、溝通風格、關鍵規則
- `AGENTS.md` — 核心使命、技術交付物、工作流程
- `IDENTITY.md` — 名稱與簡介

```bash
./scripts/convert.sh --tool openclaw
./scripts/install.sh --tool openclaw

# 安裝後重啟 OpenClaw 閘道器
openclaw gateway restart
```
</details>

<details>
<summary><strong>Claude Code</strong></summary>

智能體直接從倉庫複製到 `~/.claude/agents/`，無需轉換。

```bash
./scripts/install.sh --tool claude-code
```

在 Claude Code 中啟用：
```
啟用前端開發者模式，幫我審查這個元件。
```
</details>

<details>
<summary><strong>GitHub Copilot</strong></summary>

智能體直接從倉庫複製到 `~/.github/agents/` 和 `~/.copilot/agents/`，無需轉換。

```bash
./scripts/install.sh --tool copilot
```

在 GitHub Copilot 中啟用：
```
使用前端開發者智能體幫我審查這個元件。
```
</details>

<details>
<summary><strong>Antigravity (Gemini)</strong></summary>

轉換為 Antigravity skill 格式並安裝到 `~/.gemini/antigravity/skills/`。

```bash
./scripts/convert.sh --tool antigravity
./scripts/install.sh --tool antigravity
```
</details>

<details>
<summary><strong>Gemini CLI</strong></summary>

轉換為 Gemini CLI 擴充套件格式並安裝到 `~/.gemini/extensions/agency-agents/`。

```bash
./scripts/convert.sh --tool gemini-cli
./scripts/install.sh --tool gemini-cli
```
</details>

<details>
<summary><strong>Qwen Code</strong></summary>

轉換為 Qwen Code SubAgent 格式並安裝到專案目錄 `.qwen/agents/`。

```bash
./scripts/convert.sh --tool qwen
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool qwen
```

在 Qwen Code 中啟用：
```
使用前端開發者智能體幫我審查這個元件。
```

> 提示：安裝後在 Qwen Code 中執行 `/agents manage` 重新整理，或重啟會話。
</details>

<details>
<summary><strong>Cursor</strong></summary>

每個智能體會變成一個 `.mdc` 規則檔案，安裝到專案目錄 `.cursor/rules/`。

Cursor 使用 **"智慧匹配"模式**（`alwaysApply: false`）：AI 根據每個規則的 `description` 欄位自動判斷是否相關，相關時自動引用完整內容。

**安裝：**
```bash
# 第一步：轉換格式（在倉庫目錄執行）
./scripts/convert.sh --tool cursor

# 第二步：安裝到專案（在你的專案目錄執行）
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool cursor
```

**⚠️ 重要：建議精選安裝**

全部安裝 186 個規則會導致 Cursor 需要掃描大量 description 來判斷相關性，**可能影響匹配準確度**。推薦做法：

```bash
# 方法一：全量安裝後刪除不需要的
/path/to/agency-agents-zh/scripts/install.sh --tool cursor
# 然後手動刪除 .cursor/rules/ 中不需要的 .mdc 檔案，保留 10-20 個常用的

# 方法二：只複製你需要的智能體（轉換後）
./scripts/convert.sh --tool cursor
mkdir -p /your/project/.cursor/rules
cp integrations/cursor/rules/engineering-frontend-developer.mdc /your/project/.cursor/rules/
cp integrations/cursor/rules/engineering-code-reviewer.mdc /your/project/.cursor/rules/
# ... 按需複製
```

**安裝後如何使用：**

1. 安裝後 `.cursor/rules/` 中的 `.mdc` 檔案會自動被 Cursor 識別
2. 在 Chat 或 Composer 中正常提問，Cursor **自動匹配**相關智能體：
   ```
   幫我審查這個元件的效能問題   → 自動匹配前端開發者
   這段程式碼有安全漏洞嗎         → 自動匹配安全審計員
   ```
3. 也可以在 **Cursor Settings**（`Cmd+,`）→ **Rules** → **Project Rules** 中檢視所有規則
4. 還可以在 Chat 中用 `@規則名` 手動指定引用某個智能體

> **排查**：如果看不到規則，確認 `.cursor/rules/` 在專案根目錄、副檔名是 `.mdc`、已重新開啟專案。
</details>

<details>
<summary><strong>Trae</strong></summary>

轉換為 Trae rule 檔案並安裝到專案目錄 `.trae/rules/`。格式與 Cursor 同源（僅副檔名 `.md` 不同）。

```bash
./scripts/convert.sh --tool trae
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool trae
```

**⚠️ 關於"裝了但幾乎不自動觸發"**（見 [issue #59](https://github.com/jnMetaCode/agency-agents-zh/issues/59)）：

轉換出的 rule 預設 `alwaysApply: false` + 空 `globs:`，屬於 "agent-requested rule"——Trae 模型讀 description 自行決定是否載入。**全裝 268 條 rule 會讓 description 互相稀釋、幾乎命中不到任何一條**，這是設計行為不是 bug。

**正確姿勢**：

1. **精選安裝（推薦）**：只挑 10–20 條常用 rule 放進 `.trae/rules/`，自動匹配才會真正起作用。
2. **`@` 顯式呼叫**：對話裡輸入 `@engineering-pc-host-engineer ...` 強制載入某條 rule。
3. **核心 rule 改 alwaysApply**：把程式碼審查、git 工作流之類的 1–3 條改成 `alwaysApply: true` 長期生效。

詳細說明見 [integrations/trae/README.md](integrations/trae/README.md)。
</details>

<details>
<summary><strong>OpenCode</strong></summary>

轉換為 OpenCode agent 檔案並安裝到專案目錄 `.opencode/agents/`。

```bash
./scripts/convert.sh --tool opencode
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool opencode
```
</details>

<details>
<summary><strong>Aider</strong></summary>

所有智能體編譯為單個 `CONVENTIONS.md` 檔案，Aider 會自動讀取。

```bash
./scripts/convert.sh --tool aider
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool aider
```

在 Aider 會話中啟用：
```
使用前端開發者智能體幫我重構這個元件。
```
</details>

<details>
<summary><strong>Windsurf</strong></summary>

所有智能體編譯為單個 `.windsurfrules` 檔案。

```bash
./scripts/convert.sh --tool windsurf
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool windsurf
```
</details>

<details>
<summary><strong>Codex CLI</strong></summary>

轉換為 OpenAI Codex CLI agent 檔案（TOML 格式）並安裝到專案目錄 `.codex/agents/`。

```bash
./scripts/convert.sh --tool codex
cd /your/project
/path/to/agency-agents-zh/scripts/install.sh --tool codex
```

在 Codex 中使用時，智能體會作為 subagent 被呼叫。也可以在 `AGENTS.md` 中引用。
</details>

<details>
<summary><strong>Kiro (Amazon)</strong></summary>

Amazon 的 Spec 驅動 AI IDE，基於 Claude 模型。每個智能體轉換為 JSON 配置 + 提示詞檔案，安裝到 `~/.kiro/agents/`（全域性）。

```bash
./scripts/convert.sh --tool kiro
./scripts/install.sh --tool kiro
```

在 Kiro 中切換智能體：
```
/agent swap
```

或啟動時直接指定：
```bash
kiro-cli --agent engineering-frontend-developer
```
</details>

<details>
<summary><strong>ZCode (智譜)</strong></summary>

智譜推出的 ADE 桌面端程式設計 Agent，跑 GLM 系列模型。自定義 subagent 就是帶 YAML frontmatter 的 Markdown，跟本倉角色格式一致，轉換後安裝到 `~/.zcode/agents/`（全域性）。

```bash
./scripts/convert.sh --tool zcode
./scripts/install.sh --tool zcode
```

在對話方塊裡用 `@` 引用子智能體，或讓 ZCode 自動選擇。編輯定義檔案後需要新開會話——執行中的會話不會熱過載。

工作區級安裝可以把檔案放到 `<workspace>/.zcode/agents/`。
</details>

<details>
<summary><strong>QwenPaw (阿里)</strong></summary>

阿里 AgentScope 團隊的個人 AI 助手平臺，支援本地或雲端部署。每個智能體轉換為 `SKILL.md` 技能檔案，安裝到技能池 `~/.qwenpaw/skill_pool/`（全域性）。

```bash
./scripts/convert.sh --tool qwenpaw
./scripts/install.sh --tool qwenpaw
```

注意 QwenPaw 的兩層結構：**技能池不會直接執行**，手動放入的 skill 會以「停用」狀態寫入 `skill.json`，需要在控制檯啟用後廣播到工作區。

如果不想把檔案複製進主池，也可以在 `~/.qwenpaw/config.json` 的頂層欄位 `skill_paths` 裡登記本倉的 `integrations/qwenpaw` 作為**外部技能根目錄**——QwenPaw 會原地讀取、不寫入 manifest，倉庫更新後重新載入即可生效。
</details>

<details>
<summary><strong>WorkBuddy (騰訊)</strong></summary>

騰訊推出的全場景 AI 桌面智能體，相容 OpenClaw 技能，支援多模型切換。每個智能體轉換為 `SKILL.md` 技能檔案，安裝到 `~/.workbuddy/skills/`（全域性）。

```bash
./scripts/convert.sh --tool workbuddy
./scripts/install.sh --tool workbuddy
```

安裝後重啟 WorkBuddy 即可在技能列表中看到所有智能體。
</details>

<details>
<summary><strong>CodeWhale（原 DeepSeek-TUI）</strong></summary>

專為 DeepSeek 最佳化、對國內網路友好的終端程式設計 Agent（Rust 實現，原名 DeepSeek-TUI）。每個智能體轉換為 `SKILL.md` 技能檔案，安裝到 `~/.codewhale/skills/`（全域性），在 CodeWhale 裡用 `/skills` 載入。

```bash
./scripts/convert.sh --tool codewhale
./scripts/install.sh --tool codewhale
```

安裝後在 CodeWhale 中輸入 `/skills` 即可看到並呼叫所有智能體。
</details>

<details>
<summary><strong>Hermes Agent (NousResearch)</strong></summary>

NousResearch 的開源 AI 智能體框架，支援技能系統、子代理編排、會話記憶。每個智能體轉換為 `SKILL.md` 技能檔案，按分類目錄安裝到 `~/.hermes/skills/`（全域性）。

```bash
./scripts/convert.sh --tool hermes
./scripts/install.sh --tool hermes
```

安裝後**推薦在 Hermes CLI** 中透過 `hermes skills` 檢視和管理所有技能，或在對話中自然語言啟用。

> ⚠️ **Discord 模式下不要一次性全量安裝**
>
> Hermes 的 Discord 整合會把每一個 skill 註冊成 Discord 斜槓命令，Discord API 對 bot 所有命令的 JSON 序列化總長度有 **8000 字元硬上限**，超過後會返回 `error code 50035`（見 [issue #45](https://github.com/jnMetaCode/agency-agents-zh/issues/45)）。本倉庫有近 200 個 skill，一次裝全會直接炸 Discord。
>
> 解決辦法：在 Discord 中使用時請按**分類**分批安裝，用 `--category` 引數（可多次傳入）：
>
> ```bash
> # 只裝 marketing 分類
> ./scripts/install.sh --tool hermes --category marketing
>
> # 同時裝 engineering 和 design
> ./scripts/install.sh --tool hermes --category engineering --category design
> ```
>
> 可選分類：`academic, blender, company, design, engineering, finance, game-development, gis, godot, healthcare, hr, legal, marketing, paid-media, product, project-management, research, roblox-studio, sales, security, spatial-computing, specialized, supply-chain, support, testing, unity, unreal-engine`。
>
> Hermes CLI 本身沒有此限制，全量安裝可以繼續使用。
</details>

<details>
<summary><strong>DeerFlow 2.0 (字節跳動)</strong></summary>

字節跳動的開源 SuperAgent 框架，支援子代理、沙箱、持久記憶。每個智能體轉換為 `SKILL.md` 技能檔案。

```bash
./scripts/convert.sh --tool deerflow
./scripts/install.sh --tool deerflow
```

預設安裝到當前目錄的 `skills/custom/`。可透過環境變數自定義路徑：

```bash
DEERFLOW_SKILLS_DIR=/path/to/deerflow/skills/custom ./scripts/install.sh --tool deerflow
```

安裝後在 DeerFlow 的任務中，相關技能會自動載入。
</details>

<details>
<summary><strong>Qoder</strong></summary>

轉換為 Qoder SubAgent 格式（Markdown + YAML frontmatter）並安裝到 `~/.qoder/agents/`（全域性）或專案目錄 `.qoder/agents/`。

```bash
./scripts/convert.sh --tool qoder
./scripts/install.sh --tool qoder
```

在 Qoder 中使用：
- **自動觸發**：用自然語言描述任務，Qoder 根據 description 自動選擇智能體
- **手動觸發**：輸入 `/agent-name`（如 `/engineering-frontend-developer`）

> 官方文件：https://docs.qoder.com/zh/extensions/subagent
</details>

### 修改智能體後重新生成

新增新智能體或編輯現有智能體後，重新生成整合檔案：

```bash
./scripts/convert.sh               # 重新生成所有工具
./scripts/convert.sh --tool cursor  # 只重新生成指定工具
```

---

## 🇨🇳 中國市場原創智能體

除翻譯外，本專案包含 **67 個原創智能體**，專為中國平臺和業務場景打造：

- **平臺運營**：小紅書、抖音、微信公眾號/影片號/小程式、B站、快手、微博、知乎
- **企業協作**：飛書、釘釘整合開發
- **垂直領域**：跨境電商、政務ToG、醫療合規、高考志願、留學規劃、Qt 工業上位機、通用機械設計、畜禽養殖檔案核對
- **業務支撐**：私域流量、直播電商、庫存預測、合同審查、發票管理

> 在上方智能體陣容中標有 ⭐ 的即為原創智能體。

---

## 實戰案例

### 場景一：出海產品 MVP

**你的團隊**：
1. **前端開發者** — 構建 React 應用
2. **後端架構師** — 設計 API 和資料庫
3. **增長駭客** — 規劃使用者獲取
4. **快速原型師** — 快速迭代
5. **現實檢驗者** — 上線前質量把關

### 場景二：[小紅書品牌推廣](examples/workflow-xiaohongshu-launch.md)（完整流程）

**你的團隊**：
1. **小紅書運營專家** — 種草內容策略和達人合作
2. **內容創作者** — 產出種草筆記
3. **品牌守護者** — 品牌調性把關
4. **資料分析師** — 追蹤投放資料、出覆盤報告
5. **增長駭客** — 設計轉化和裂變路徑

---

## 貢獻

歡迎參與！翻譯智能體、改進內容、新增中國平臺智能體都行。詳見 [CONTRIBUTING.md](CONTRIBUTING.md)。

---

## 交流 · Community

<table>
<tr>
<td width="170" align="center">
<img src="assets/qr-wechat.jpg" width="150" alt="微信公眾號 AI不止語 二維碼"><br>
<sub>微信掃碼關注</sub>
</td>
<td>

微信公眾號 **「AI不止語」**（微信搜尋 `AI_BuZhiYu`）— 技術問答 · 專案更新 · 實戰文章

| 渠道 | 加入方式 |
|------|---------|
| QQ 2群 | [點選加入](https://qm.qq.com/q/EeNQA9xCxy)（群號 1071280067） |
| 微信群 | 關注公眾號後回覆「群」獲取入群方式 |

</td>
</tr>
</table>

---

## 姊妹專案

| 專案 | 定位 | 一句話 |
|------|------|-------|
| **本專案**（agency-agents-zh） ![](https://img.shields.io/github/stars/jnMetaCode/agency-agents-zh?style=flat&label=⭐) | 🎭 專家角色庫 | 328 個**即插即用** AI 專家，含 67 中國原創（小紅書 / 抖音 / 飛書 / 釘釘 / Qt 上位機 / 機械設計） |
| [agency-orchestrator](https://github.com/jnMetaCode/agency-orchestrator) ![](https://img.shields.io/github/stars/jnMetaCode/agency-orchestrator?style=flat&label=⭐) | 🚀 編排引擎 | 一句話 → 276 專家協作，**幾分鐘出方案**（15 種大模型 / 11 種免 key） |
| [superpowers-zh](https://github.com/jnMetaCode/superpowers-zh) ![](https://img.shields.io/github/stars/jnMetaCode/superpowers-zh?style=flat&label=⭐) | 🧠 工作方法論 | 20 個 skills 教 AI 怎麼幹活（TDD / 除錯 / 程式碼審查等） |
| [ai-coding-guide](https://github.com/jnMetaCode/ai-coding-guide) ![](https://img.shields.io/github/stars/jnMetaCode/ai-coding-guide?style=flat&label=⭐) | 📖 實戰教程 | 66 個 Claude Code 技巧 + 10 款工具最佳實踐 + 配置模板 |
| [shellward](https://github.com/jnMetaCode/shellward) ![](https://img.shields.io/github/stars/jnMetaCode/shellward?style=flat&label=⭐) | 🛡️ 安全中介軟體 | 8 層防禦 + DLP 資料流 + 注入檢測，**零依賴**（含 MCP Server） |
| 🆕 [ai-shortfilm-prompts](https://github.com/jnMetaCode/ai-shortfilm-prompts) ![](https://img.shields.io/github/stars/jnMetaCode/ai-shortfilm-prompts?style=flat&label=⭐) | 🎬 影片提示詞 | Mx-Shell《喪屍清道夫》5 段式方法論 + Skill，Seedance / 小云雀 / Sora / 可靈 / 即夢通用 |
| 🆕 [local-agent-toolkit](https://github.com/jnMetaCode/local-agent-toolkit) ![](https://img.shields.io/github/stars/jnMetaCode/local-agent-toolkit?style=flat&label=⭐) | 🛠️ Agent 本地三件套 | 給 agent 配上**記憶 / 技能管理 / 執行追蹤**，零依賴、資料不出本機（engram · skillet · tracelet，npx 即用） |
| 🆕 [codepet](https://github.com/jnMetaCode/codepet) ![](https://img.shields.io/github/stars/jnMetaCode/codepet?style=flat&label=⭐) | 🐾 桌面養成桌寵 | 碼寵 CodePet —— 你寫程式碼 / 用 Claude Code，它就漲經驗、升級、換狀態、跳舞。**全本地、隱私優先、開源** |
| 🆕 [openshorts](https://github.com/jnMetaCode/openshorts) ![](https://img.shields.io/github/stars/jnMetaCode/openshorts?style=flat&label=⭐) | 🎥 短影片生產線 | 開片 —— 文案進，成片出：腳本 / 配音 / 字幕 / 成片 / 發布包一條龍，**0 元 0 key 跑通第一條**，本地優先 |

---

## 致謝

- 原始英文版：[msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents)（MIT 協議）
- 感謝原作者 [@msitarzewski](https://github.com/msitarzewski) 建立了這個優秀的專案

---

## 許可證

MIT License — 自由使用，商業或個人均可。

---

<div align="center">

**328 個 AI 專家角色，20 種工具支援，即裝即用**

[⭐ Star 本專案](https://github.com/jnMetaCode/agency-agents-zh) · [提交 Issue](https://github.com/jnMetaCode/agency-agents-zh/issues) · [貢獻程式碼](https://github.com/jnMetaCode/agency-agents-zh/pulls)

基於 [agency-agents](https://github.com/msitarzewski/agency-agents) 翻譯並本土化

</div>

---

## ⭐ Star 趨勢

[![Star History Chart](https://star-history.dera.page/svg?repos=jnMetaCode/agency-agents-zh&type=Date)](https://star-history.dera.page/#jnMetaCode/agency-agents-zh&Date)
