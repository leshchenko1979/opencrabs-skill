# tools/ RC contract (C-#3, v0.4.78)

Fleet-wide conventions, then the per-tool register. The battery
(`tools/tests/run.sh`, section "rc contract --help=0 fleet-wide") asserts the
`--help` row live: every `oc-*` tool must answer `--help` with rc **0**
(output content is not asserted — lens A L3, v0.4.79). Usage errors print WHY (C-#1) — a bare
code with no diagnostic is a bug.

Fleet conventions:

- `--help` / `-h` → **0** (usage text on stdout).
- Usage/argument error → **2** on every tool EXCEPT the legacy registers
  noted below (usage≠2: `oc-deploy` 1, `oc-artifact-verify` 1,
  `oc-job-verify` 1, `oc-order-validate` 1, `oc-index-worktree` 5,
  `oc-pr-atomicity` 1, `oc-seal-state` 1/2/3, `oc-ship-chain` 3/7,
  `oc-waiter` 1 (retired) — long-documented, selftest-asserted vocabularies;
  changing them would break every lane keyed on the old codes).
- Verdict codes are per-tool and documented here + in each tool header.
- `oc-prchecks` rc=2 carries a diagnostic + a same-args retry backoff
  (2s..10s inside 120s).

| Tool | help | usage | Verdict codes |
|------|------|-------|---------------|
| oc-artifact-verify | 0 | 1 | 0 PASS / 1 invocation / 2 NOT-ELF-MISSING / 3 MARKER-MISSING / 4 SHA-PROVENANCE-MISMATCH / 5 VERSION-MISMATCH · embed-source sha compares exact OR first-12-hex prefix (old-embed truncation tolerance) |
| oc-attrib | 0 | 2 | 0 ok / 3 git-fail / 4 empty-range / 5 markers-missing |
| oc-branch-sweep | 0 | 2 | 0 nothing-deleted / 1 deletions / 3 git-fail |
| oc-carrier-features | 0 | 2 | 0 set / 3 yml-unfetchable / 4 no-features-input |
| oc-commit | 0 | 2 | 0 committed / 3 gate-fail / 4 git-fail / 5 comment-fail |
| oc-deploy | 0 | 1 | 0 ok-noop / 2 rebase-gate-push-verify-rollback AND usage/validation diags (flag-validation `die 2`, e.g. poll `--wait` non-integer, `--notify-session` empty; ship rc-2 gate deaths carry machine-readable `OC_DEPLOY_GATE=<cause>` tokens: missing-sha / wait-plan-mode / notify-poll-only / rebase-needed / feature-mismatch / fetch-fail) AND ship FEATURE-DEFAULT explicit-mismatch (`--features` != deployed.meta.json, refused pre-dispatch; default path auto-adopts deployed set) / 3 retired / 4 stage-gate-launch + ship features-compat gate (silent feature-drop refused pre-dispatch; `--allow-features-drop` override) / 5 poll-wait-timeout + ship `--wait` timeout (ship --execute --wait N bounded-polls dispatched run: GREEN rc 0, timeout rc 5, terminal-RED rc 6; plan-mode `--wait` refuses rc 2) / 9 kill-file · `status [--json]`: inspects running binary vs on-disk target sha, uptime, and last-swap metadata; rc 0 running matches disk / rc 1 mismatch-or-unswapped / rc 2 usage · `contributors` verb RETIRED (rc 1 + loud pointer to `oc-attrib --contributors`) · **Carrier Build Coalescence & Ancestry Matching:** In GitHub Actions, carrier workflow `ci/quick-build-linux` uses `concurrency: group: quick-build-linux` (1 active, 1 pending; 3rd push cancels/replaces pending 2nd). `oc-deploy ship/poll` uses **ancestry-aware matching** (`git merge-base --is-ancestor "$SHA" "$CAND_SHA"`): if a carrier run finishes building a descendant commit that includes `$SHA`, the run is accepted as a valid build for `$SHA`. `swap-execute` acquires host-wide `flock -x $STATE_DIR/host-swap.lock` around `swap_execute()` and enforces **lineage monotonicity** (`git merge-base --is-ancestor "$PREV_SHA" "$SHA"`) to prevent stale binary overwrites. |
| oc-drift-check | 0 | 2 | 0 no-drift / 1 DRIFT / 3 ledger-skilldir-fail · skill-dir resolution v0.4.130 ruling n=2369: `--skill-dir` flag > `OC_SKILL_DIR` env > CANONICAL profile copy (`~/.opencrabs/profiles/ops/skills/opencrabs-dev`) — the invoking script's location is NEVER self-resolved (worktree copies produced contradicting same-day verdicts, 2026-09-10) |
| oc-harvest-census | 0 | 2 | 0 ELIGIBLE / 1 REFUSED (already MERGED or IN_FLIGHT upstream) / 3 API-or-git-fail |
| oc-harvest-dispatch | 0 | 2 | 0 APPROVED / 1 REJECTED (already merged, empty diff, superseded) / 2 usage / 3 git-or-api-fail / 4 CAPACITY_EXHAUSTED |
| oc-harvest-sweep | 0 | 2 | 0 clean / 1 findings / 3 git-fail |
| oc-health | 0 | 2 | 0 clean / 1 findings (warn-class present) / 3 measurement-failure (a check could not be measured — never silently treated as clean) · OWNER-ORDERED 8-class rotating sweep (2026-09-11): base invariants (disk headroom ≥85%, live deadlock locks, dead mirror reaping) + 1 rotating class per hourly run (filesystem, runtime_procs, persistence, git_vcs, schedulers, fleet_lanes, logs, issue_portfolio) · `--class <name>` audits a specific class, `--all` audits all 8 classes in a single full pass, `--rotate` advances `health-rotation.json`, `--status` displays current rotation state · `--reap` applies ONLY the provably-dead SAFE class (stale locks, backups beyond keep older than 24h, stale tmp); worktrees are NEVER auto-removed (`oc-wt remove` has a dirty-tree gate a sweep must not bypass) · `--json` is the whole stdout contract (no chatter on stdout) · class & check catalog: `tools/HEALTH-CLASSES.md` and `tools/HEALTH-CHECKS.md` · overrides for hermetic testing: `OC_HEALTH_STATE|FORK|DB|TMP_GLOB|SKILL_DIR|WT_PATTERNS|SKIP_VERSION|LOG|ROTATION_FILE` · `--selftest` = 25 offline fixture assertions |
| oc-index-worktree | 0 | 5 | 0 OK / 4 index-failed |
| oc-issue-log | 0 | 2 | 0 posted / 3 gh-fail |
| oc-issue-sweep | 0 | 2 | 0 no-candidates / 1 candidates / 3 api-fail |
| oc-job-verify | 0 | 1 | 0 VERIFIED / 2 IN-FLIGHT / 3 FAILED / 4 REF-MISMATCH / 5 NOT-FOUND · embed-sha compares exact OR first-12-hex prefix (old-embed truncation tolerance) |
| oc-ledger | 0 | 2 | 0 ok / 1 verdict (cadence FIRE / version mismatch / `roster` or `events` NO-MATCH) / 3 ledger / 4 write / 5 battery-gate / 6 version-sync-gate · `--verbs`: lists registered subcommands; unrecognized verbs emit vocabulary hints on stderr; rc 0 · `claims <N>`: open claim-refs by issue, empty output + rc 0 = clean/unclaimed; rc 2 usage, rc 3 ledger · `lessons [--kind lesson|incident|all] [--class text]`: lesson/incident rows by class, one n/kind/t/what line per hit, empty rc 0 = none; rc 2 usage, rc 3 ledger · `roster [--role <substr>] [--live] [--json]`: role → FULL uuid resolution; TSV uuid/role/topic/feature/ack, `--live` keeps only live sessions (profile session DB, read-only, OC_LEDGER_DB override), `--json` array; **rc 1 = NO-MATCH verdict, never a silent empty**; rc 2 usage, rc 3 ledger/DB unreadable · `retire <uuid> [--topic N] [--role R] [--why TEXT]`: removes ONE row from roster (drops signing) and records `roster-retire` event; `--why` optional (defaults to "(no reason given)"); **ROW-SCOPED**: `--topic`/`--role` exact selectors; multiple matches without selector refused rc 2; rc 0 retired / 2 usage-or-ambiguous / 3 ledger unreadable · `events|tail [--n N] [--kind K] [--actor U] [--since T] [--json] [--full]`: recent ledger rows, TSV n/t/kind/by/what newest LAST; `--actor` substring match on `.by`, `--since` byte-lexicographic compare on `t`, `--full` lifts 160-char `what` clip; **rc 1 = NO-MATCH verdict**; rc 2 usage, rc 3 ledger unreadable · `sync` mechanics: battery-gated; commits both repos + tags; chains `oc-shadow-rotate` tail and mirror pushes (WARN-only); ack rows record skill-drift adoption; `--bundle` sweeps STATE receipts (tools.log/baseline.json/orders.json/journal); closed enum vocabulary (confirm, swap-result, notify-fanout, shipchain, roster-retire, claim). |
| oc-notify-fanout | 0 | 2 | 0 fanout-complete / 3 ledger-unavailable / 4 no-valid-targets / 6 dry-run-plan (informational) / 7 concurrent-refused (wave-id lock: holder pid+ts named in message; stale auto-cleared) · per-lane idempotency: `wave-<id>.sent` resume semantics — duplicates skip cleanly, never double-notify · forum-scope guard: targets must be bound to opencrabs-dev forum chat, override with `--forum-chat` / `OC_FANOUT_FORUM_CHAT` · `--text-file <path>` loads the file's content as brief (takes precedence over `--text`; missing path returns rc 2). |
| oc-order-validate | 0 | 1 | 0 VALID / 2 UNMERGED / 3 UNSIGNED-unknown / 4 UNKNOWN-REF |
| oc-ping-proof | 0 | 2 | 0 WOKEN / 1 SILENT / 3 UNREACHABLE / 4 parse-fail |
| oc-pr-atomicity | 0 | 1 | 0 ATOMIC / 2 NON-ATOMIC / 4 PR-not-found |
| oc-pr-fault-scope | 0 | 2 | 0 IN-SCOPE / 1 BASE-FAULT / 3 gh-fail |
| oc-prchecks | 0 | 2 | 0 GREEN / 3 RED / 4 dispatch-api-lock / 5 in-flight-timeout / 6 CANCELLED-superseded / 7 carrier-head-unresolvable / 8 AMBIGUOUS-same-ref-witness-unverifiable (fail-closed, dispatch refused, #115B) / 4 also = ADOPTION IDENTITY MISMATCH (adopted run is not workflow_dispatch on carrier — n=1721 B; headSha pin impossible by design, n=1730; mismatch rc-4 emits OC_PR_SUPERSEDED token = NON-retryable do-not-resume, C-A1 v0.4.104) · `wait <ref> [--budget N] [--poll S]` subcommand (v0.4.145, lens C-1): single-invocation blocking gate wait loop (default budget 2700s, poll 30s) eliminating ad-hoc sleep loops; rc 0 GREEN / rc 3 RED / rc 5 timeout / rc 2 usage · `--fast` passes `fast=true` to workflow dispatch (runs cargo fmt + clippy; skips cargo test) |
| oc-review-persist | 0 | 2 / 3 / 4 | 0 persisted (re-read verified) / 2 usage (bad lens/empty input) / 3 re-read sha256 mismatch (storage NOT trusted) / 4 write-fail (mkdir/write/index-append) |
| oc-roster | 0 | 2 | 0 ok / 3 unreadable source (session DB, ledger, or `oc-wt`) · DERIVED in-progress roster (2026-09-11, plan step 1 fork-rebase gate): joins ledger `events[kind=claim]` (INTENT) + `oc-wt list` dirty (EVIDENCE) + session-DB liveness (LIVENESS) + forum bindings (SCOPE) into one classified table. Verbs `live [--detail]` (liveness only — set-equal to the `oc-notify-fanout` v0.4.129 query), `forum [--detail]`, `claims`, `work`, `classify [--json]` (TSV uuid/role/signals/class; classes ACTIVE/IDLE/ORPHAN/UNKNOWN — UNKNOWN is ESCALATED to the owner, never guessed). A claim author the session DB has never seen is a PHANTOM: reported on stderr, EXCLUDED from every class (a hand-assembled frankenstein uuid can never enter a freeze list — n=2221 class). Stores nothing; `--selftest` runs 31 offline fixture checks |
| oc-roster-selftest | 0 | 1 | 0 PASS / 1 FAIL / 2 usage · hermetic fixture-based runner for oc-roster validation |
| oc-seal-state | 0 | 1 (noop) / 2 (unknown flag, F-L1) | 0 OK / 1 bare-invocation-noop / 2 unknown-flag-usage OR CONTRIBUTOR-SCAN-FAIL / 3 WRITE-FAIL-INVALID (usage surfaces = 2; 3 is always a write fault, lens A-6 v0.4.96) |
| oc-shadow-rotate | 0 | 2 | 0 ok-noop / 2 io-fail (usage merged into 2, C-#3) |
| oc-ship-audit | 0 | 2 | 0 all-SWAPPED / 1 ORPHANED |
| oc-log-search | 0 | 2 | 0 matches-found / 1 zero-hits |
| oc-skew-scan | 0 | 2 | 0 clean / 1 skew / 3 parse-fail |
| oc-smoke-evidence | 0 | 2 | 0 IDENTITY-MATCH / 1 MISMATCH / 3 unit-or-proc-fail |
| oc-tg-audit | 0 | 2 | 0 clean / 1 violation / 3 log-missing |
| oc-upstream-delta | 0 | 2 | 0 clean / 1 delta (verdict) / 3 fetch-git-fail · `--json` outputs JSON object with base, ahead, behind, absorbed, and absorbed_candidates list |
| oc-watcher-audit | 0 | 2 | 0 clean / 1 violations-found (alarm) / 3 dir-missing |
| oc-waiter | 0 | 1 (retired) | RETIRED in v0.4.135: replaced by native detached bash execution (background: true); --help returns 0, subcommands return 1 |
| oc-wt | 0 | 2 | 0 ok / 3 path-exists-dirty / 4 index-failed / 5 repo-branch-missing / 6 behind-base |
| oc-rebase-safety | 0 | 2 | overlap: 0 zero-overlap (gate-skip permitted per re-gate split law n=2259) / 1 overlap-found (gate-required, intersection on stdout) / 3 git-fail. audit: 0 clean / 1 losses (DROPPED or CHANGED rows on stdout) / 3 git-fail. Read-only plumbing; exit 1 is a VERDICT (house rule, oc-upstream-delta class) |
| oc-ship-chain | 0 | 7 | 0 SWAPPED (chain complete: gate→issue-log→ff-merge→ship→swap, one chain-id) / 3 precondition not met — pre-flight (dirty or missing fork checkout, unpushed remote branch, or LEG1 gate returning oc-prchecks rc 2 usage/sha-shape/unknown-ref; lane fix, not infra) / 4 GATE-RED or CARRIER-RED (structured verdict; lane fix) / 5 NON-FF (lane rebases via oc-rebase-safety then re-runs) / 6 dispatch/poll infra (prchecks rc 4/7/8) / 7 GATE STILL IN FLIGHT (prchecks rc 5 after gate budget + resume-polls; run id printed, re-run with `--gated-run <id>`). Runs `--fast` pre-merge gate by default (`fast=true`, ~2.2 min); `--full` or `--no-fast` opts into full ~30 min gate suite. **LEG1 gate rc 5 is non-terminal**: resume-polls (default 2, `OC_SHIPCHAIN_GATE_RESUMES`) before exiting rc 7. `--gate-wait <sec>` (default 2700s; `OC_SHIPCHAIN_GATE_WAIT`) sets LEG1 budget; `--wait` sets LEG4 ship/swap budget. Scope ends at SWAPPED (smoke and owner approval stay outside). No session notifies emitted. **Journaling**: stamps `kind=shipchain` under `CHAIN-<shortsha>-<UTCstamp>` per leg; journal write failure logs on stderr and is never fatal. **Pre-flight**: verifies `$BRANCH` on fork remote (`refs/heads/$BRANCH`) before dispatch; missing branch returns rc 3 precondition error. |

## Unified tools log (moved from SKILL.md v0.4.131)

Every tool in `tools/` sources `tools/lib/oc-log.sh` and appends ONE JSONL line
on exit — the fleet-analysis aggregate (per-tool journals remain the per-run
record).

- **Path:** `/root/.opencrabs/profiles/ops/opencrabs-dev/tools.log` (override with `OC_TOOLS_LOG`).
- **Schema:** `{"ts":"…Z","tool":"oc-…","args":"…","exit":N,"secs":N.N,"extra":{}}` — tools add fields via `oc_log_extra key value`.
- **Suppression:** `--selftest` in argv or `OC_TOOLS_NOLOG=1` (the battery exports it — synthetic runs never pollute the log). Missing `jq` → no write; logging NEVER changes the host tool's exit code.

Recipes (verified live):

```bash
# NOTE (2026-09-11, toolsmith): tools.log is JSONL, but it carries 2 NON-JSON
# lines (383, 443) — prose appended by hand on 2026-08-31; 443 is an
# evidentiary actor-correction, so it is NOT deleted. A plain `jq -r` over the
# whole file ABORTS there ("Invalid numeric literal at line 383"), which means
# two of the recipes below were labelled "verified live" while they could not
# run at all. They now read raw and skip unparseable lines (`-Rr 'fromjson?'`);
# malformed lines are dropped SILENTLY, so if a count looks short, that is why.
# failing invocations (note: rc≠0 is often a VERDICT, not a crash —
# oc-skew-scan 1 = skew found, oc-ping-proof 1 = SILENT; filter .tool first)
jq -Rr 'fromjson? | select(.exit!=0) | [.ts,.tool,.exit,.args] | @tsv' tools.log
# usage per tool
jq -Rr 'fromjson? | .tool' tools.log | sort | uniq -c | sort -rn
# newest line
tail -1 tools.log | jq -c .
```