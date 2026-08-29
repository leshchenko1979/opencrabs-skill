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

`STATE_DIR/oc-deploy/journal/swap-<sha>-<epoch>.jsonl` — one file per swap attempt,
append-only, every line fsync'd before the next step starts. (Live oc-deploy
writes the FULL 40-char sha + an epoch suffix — never a short sha: two swaps of
the same sha would collide on a short form.) STATE_DIR = the state
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
