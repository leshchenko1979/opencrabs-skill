# tools/ RC contract (C-#3, v0.4.78)

Fleet-wide conventions, then the per-tool register. The battery
(`tools/tests/run.sh`, section "rc contract --help=0 fleet-wide") asserts the
`--help` row live: every `oc-*` tool must answer `--help` with rc **0** and a
printed usage line + `Exit:` register. Usage errors print WHY (C-#1) — a bare
code with no diagnostic is a bug.

Fleet conventions:

- `--help` / `-h` → **0** (usage text on stdout).
- Usage/argument error → **2** on every tool EXCEPT the two legacy registers
  noted below (`oc-deploy` 1, `oc-ci-parity` 5 — kept: both are long-documented,
  selftest-asserted vocabularies; changing them would break every lane keyed on
  the old codes).
- Verdict codes are per-tool and documented here + in each tool header.
- `oc-prchecks` rc=2 carries a diagnostic + a same-args retry backoff
  (2s..10s inside 120s) — the 2026-08-31 20:51Z 60-row storm class.

| Tool | help | usage | Verdict codes |
|------|------|-------|---------------|
| oc-artifact-verify | 0 | 1 | 0 PASS / 2 NOT-ELF-MISSING / 3 MARKER-MISSING |
| oc-attrib | 0 | 2 | 0 ok / 3 git-fail / 4 empty-range / 5 markers-missing |
| oc-branch-sweep | 0 | 2 | 0 nothing-deleted / 1 deletions / 3 git-fail |
| oc-carrier-features | 0 | 2 | 0 set / 3 yml-unfetchable / 4 no-features-input |
| oc-ci-parity | 0 | 5 | 0 identical / 4 DRIFT / 6 api-fail |
| oc-commit | 0 | 2 | 0 committed / 3 gate-fail / 4 git-fail / 5 comment-fail |
| oc-deploy | 0 | 1 | 0 ok-noop / 2 rebase-gate-push-verify-rollback / 3 retired / 4 stage-gate-launch / 5 poll-wait-timeout / 9 kill-file |
| oc-drift-check | 0 | 2 | 0 no-drift / 1 DRIFT / 3 ledger-skilldir-fail |
| oc-harvest-sweep | 0 | 2 | 0 clean / 1 findings / 3 git-fail |
| oc-index-worktree | 0 | 5 | 0 OK / 4 index-failed |
| oc-issue-log | 0 | 2 | 0 posted / 3 gh-fail |
| oc-issue-sweep | 0 | 2 | 0 no-candidates / 1 candidates / 3 api-fail |
| oc-job-verify | 0 | 1 | 0 VERIFIED / 2 IN-FLIGHT |
| oc-ledger | 0 | 2 | 0 ok / 1 verdict (cadence FIRE / version mismatch) |
| oc-order-validate | 0 | 1 | 0 VALID / 2 UNMERGED / 3 UNSIGNED-unknown |
| oc-ping-proof | 0 | 2 | 0 WOKEN / 1 SILENT / 3 UNREACHABLE / 4 parse-fail |
| oc-pr-atomicity | 0 | 1 | 0 ATOMIC / 2 NON-ATOMIC |
| oc-pr-fault-scope | 0 | 2 | 0 IN-SCOPE / 1 BASE-FAULT / 3 gh-fail |
| oc-prchecks | 0 | 2 | 0 GREEN / 3 RED / 4 dispatch-api-lock / 5 in-flight-timeout / 6 CANCELLED-superseded / 7 carrier-head-unresolvable |
| oc-review-persist | 0 | 2 | 0 persisted |
| oc-seal-state | 0 | 2 | 0 OK / 2 CONTRIBUTOR-SCAN-FAIL / 3 WRITE-FAIL-INVALID |
| oc-shadow-rotate | 0 | 2 | 0 ok-noop / 2 io-fail (usage merged into 2, C-#3) |
| oc-ship-audit | 0 | 2 | 0 all-SWAPPED / 1 ORPHANED |
| oc-skew-scan | 0 | 2 | 0 clean / 1 skew / 3 parse-fail |
| oc-smoke-evidence | 0 | 2 | 0 IDENTITY-MATCH / 1 MISMATCH / 3 unit-or-proc-fail |
| oc-tg-audit | 0 | 2 | 0 clean / 1 violation / 3 log-missing |
| oc-toolaccum | 0 | 2 | 0 clean / 1 repeat-offense / 3 log-missing |
| oc-upstream-delta | 0 | 2 | 0 clean / 1 delta (verdict) / 3 fetch-git-fail |
| oc-wt | 0 | 2 | 0 ok / 3 path-exists-dirty / 4 index-failed / 5 repo-branch-missing / 6 behind-base |
