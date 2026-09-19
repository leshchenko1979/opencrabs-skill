# Duty-6 Review — Lens C (CLI-AUTOMATION + USAGE GAPS), re-dispatch round (re-persisted 2026-09-06; original persist claim was phantom, recovered verbatim via wait_agent id 19d98f98)

Reviewer C (EVIDENCE), read-only. Scope: skill root .md files, tools/*, lib/*; usage logs: state-dir tools.log, oc-deploy/journal/*, waiters/*, workers-ledger.json (sampled), smoke-verdicts.log. Excluded per dispatch: oc-waiter JSON-orphan (F), patch-id quadruplication (E), sync-model/delivery-default contradictions (G/A). Counting note: log-analysis totals from read tools proved unreliable (pattern visibly matching 15 rows reported "6 total") — counts below are FLOOR counts ("≥N") from directly read rows.

## Findings

**C-R1 · HIGH — OC_ACTOR attribution unpaid at scale, nothing enforces it.** 41 tools.log rows in the 2026-09-05→06 window carry "actor":"unknown" — including production-critical: `{"ts":"2026-09-05T00:20:21Z","tool":"oc-deploy","actor":"unknown","args":"swap-execute --sha a288cdad…","exit":2}`. Nearly the whole September surface unattributable. Resolution: enforce in lib/oc-log.sh oc_log_init — loud stderr banner + extra.unattributed=true when OC_ACTOR unset.

**C-R2 · HIGH — ship-gate failure diagnosis is a recurring hand ritual.** ≥13 `ship --sha … exit 2` rows 2026-08-28→30, each followed ~20s by a hand-run oc-order-validate + re-ship (verbatim: 21:54:04 ship exit 2 → 21:54:21 order-validate exit 0 → 21:54:23 ship exit 0; double cycle 23:47:30 + 23:48:03). Resolution: oc-deploy ship prints the failing ORDER-gate name + verdict to stderr on rc 2 (or `ship --gates-only` pre-flight).

**C-R3 · MEDIUM-HIGH — smoke-verdict ledger appends hand-assembled; same-turn-append rule has no tool.** smoke-verdicts.log rows are heterogeneous hand prose (one-liner 2026-09-02 vs 4-paragraph 2026-09-04 with hand-re-derived identity). Resolution: oc-smoke-evidence --verdict PASS|FAIL --issue N [--late] append leg writing one normalized line (behavioral judgment stays human).

**C-R4 · MEDIUM — invoke-once has no interface support on the resume path; rc 5 evades both anti-storm guards.** Six inline `resume 33948139314 --wait 90` (exit 5) at ~2.5-min spacing — 90s runtime defeats the 120s flood window; oc-waiter existed unused. Resolution: oc-prchecks refuses second `resume <same-run-id> --wait` within N min, stderr points at oc-waiter arm.

**C-R5 · MEDIUM — unified tools log undercounts detached waiter activity ~45:2.** waiters/ holds 45 completed state files 2026-09-02→05; tools.log has 4 oc-waiter rows total (only the TERM'd one journaled). The "ONE line on exit" contract silently unmet for THE standard wait path. Resolution: log _run through a wrapper or journal arm+completion from the parent.

**C-R6 · MEDIUM — fanout re-invoked in loops; per-attempt journal files + lock debris accumulate.** ~90 fanout-33312527308-* files (incl. lockstep ~65s burst across three run-ids); 18 stale fanout.lock.* at state-dir root. Idempotency works but consulted only AFTER journaling fresh file. Resolution: check fanout.state before creating any journal/lock; sweep debris.

**C-R7 · LOW-MEDIUM — usage-YAGNI: oc-toolaccum 2 rows both --help (never scanned live); oc-branch-sweep no live sweep ever; oc-ship-audit 3 rows all 2026-08-31 despite the dispatch-without-swap class recurring 09-03/04 (run 33844429519) — alarm built for a class that recurred with the alarm unarmed. Resolution: fold oc-ship-audit into poll/swap tail; YAGNI rows to lens D.

**C-R8 · LOW — oc-deploy --help discoverability friction: ≥11 help lookups over ten days with rc 1 against the help=0 contract (fixed 2026-09-05T06:00:24Z exit 0). Resolution: assert the row in the battery's fleet-wide --help case.

**C-R9 · LOW — newest verbs' most natural mis-invocations cluster (oc-commit positional message exit 2; oc-prchecks slug-as-positional; oc-ledger unquoted spaces). Resolution: print exact expected form on those usage paths; optionally accept bare positional as -m.

**Incidental I-1 (lens F owns) — duplicate tools.log rows from one invocation:** same ts/args/exit with secs 183.5 and 816.0 on `resume 33947912195 --wait 900` — nested/double EXIT-trap class in the resume path.

**Incidental I-2 (historical, closed) — early --ledger args pointed at stale skill-dir ledger; canonical since v0.4.60 split; `.skills-copy.pre-merge-20260828` residue — deletion classification lens D's.

## Re-verification carried over from the lost round
- oc-waiter false-receipt path CLEAN: oc-waiter:234-240 validates payload BEFORE notify ("payload-no-run-id"/"payload-bad-verdict"), selftest pins ordering (oc-waiter:356). editor.md item 10 claim matches implementation. JSON-orphan defect remains lens F's.
- Phantom finding avoided: SKILL.md:66/:76 rows render truncated in naive reads due to escaped pipes but are complete on disk. No dead-reference finding filed.

## Verdict
Tool surface mature (11-step mechanized swap chain; oc-waiter = real standard, 45 completed waits in 4 days). Remaining gaps are UNENFORCED DISCIPLINES: attribution (R1) + invoke-once (R4) documented with zero mechanical backing and demonstrated mass non-compliance; two hand rituals (R2 ship-gate diagnosis, R3 smoke-ledger append); evidence-infrastructure integrity gaps (R5 waiter undercounting, R6 fanout accumulation, I-1 duplicate rows) degrading the usage ground truth every lens depends on. Priority: R1, R2 (highest burn, cheapest fixes) → R4/R5 → R3/R6/R7.
