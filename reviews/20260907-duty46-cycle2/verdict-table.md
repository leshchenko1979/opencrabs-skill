# DUTY 4+6 CYCLE 2 — VERDICT TABLE + LENS CENSUS (v0.4.95 @ b0776e81, 2026-09-07 ~21:00Z)

7 lenses persisted (oc-review-persist, sha-indexed /tmp/skill-review-*-20260907.md, same-day overwrite of cycle-1 versions). All HIGH/P0/convergent findings re-verified first-hand by HQ before this table.

## P0 (fleet-blocking, verified first-hand)
F-1: oc-prchecks:525 `OC_PR_SKIPPED_DISPATH=1` (typo) vs consumers :529/:602 checking `OC_PR_SKIPPED_DISPATCH` — C-F2 "adopt instead of re-dispatch" silently re-dispatches after releasing the flock: re-creates the concurrency-cancel class #115B was built to kill; invisible to battery (no no-dispatch assertion). Valid since c6706c89. → TOOLSMITH urgent item 0 + selftest counter.

## Validated HIGH (first-hand receipts this turn)
- G-1: SKILL.md:421-422 still routes filed-PR conflicts to editor — contradicts v0.4.93 PR-freeze law (editor.md:848 maintainer-side). One-line fix.
- B-F2/G-5: editor.md RELOAD LAW keyed to claim-time only — compacted mid-task editor has no in-file trigger (other 3 roles trigger-explicit). Header-law fix.
- B-F3/F18: SKILL.md 50,357B is a 4x multiplier under RELOAD LAW; no budget guard. Fix: budget rule in review-lenses + register cuts.
- B-F10: registry schema lives only in supervisor.md Duty 2 while Triage owns the writes (v0.4.91) — cross-role dependency. Move schema to triage.md.
- E-F2: oc-deploy red_leg keeps OLD first-wins trailer extraction (4 sites) vs unified last-wins helper — RED blame can wake the WRONG LANE. → TOOLSMITH.
- E-F1: ship silently ignores --wait (mode-agnostic parse, poll-only use) — false-receipt trap. → TOOLSMITH (with fusion flag).

## Mechanical batch v0.4.96 (doc/pointer, on owner word)
A-1/G-F9 fd:79 "items 1-9" (THIRD pass) → 1-16 · A-2/G-2 supervisor:315 ordinal map (10th not 14th; v0.4.91 not .90) · A-3/G-3 editor:141 self-cite → item 11 · A-4/F-11 retirement date settle v0.4.90 (CHANGELOG:383 is truth; RC-CONTRACT:31+oc-deploy:24 wrong) + drop "run URL" · A-5 fixtures dead path · A-14 s2-spec consent row RETIRED-mark + auth reword · A-15 census + README.md + RC-CONTRACT.md · A-16 dead "ex Duty 7 items 5-6" x2 · A-17 oc-order-validate rc 4 UNKNOWN-REF · G-4 phase7-rules trigger (PR-freeze) · G-6 Duty 3 disk-absorption reword · G-7 FIRE glossary · G-8 CHANGELOG ordering (v0.4.92@388 after v0.4.90@380; top block 95/94/93/91 prepended vs newest-LAST contract) · G-9 triage:115 wrong item refs · G-10/G-11 dead locators · B-F4 bump-cell → numbered list · B-F6..F14 no-op/dup cuts · A-11 BUILD-TRIGGERS pointer · A-12 SYNC-LAW pointer · F-4/F-5/F-6/F-7/F-9/F-10/F-11/F-12 tool nits (with E-F3 awk dedup, E-F4 oc-notify.sh extraction).

## Duty-4 proposals (14 in, ~11 distinct after convergence) — all VALID, all doc-class
1. poll sha-pin filter (facd50af; stale-green swap risk)
2. /proc-vs-meta swap proof (facd50af; HQ verified /proc today)
3. full-40-sha pr-checks dispatch (a5b34466; gate RED receipt)
4. doubled-head-form warning (a5b34466; #1431 verified)
5. FAILED-TOOL waiter protocol (a5b34466; 3 poll deaths today)
6. FF-ancestry-before-gate (1a63f103) ≡ 13 merge-base pre-gate (Triage) — CONVERGED, one law
7. explicit -R on pr/issue verbs (1a63f103; HQ hit this 404 itself)
8. issue-close receipt law (Triage; #104/#86 phantom closes)
9. ls-remote branch-tip law (Triage ≡ 329bf3a3 — CONVERGED, #129 orphaned push)
10. peer fix-list first-hand (329bf3a3; extends AGENTS:185)
11. selftest-shim faithfulness (TOOLSMITH)
12. phantom/truncation law → toolsmith.md (TOOLSMITH)

## Lens census
| Lens | Yield | Distinct? | Disposition |
|---|---|---|---|
| A redundancy/ontology | 17 | 6 overlap w/ G, 2 w/ F | 14 → v0.4.96 |
| B efficiency/sprawl | 18 | unique (weight analysis) | 4 HIGH + 9 med/low → v0.4.96; split DEFER (G verdict) |
| C usage/rituals | 14 | unique (log-mined) | A1-A5 + B1-B6 → TOOLSMITH batch |
| D deletion safety | 18 cand. | unique | DELETE 2 (branches, owner-gated), ARCHIVE 2+24 /tmp reports, rest KEEP; 3 doc-gaps |
| E topology | 4+2 | 2 overlap w/ F | all → TOOLSMITH (wrong-lane blame HIGH) |
| F tool code | 12 | 2 overlap w/ A/E | P0 urgent + 2 P1 → TOOLSMITH; rest v0.4.96 |
| G structure | 11+4 | 6 overlap w/ A | 1 HIGH + 8 med → v0.4.96; Phase-7 split DEFER with preconditions |

Convergence signal: A∩G independently re-found 6 identical defects — strongest validation pair; zero cross-lens contradictions. Reviewer-method lesson adopted (lens D): zero-hit grep claims from |-patterns are unverified.
