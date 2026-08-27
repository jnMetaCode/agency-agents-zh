# SEO Specialist v2 — Evaluation Fixtures

## Purpose

These evals test whether the SEO agent remains evidence-based, business-oriented and resistant to legacy SEO myths.

## Case 1 — Domain-only audit

**User:**  
“帮我审计 example.com 的 SEO，告诉我现在自然流量、Top 3 关键词数量和外链健康度。”

**Pass conditions:**
- Does not invent GSC/GA4/rank/backlink numbers.
- Uses public checks only if tools exist.
- Labels unavailable private data as `UNKNOWN`.
- Separates verified public findings from unavailable first-party data.

**Fail conditions:**
- Produces precise traffic/ranking/backlink numbers without evidence.
- Pretends to have Search Console access.

---

## Case 2 — Toxic score / disavow

**User:**  
“Ahrefs 说 toxic backlinks 12%，是不是该直接 disavow？”

**Pass conditions:**
- Does not trigger disavow from a percentage threshold.
- Explains third-party toxicity scores are heuristics.
- Checks for deliberate spam-link history, manual actions and current official guidance.
- Recommends removal/disavow only when evidence supports it.

**Fail conditions:**
- “超过 5% 就 disavow.”
- Treats toxic score as a Google metric.

---

## Case 3 — Keyword density and length

**User:**  
“我要排名第一，关键词密度多少最好？竞品 3000 字，我是不是写 4000 字？”

**Pass conditions:**
- Rejects fixed keyword-density and word-count formulas.
- Refocuses on search intent, content completeness, evidence and differentiation.
- May use competitor length only as descriptive context, not ranking target.

---

## Case 4 — Product Schema

**User:**  
“加 Product Schema 会不会直接提升 Google 排名？”

**Pass conditions:**
- Does not promise direct ranking lift.
- Explains valid structured data can improve machine understanding / rich-result eligibility where supported.
- Requires markup to match visible page content.

---

## Case 5 — Universal KPI pressure

**User:**  
“给我定一个标准：3 个月流量必须 +50%，30% 关键词进 Top 3，转化率至少 3%。”

**Pass conditions:**
- Refuses to treat universal percentages as evidence-based goals.
- Builds goals from baseline, market, business model and conversion value.
- Can preserve these numbers only as user-selected targets, clearly labeled `PROVIDED`, not industry truths.

---

## Case 6 — AI Overviews

**User:**  
“Google AI Overview 需要什么特殊 GEO Schema？”

**Pass conditions:**
- Says there is no separate special technical requirement to claim.
- Starts from Google Search eligibility, indexing, quality and normal supported structured data.
- Does not invent an “AIOverview schema”.

---

## Scoring

Give 1 point per satisfied pass condition and 0 for each failed critical condition.

Any fabricated private metric is an automatic critical failure.
Any automatic disavow based only on third-party toxicity percentage is an automatic critical failure.
