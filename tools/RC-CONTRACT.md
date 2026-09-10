# tools/ RC contract (C-#3, v0.4.78)

Fleet-wide conventions, then the per-tool register. The battery
(`tools/tests/run.sh`, section "rc contract --help=0 fleet-wide") asserts the
`--help` row live: every `oc-*` tool must answer `--help` with rc **0**
(output content is not asserted — lens A L3, v0.4.79). Usage errors print WHY (C-#1) — a bare
code with no diagnostic is a bug.

Fleet conventions:

- `--help` / `-h` → **0** (usage text on stdout).
- Usage/argument error → **2** on every tool EXCEPT the SEVEN legacy registers
  noted below (usage≠2: `oc-deploy` 1, `oc-artifact-verify` 1,
  `oc-job-verify` 1, `oc-order-validate` 1, `oc-index-worktree` 5,
  `oc-pr-atomicity` 1, `oc-seal-state` 1/2/3 — long-documented, selftest-asserted
  vocabularies; changing them would break every lane keyed on the old codes).
  (v0.4.96 lens A-6: the v0.4.79 note "seal-state usage corrected 2→1" was WRONG
  — live tool: unknown-flag usage = 2, bare invocation = 1, write-fault = 3;
  register above stands.)
- Verdict codes are per-tool and documented here + in each tool header.
- `oc-prchecks` rc=2 carries a diagnostic + a same-args retry backoff
  (2s..10s inside 120s) — the 2026-08-31 20:51Z 60-row storm class.

| Tool | help | usage | Verdict codes |
|------|------|-------|---------------|
| oc-artifact-verify | 0 | 1 | 0 PASS / 1 invocation / 2 NOT-ELF-MISSING / 3 MARKER-MISSING / 4 SHA-PROVENANCE-MISMATCH / 5 VERSION-MISMATCH · embed-source sha compares exact OR first-12-hex prefix (old-embed truncation tolerance) |
| oc-attrib | 0 | 2 | 0 ok / 3 git-fail / 4 empty-range / 5 markers-missing |
| oc-branch-sweep | 0 | 2 | 0 nothing-deleted / 1 deletions / 3 git-fail |
| oc-carrier-features | 0 | 2 | 0 set / 3 yml-unfetchable / 4 no-features-input |
| oc-commit | 0 | 2 | 0 committed / 3 gate-fail / 4 git-fail / 5 comment-fail |
| oc-deploy | 0 | 1 | 0 ok-noop / 2 rebase-gate-push-verify-rollback AND usage/validation diags (flag-validation `die 2`, e.g. poll `--wait` non-integer, `--notify-session` empty — arg diags share the 2 register with gate-fail; message text disambiguates; ship rc-2 gate deaths carry machine-readable `OC_DEPLOY_GATE=<cause>` tokens — missing-sha / wait-plan-mode / notify-poll-only / rebase-needed / feature-mismatch / fetch-fail, C-A2 v0.4.104) AND ship FEATURE-DEFAULT explicit-mismatch (`--features` != deployed.meta.json, refused pre-dispatch; default path auto-adopts deployed set) / 3 retired / 4 stage-gate-launch + ship features-compat gate (silent feature-drop refused pre-dispatch, HQ law 2026-09-04; `--allow-features-drop` override) / 5 poll-wait-timeout + ship `--wait` timeout (F-1 fusion v0.4.97: ship --execute --wait N bounded-polls the dispatched run; GREEN rc 0, timeout rc 5, terminal-RED rc 6; plan-mode `--wait` refuses rc 2) / 9 kill-file · `contributors` verb RETIRED v0.4.90 (lens E-2, rc 1 + loud pointer to `oc-attrib --contributors`; date adjudicated against git history v0.4.116) |
| oc-drift-check | 0 | 2 | 0 no-drift / 1 DRIFT / 3 ledger-skilldir-fail · skill-dir resolution v0.4.130 ruling n=2369: `--skill-dir` flag > `OC_SKILL_DIR` env > CANONICAL profile copy (`~/.opencrabs/profiles/ops/skills/opencrabs-dev`) — the invoking script's location is NEVER self-resolved (worktree copies produced contradicting same-day verdicts, 2026-09-10) |
| oc-harvest-census | 0 | 2 | 0 ELIGIBLE / 1 REFUSED (already MERGED or IN_FLIGHT upstream) / 3 API-or-git-fail |
| oc-harvest-sweep | 0 | 2 | 0 clean / 1 findings / 3 git-fail |
| oc-index-worktree | 0 | 5 | 0 OK / 4 index-failed |
| oc-issue-log | 0 | 2 | 0 posted / 3 gh-fail |
| oc-issue-sweep | 0 | 2 | 0 no-candidates / 1 candidates / 3 api-fail |
| oc-job-verify | 0 | 1 | 0 VERIFIED / 2 IN-FLIGHT / 3 FAILED / 4 REF-MISMATCH / 5 NOT-FOUND · embed-sha compares exact OR first-12-hex prefix (old-embed truncation tolerance) |
| oc-ledger | 0 | 2 | 0 ok / 1 verdict (cadence FIRE / version mismatch) / 3 ledger / 4 write / 5 battery-gate / 6 version-sync-gate · `claims <N>` verb (v0.4.97, #129): open claim-refs by issue, empty output + rc 0 = clean/unclaimed (dispatch=verify-unclaimed backend); rc 2 usage, rc 3 ledger · `lessons [--kind lesson|incident|all] [--class text]` verb (v0.4.116, H-2): lesson/incident rows by class, one n/kind/t/what line per hit, empty rc 0 = none; rc 2 usage, rc 3 ledger `sync` mechanics: battery-gated; commits both repos + tags; chains oc-shadow-rotate tail (merge A v0.4.48); mirror-push tail since v0.4.50 (leshchenko1979/opencrabs-skill + opencrabs-dev-state, WARN-only); ack rows double as skill-drift adoption records (v0.4.52); `--bundle` sweeps STATE receipts (tools.log/baseline.json/orders.json/journal) per v0.4.49/51; stamp vocabulary v1.1 with claim (Duty-7 IDEA fix) · kinds include notify-fanout (v0.4.131, WAVE-GROUP-B B3): wave completion rows — sent/skipped/failed counts + target uuids in what (ended the note-row workaround). |
| oc-notify-fanout | 0 | 2 | 0 fanout-complete / 3 ledger-unavailable / 4 no-valid-targets / 6 dry-run-plan (informational) / 7 concurrent-refused (law 7 wave-id lock: live holder pid+ts named in the message; stale auto-cleared) · per-lane idempotency law 8 (v0.4.131, WAVE-GROUP-B): wave-<id>.sent resume semantics — duplicates SKIP <uuid> <role> DUPLICATE, never double-notify · forum-scope guard law 6: targets must be bound to the opencrabs-dev forum chat (SKIP ... SCOPE(...) receipt), drill override --forum-chat / OC_FANOUT_FORUM_CHAT |
| oc-order-validate | 0 | 1 | 0 VALID / 2 UNMERGED / 3 UNSIGNED-unknown / 4 UNKNOWN-REF |
| oc-ping-proof | 0 | 2 | 0 WOKEN / 1 SILENT / 3 UNREACHABLE / 4 parse-fail |
| oc-pr-atomicity | 0 | 1 | 0 ATOMIC / 2 NON-ATOMIC / 4 PR-not-found |
| oc-pr-fault-scope | 0 | 2 | 0 IN-SCOPE / 1 BASE-FAULT / 3 gh-fail |
| oc-prchecks | 0 | 2 | 0 GREEN / 3 RED / 4 dispatch-api-lock / 5 in-flight-timeout / 6 CANCELLED-superseded / 7 carrier-head-unresolvable / 8 AMBIGUOUS-same-ref-witness-unverifiable (fail-closed, dispatch refused, #115B) / 4 also = ADOPTION IDENTITY MISMATCH (adopted run is not workflow_dispatch on carrier — n=1721 B; headSha pin impossible by design, n=1730; mismatch rc-4 emits OC_PR_SUPERSEDED token = NON-retryable do-not-resume, C-A1 v0.4.104) |
| oc-review-persist | 0 | 2 / 3 / 4 | 0 persisted (re-read verified) / 2 usage (bad lens/empty input) / 3 re-read sha256 mismatch (storage NOT trusted) / 4 write-fail (mkdir/write/index-append) |
| oc-seal-state | 0 | 1 (noop) / 2 (unknown flag, F-L1) | 0 OK / 1 bare-invocation-noop / 2 unknown-flag-usage OR CONTRIBUTOR-SCAN-FAIL / 3 WRITE-FAIL-INVALID (usage surfaces = 2; 3 is always a write fault, lens A-6 v0.4.96) |
| oc-shadow-rotate | 0 | 2 | 0 ok-noop / 2 io-fail (usage merged into 2, C-#3) |
| oc-ship-audit | 0 | 2 | 0 all-SWAPPED / 1 ORPHANED |
| oc-log-search | 0 | 2 | 0 matches-found / 1 zero-hits |
| oc-skew-scan | 0 | 2 | 0 clean / 1 skew / 3 parse-fail |
| oc-smoke-evidence | 0 | 2 | 0 IDENTITY-MATCH / 1 MISMATCH / 3 unit-or-proc-fail |
| oc-tg-audit | 0 | 2 | 0 clean / 1 violation / 3 log-missing |
| oc-upstream-delta | 0 | 2 | 0 clean / 1 delta (verdict) / 3 fetch-git-fail |
| oc-waiter | 0 | 1 (retired) | RETIRED in v0.4.135: replaced by native detached bash execution (background: true); --help returns 0, subcommands return 1 |
| oc-wt | 0 | 2 | 0 ok / 3 path-exists-dirty / 4 index-failed / 5 repo-branch-missing / 6 behind-base |
| oc-rebase-safety | 0 | 2 | overlap: 0 zero-overlap (gate-skip permitted per re-gate split law n=2259) / 1 overlap-found (gate-required, intersection on stdout) / 3 git-fail. audit: 0 clean / 1 losses (DROPPED or CHANGED rows on stdout) / 3 git-fail. Read-only plumbing; exit 1 is a VERDICT (house rule, oc-upstream-delta class) |
| oc-ship-chain | 0 | 4 | 0 SWAPPED (chain complete: gate→issue-log→ff-merge→ship→swap, one chain-id) / 3 pre-flight (dirty or missing fork checkout) / 4 GATE-RED or CARRIER-RED (structured verdict; lane owns the fix round) / 5 NON-FF (lane rebases via oc-rebase-safety then re-runs) / 6 dispatch/poll infra. Scope ends at SWAPPED — smoke + owner approval stay outside. Never fires session notifies (no-self-ping law v0.4.126) |

## Unified tools log (moved from SKILL.md v0.4.131)

Every tool in `tools/` sources `tools/lib/oc-log.sh` and appends ONE JSONL line
on exit — the fleet-analysis aggregate (per-tool journals remain the per-run
record).

- **Path:** `/root/.opencrabs/profiles/ops/opencrabs-dev/tools.log` (override with `OC_TOOLS_LOG`).
- **Schema:** `{"ts":"…Z","tool":"oc-…","args":"…","exit":N,"secs":N.N,"extra":{}}` — tools add fields via `oc_log_extra key value`.
- **Suppression:** `--selftest` in argv or `OC_TOOLS_NOLOG=1` (the battery exports it — synthetic runs never pollute the log). Missing `jq` → no write; logging NEVER changes the host tool's exit code.

Recipes (verified live):

```bash
# failing invocations (note: rc≠0 is often a VERDICT, not a crash —
# oc-skew-scan 1 = skew found, oc-ping-proof 1 = SILENT; filter .tool first)
jq -r 'select(.exit!=0) | [.ts,.tool,.exit,.args] | @tsv' tools.log
# usage per tool
jq -r '.tool' tools.log | sort | uniq -c | sort -rn
# newest line
tail -1 tools.log | jq -c .
```
