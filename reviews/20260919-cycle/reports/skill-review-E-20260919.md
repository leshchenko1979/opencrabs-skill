# Lens E - cycle 20260919-cycle

## Verdict: 6 evidenced tool-surface defects — 1 HIGH (a mechanical reload trigger that prescribes the wrong law for 3 of 4 roles), 3 MED, 2 LOW. Nothing blocking; F1 is the one to land before the next reload cycle.

## Findings

**[HIGH] `oc-drift-check` hardcodes a role-blind reload — the tool that triggers the RELOAD LAW names the wrong file for 3 of 4 roles.**
locator `tools/oc-drift-check:134` (twin `:126`)
VERBATIM: `echo "DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary"`
VERBATIM (`:126`): `echo "NO-HISTORY: no last_acked recorded for $uuid — treat as DRIFT, re-read SKILL.md + editor.md IN FULL before next phase boundary"`
why: `editor.md` is the EDITOR role file. A Triage/Toolsmith/HQ lane hitting DRIFT is ordered to re-read a file it does not own and is never told to re-read `fleet-directives.md`, where the cross-role `[LANE]` law lives post-split — so it looks compliant having read none of its own reload set. The role IS knowable at that point: the tool already delegates to `oc-ledger roster` (`:78`).
fix: derive the prescription from the lane's role (`oc-ledger roster --json`) and print `re-read SKILL.md + <role>.md + fleet-directives.md IN FULL`; shape `oc-drift-check <uuid> --ack` prints the role-correct list.

**[MED] `oc-prchecks`: one job, two interfaces — the law names the flag; the runnable waiter is the subcommand.**
locator `review-lenses.md:184` vs `tools/oc-prchecks:24` + `:200`
VERBATIM (law): `(for a blocking gate, `oc-prchecks --wait`); also flags` / (`:185`) `` `oc-prchecks --wait` used as a verdict waiter (double-duty). ``
VERBATIM (`:24`): `#   oc-prchecks [<branch-or-sha> | resume <run-id> | wait <ref>] [--wait N] [--budget N] [--poll S] …`
VERBATIM (`:200`): `wait <ref>       single-invocation wait/watch loop with budget (default 2700s, poll 30s) — Cycle 5 C-1`
why: `--wait N` is the poll-budget knob and demands an integer (usage diagnostic `--wait needs an integer`, `:334`); the blocking-gate waiter is the SUBCOMMAND `wait <ref>` (own 2700s default). The law lanes copy from prescribes `oc-prchecks --wait` — bare, no N — which is not a runnable gate and denotes the budget flag, not the waiter. One job, two spellings, wrong one documented.
fix: make `wait <ref>` canonical; alias the other with a warning; align `review-lenses.md:184–185` + `RC-CONTRACT.md:46` in one edit.

**[MED] `oc-health` cron-liveness queries by NAME and carries a stale name — a renamed patrol reads as clean.**
locator `tools/oc-health:772`
VERBATIM: `cron_bad="$(sqlite3 "$DB" "SELECT name FROM cron_jobs WHERE enabled=0 AND name IN ('harvest-watch-4h','oc-roster-detached-sweep','oc-health-hourly');" 2>/dev/null)"`
why: `harvest-watch-4h` is the patrol's OLD name (renamed per the cron-namespacing law; its id `73158e43-…` survives the rename). A patrol renamed or disabled under a new name matches zero rows, so the census prints `crons: law-carrying enabled, zero DM leaks` and can never report it disabled — the "never start blind" class. CHANGELOG v0.4.203 records this exact row as *dispatched* to Toolsmith; the live file is unfixed.
fix: resolve patrol crons by job ID, not name; a name matching zero rows must be a FINDING, never clean.

**[MED] Three surfaces answer "which lanes are live / role R's uuid".**
locators `tools/RC-CONTRACT.md:38` (oc-ledger) and `:49` (oc-roster)
VERBATIM (`:38`): `` `roster [--role <substr>] [--live] [--include-retired] [--json]`: role → FULL uuid resolution; TSV uuid/role/topic/feature/ack, `--live` keeps only live sessions ``
VERBATIM (`:49`): `Verbs `live [--detail]` (liveness only — set-equal to the `oc-notify-fanout` v0.4.129 query), `forum [--detail]`, `claims`, `work`, `classify [--json]` …`
why: `oc-ledger roster` (role→uuid; schema owner of `last_acked`), `oc-roster` (its own derived `live`/`claims`/`work`/`classify`), and `oc-notify-fanout`'s internal target query all answer overlapping questions; the register RECORDS the set-equality instead of collapsing it. A lane must know which of three to call and can get different answers. `oc-roster claims` also collides by name with `oc-ledger claims <N>` while meaning something else. `oc-drift-check`'s D-5 mode already binds `oc-ledger roster --json` as "the schema owner" — the duplication is load-bearing and undocumented.
fix: one roster verb (the schema-owning one) with `--live/--forum/--claims/--classify` selectors; `oc-roster` and `oc-notify-fanout` delegate. Shape: `oc-ledger roster --live --json`.

**[LOW] `oc-lint-laws` corpus is hand-enumerated; `README.md` sits outside it and outside the exclusion list.**
locator `tools/oc-lint-laws:70`
VERBATIM: `DEFAULT_CORPUS="SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md"`
why: the corpus claims (its own `:66` comment: `# The LAW corpus: the skill's normative markdown. Two exclusions, both`) to be the skill's normative markdown with exactly two documented exclusions (CHANGELOG, war-stories), but `README.md` is in neither and carries live invocations (`bash tools/tests/run.sh`, `:55`/`:62`; `tools/oc-ledger sync --version X.Y.Z --why "..."`, `:65`). A law file outside the enumeration is a blind spot in the dead-channel lint. All 8 pointer-table destinations ARE covered — the hazard is the enumeration, not the split.
fix: derive the corpus at gate time (glob the root's normative `*.md` minus an explicit non-law list) instead of hardcoding 11 names.

**[LOW] `oc-upstream-delta --json` suppresses the commit list — a JSON drift consumer gets counts but no subjects.**
locator `tools/oc-upstream-delta` (`emit_commits` guard)
VERBATIM: `if [ "$JSON_OUT" -eq 0 ]; then` / `  emit_commits "$FORK_REF..$UP_REF" behind   # what upstream gained, first`
why: the `C <sha7> <subject>` rows emit only when `JSON_OUT=0`. The `--json` payload carries `base/ahead/behind/absorbed/absorbed_candidates` but no subjects, and `absorbed_candidates` covers only patch-id twins — so a JSON consumer cannot enumerate the non-absorbed BEHIND commits. For the standing-extra (the drift census must never start blind) the machine-readable mode is the one a monitor would use.
fix: add `behind_commits`/`ahead_commits` arrays (sha7+subject) to the JSON payload, mirroring the TSV.

## Coverage

Read: `tools/` + `tools/lib/` listings; `review-lenses.md` (E brief 194–206 + C/D/F/I/brain-scrub); `README.md`; `fleet-directives.md` (head + pointer table + thematic index); `RC-CONTRACT.md` (rows for oc-commit, oc-deploy, oc-drift-check, oc-harvest-census, oc-harvest-dispatch, oc-health, oc-issue-dispatch, oc-ledger, oc-lint-laws, oc-notify-fanout, oc-prchecks, oc-review-persist, oc-roster, oc-ship-chain, oc-skew-scan, oc-start, oc-smoke, oc-smoke-evidence); `oc-review-persist` (0–130); `oc-upstream-delta` (full); `oc-lint-laws` (partial); grep extracts of `oc-drift-check`/`oc-ledger`/`oc-ship-chain`/`oc-notify-fanout`; `CHANGELOG.md` (v0.4.202–205); `reviews/` listing + `20260919-cycle/state.json`.

NOT read: `tools/tests/run.sh`, `tools/lib/*.sh`, `HEALTH-CHECKS.md`, `HEALTH-CLASSES.md`, `tools/archive/*`; bodies of `oc-deploy`/`oc-ship-chain`/`oc-ledger`/`oc-notify-fanout`/`oc-health`/`oc-harvest-*` (grep extracts only); `SKILL.md`, `editor.md`, `hq.md`, `triage.md`, `toolsmith.md`, `upstream-merge-runbook.md`, `s2-swap-journal-spec.md`, `war-stories.md`. `oc-review-persist:71` deliberately NOT re-reported (Toolsmith owns it).
