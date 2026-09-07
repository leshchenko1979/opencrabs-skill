# Duty 4 + Duty 6 cycle 2026-09-07 — results (HQ, ledger n=1882→1889)

## Duty 4 — worker skill-input poll
Polls went to all 5 live editors. **d5863180 replied with 2 evidence-graded proposals; both validated by HQ triple-check (disk truth / evidence / coherence) and ACCEPTED as KERNEL:**

| Proposal | Gap it closes | Evidence | Verdict |
|---|---|---|---|
| **Dispatch-receipt gate** (supervisor.md §CI-wait, after item H1): assert dispatch rc==0 + adopted run id BEFORE arming waiter/notify | Waiter rules (editor.md item 10) validate the WAITER, not the DISPATCH — tonight's `--notify-session` invented-flag near-miss sailed through | Same-session twice 2026-09-07 (P05054775) | ACCEPT (semantic, wording next v-bump) |
| **Solo-surface rule** (editor.md §Tool discipline): side-effect commands (`gh pr create`) run SOLO in batch so output is witnessed; batched → fresh verification call before reporting ids | The #1272 phantom-PR root cause — a `gh pr create` whose output the lane never saw got reported as filed | Third phantom-family instance for that lane | ACCEPT (semantic) |

## Duty 6 — 7-lens subagent skill review (team duty6-review-20260907, read-only)
All 7 reports persisted (sha-indexed). Lens census:

| Lens | Findings | Yield | Cost (report bytes) |
|---|---|---|---|
| A redundancy+ontology | 19 | HIGH — family map, dup rules | 2140 |
| B llm-efficiency | 17 | HIGH — 3 redundant Triage-intake homes, broken RC-CONTRACT disclosure (~150 ln/role saving) | 3536 |
| C cli-usage | 5 | HIGH — 3 automation proposals from >100-row log evidence | 2097 |
| D deletion-safety | 13 verdicts | MED — 2 owner-word candidates, 2 archive-after-milestone, 1 policy gap | 2239 |
| E interface-topology | 2 | HIGH — ship+poll one-command merge (machinery already ships) | 1217 |
| F tool-code | ~20 | HIGH — oc-waiter first-poll-GREEN hole, Session-Id FIRST-vs-LAST split, battery-stale catch | 3068 |
| G rolefile-structure | 9 | MED — converges A/B on dedup; clean cross-ref sweep | 1640 |

Convergence: A/B/G independently hit the same dedup targets (Triage-intake triplication, fleet-directives telegram dup, family map, README census) — strong signal, low false-positive risk. D found zero deletable-without-owner-word items; retired verbs fully tombstoned.

## HQ triple-check spot-verifications (first-hand, receipts in ledger n=1889)
- CONFIRMED: SKILL.md stale family map "TOOLS E/F" (A11/B-9) · runbook "Carrier tools lane" (A10/G-F6) · README missing TRIAGE/TOOLSMITH + "30 executables" vs disk 31 (A14/A17) · supervisor PROCESS-TOOL OWNERSHIP stale vs v0.4.87 (B-1) · fleet-directives :204/:215 duplicate telegram_send law (A6/G-F1) · A18: supervisor.md:295 says editor CI-wait "items 1–9", disk shows 13 · F-11 oc-waiter first-poll-GREEN = notify-failed (verified in source).
- Toolsmith's n=1878 guard independently re-verified by lens F (present, selftest uses the real fabricated sha) + battery re-run **PASS 144/0** (receipt 13:13:50Z; the intermediate 143/1 was my inline-timeout truncation artifact, did not reproduce).

## Proposed actions (your word, one by one)
1. **v0.4.89 mechanical batch** (dedup, stale refs, README census, family map, W-count fix, wording) — no semantic change.
2. **Dispatch to TOOLSMITH (tool code):** oc-waiter first-poll-GREEN hole; Session-Id interpret-trailers unification; ship-required `--sha`/containment; swap-journal `$$` suffix; poll `--wait` check order; C-F2 witness matcher.
3. **Semantic skill changes (owner-gated):** Duty-4's 2 proposals; lens-E ship+poll merge; B-15 RC-CONTRACT disclosure trim; B-16 editor.md split; B-17/G-F9 fleet-directives grouping.
4. **Owner-word deletions (lens D):** `workers-ledger.json.skills-copy.pre-merge-20260828-113207` + `poll-110.log` (both zero-reader verified).
