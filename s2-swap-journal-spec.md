# S2 swap-leg journal spec (proposal) — for oc-deploy wiring

Author: compiler lane e756b84b · 2026-08-28
Answers: owner tool-logging law 2026-08-28 (AGENTS.md) + HQ ledger-1264 gap list
(no Aug-28 backup entry; deployed.sha never written during the 03:11Z swap).

> **AMENDED 2026-08-28 18:50Z (owner order — consent eliminated):** the
> `consent` journal line type below is superseded by the `auto-swap` line
> (`reason=green-run`, `consent:"eliminated-owner-2026-08-28"`); `deployed.meta.json`
> carries `auth:"auto-swap"` instead of `consent_msgid`. Everything else in this
> spec (journal vocabulary, markers, reconstructability law) stands unchanged.

## Law being satisfied

Every state-changing step writes a timestamped, append-only journal line (input,
action, outcome, exit code) to durable storage BEFORE the next step begins. If a
crash or restart can leave a run unreconstructable from journal + markers alone,
the tool is NOT DONE. Chat-scroll archaeology is failure.

## Journal location

`STATE_DIR/oc-deploy/journal/swap-<short-sha>-<epoch>.jsonl` — one file per swap attempt,
append-only, every line fsync'd before the next step starts. (Live oc-deploy
writes the 8-char short sha + an epoch suffix — the epoch disambiguates repeat
swaps of the same sha.) STATE_DIR = the state
dir oc-deploy already owns for `deployed.sha`.

## Line shape (one JSON object per line)

```json
{"ts":"<RFC3339Z>","step":"<name>","seq":<n>,"exit":<int|null>, ...step fields...}
```

`seq` monotonic per file. A missing line after a crash pinpoints the crash step:
last present line = last completed step.

## Required swap-leg line vocabulary (extends existing `dispatch`)

| # | step | fields | when |
|---|------|--------|------|
| 1 | `dispatch` | (existing) order sha, run_id | dispatch lands |
| 2 | `consent` | sha, kind=deploy, msgid, topic, quote | swap start — copied verbatim from the ledger row that authorizes this attempt |
| 3 | `backup` | backup_path, backup_sha256, bytes | immediately after backup created. Skip → exit≠0 + skipped_reason; prod swap MUST NOT proceed |
| 4 | `verify` | run_id, source_ref, artifact_sha256, features, verify_exit, provenance | after oc-artifact-verify; verify_exit≠0 HALTS |
| 5 | `install` | old_sha256, new_sha256, bytes, method=install+mv | after atomic mv |
| 6 | `seal` | baseline_path, cycle, seal_exit | after oc-seal-state; seal_exit≠0 HALTS before restart |
| 7 | `restart` | unit, systemd_run_exit | chained unit accepted |
| 8 | `post-verify` | is_active, disk_sha256, expected_sha256, match | post-bounce leg, from the chained unit's output |
| 9 | `marker-write` | deployed_sha_path, deployed_sha, wrote | after marker write (below) |
| 10 | `receipt` | topics[], message_ids/session_notify ids | after receipts posted |
| 11 | `rollback` | restored_backup, restored_sha256, reason | conditional; restart+post-verify lines repeat after it |

## Marker writes (the 03:11Z gap — HQ had to hand-restore)

The swap tooling itself writes, between `seal` and `restart` (so markers reflect
intent even if the restart crashes):

- `STATE_DIR/deployed.sha` — the full 40-char source sha + newline
- `STATE_DIR/deployed.meta.json` — `{sha, run_id, artifact_sha256, features, swapped_at, auth:"auto-swap", prev_sha}` (live marker shape — no `consent_msgid`, consent eliminated 2026-08-28)

`post-verify` re-reads both; any mismatch or absence → its journal line carries
exit=1 and the swap is reported UNSEALED even if the binary answers health.

## Mandatory ledger stamp

Every swap attempt (success OR rollback) ends with a workers-ledger stamp:
`kind="swap-result"`, lane, sha-bound, body quoting journal lines 5+8+9
(install + post-verify + marker-write). Ledger stamp failure ⇒ swap reported
UNSEALED regardless of binary health; the next cron/human check treats UNSEALED
as an incident. No receipt post before the stamp lands.

## Reconstruction test (acceptance criterion)

`kill -9` a staging swap mid-flight. From journal + deployed.* markers ALONE an
operator must answer: which binary is on disk, which step crashed, and whether
consent covered the attempt. Any answer requiring chat history = spec not met.

## Fan-out legs (re-homed from SKILL.md §Session-notify loop, v0.4.80 — lens B F4)

- After a healthy swap the fan-out extracts contributors over
  `<prev-swapped-sha>..<verified-run-headSha>` (right edge = the run's VERIFIED
  headSha, never "current main" — a merge landing mid-build leaves main ahead of
  the binary), notifies each contributing editor's session
  about the new binary, then records `{sha, run_id, contributors}` to the
  baseline state file (`oc-seal-state`; canonical:
  `/root/.opencrabs/profiles/ops/opencrabs-dev/baseline.json`) — its `sha` is
  the left edge of the next attribution range. LIVE since v0.4.37: `oc-deploy
  fanout --run <id>` ([#24](https://github.com/leshchenko1979/opencrabs/issues/24),
  on top of the [#23](https://github.com/leshchenko1979/opencrabs/issues/23)
  session-notify verb `49125f8c`). GREEN leg: git-range → trailers →
  `opencrabs session notify --profile ops`, dead uuid = journal `skip` + note;
  auto-fired at the `swap_execute` tail, idempotent via `fanout.state`;
  `--dry-run` journals but never notifies or marks done. RED leg (`poll` scans
  the latest FAILED run): gh annotations → `git blame` → culprit `Session-Id`
  trailer notified (`role=blamed`), suspect cc on same-file later touchers,
  zero-sites fallback HUMAN-FLAGs all range sessions. Both legs suppressed by
  `OC_DEPLOY_NOFANOUT=1` (drills), subshell-isolated. Journal:
  `/root/.opencrabs/profiles/ops/opencrabs-dev/oc-deploy/journal/fanout-<run>-*.jsonl` (state dir since v0.4.60), steps `fanout-start /
  contributors / attributed / notified / skip / unowned / fanout-end`.
