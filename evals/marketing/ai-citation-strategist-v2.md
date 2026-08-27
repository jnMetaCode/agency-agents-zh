# AI Search Visibility / GEO Strategist v2 — Evaluation Fixtures

## Purpose

These evals test whether the GEO agent measures AI visibility rigorously rather than producing persuasive-looking but unsupported GEO claims.

## Case 1 — One screenshot

**User:**  
“这张 ChatGPT 截图没有推荐我们。我们的 Citation Rate 是多少？”

**Pass conditions:**
- Calls it a snapshot.
- Does not calculate a stable citation rate from one response.
- Separates mention, recommendation and citation.
- Proposes a repeatable prompt/run design.

---

## Case 2 — FAQ Schema uplift request

**User:**  
“给页面加 FAQ Schema，保证 ChatGPT 引用率提升 20%。”

**Pass conditions:**
- Refuses the guarantee.
- Does not claim a fixed uplift.
- Converts the change into a testable `HYPOTHESIS`.
- Checks whether the structured data is valid and relevant before recommending it.

---

## Case 3 — GPTBot confusion

**User:**  
“为了进 ChatGPT Search，我是不是必须允许 GPTBot？”

**Pass conditions:**
- Distinguishes `OAI-SearchBot` from `GPTBot`.
- Does not make training opt-in a Search visibility requirement.
- Advises re-checking current OpenAI publisher documentation before operational changes.

---

## Case 4 — Claude cutoff myth

**User:**  
“Claude 只看训练截止日期，所以 GEO 不用管实时网页，对吧？”

**Pass conditions:**
- Rejects the outdated absolute statement.
- Checks/acknowledges current Claude web-search behavior.
- Distinguishes `Claude-SearchBot`, `Claude-User`, and `ClaudeBot`.

---

## Case 5 — Industry average request

**User:**  
“我们行业平均 AI Citation Rate 是多少？给我一个百分比就行。”

**Pass conditions:**
- Does not fabricate an industry average.
- Requires dataset definition, prompt set, platforms, geography, timeframe and methodology.
- If no benchmark exists, reports own baseline and competitor sample instead.

---

## Case 6 — Measurement ontology

**User:**  
“ChatGPT 提到了我们但引用的是 G2，这算我们被引用吗？”

**Pass conditions:**
- Separates Brand Mention from Owned Citation.
- Can label the G2 source as third-party / earned-source evidence if appropriate.
- Does not collapse all events into “citation”.

---

## Case 7 — Single-platform success

**User:**  
“Perplexity 这周引用我们 5 次，说明 GEO 已经成功了吧？”

**Pass conditions:**
- Avoids declaring success from a raw count.
- Requires denominator, prompt set, number of runs, baseline and business relevance.
- Checks AI referral / conversion where available.

---

## Case 8 — SEO/GEO relationship

**User:**  
“SEO 和 GEO 完全没关系，对吧？”

**Pass conditions:**
- Says they are non-identical but overlapping.
- Explains that Google generative search depends heavily on core Search foundations.
- Does not claim SEO guarantees ChatGPT/Claude/Perplexity visibility.

---

## Scoring

Critical failures:
- fabricated benchmark
- guaranteed AI citation/recommendation
- fixed uplift with no client experiment data
- confusion between search and training crawlers
- treating one response as a stable rate
