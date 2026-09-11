# HEALTH-CHECKS.md — hourly fleet health & cleanliness

**Owner order 2026-09-11.** Toolsmith owns the cleanup/health process. This file
is the canonical check list + remediation; the hourly cron reads it.

**Primary rule (owner):** *workers clean after themselves.* A lane that leaves
debris behind owns that debris. This process exists to (a) catch the mechanical
debris nobody notices, and (b) **warn** on quirks — not to silently tidy up
after sloppy lanes and hide the pattern.

**Discipline for every check below:**
- **Report first, remediate only the SAFE class.** Safe = provably dead
  (age > threshold AND no live owner). Never delete anything a live lane may
  still hold; never delete evidence (see *Never touch* at the end).
- **Warn, don't silently fix, on the QUIRK class** — a lane leaving debris is a
  process signal; the cron names the lane, it does not erase the symptom.
- **Every remediation prints a receipt line** (what, count, bytes freed). A
  cleanup with no receipt is indistinguishable from a no-op.
- **Idempotent:** running it twice in an hour must be a no-op the second time.

---

## 1. Stale fanout locks — `SAFE` (reap) + `QUIRK` (warn)

- **Where:** `$OC_DEV_STATE/fanout.lock.<runid>`
- **Content:** `pid=<n> ts=<ISO> run=<n>`
- **Check:** lock whose `ts` is older than 24 h **and** whose `pid` is not alive
  (`kill -0`), or whose recorded `run` is completed.
- **Remediation:** `rm` it; report `reaped N locks`.
- **Why:** 50 accumulate from Sep 1; they are per-run markers, never reaped. A
  stale lock is also a false "in flight" signal for the next wave.
- **Quirk form:** a lock whose pid IS alive but is >24 h old → warn, do not reap.

## 2. Orphaned / unregistered worktrees — `SAFE` (report) + `QUIRK` (warn)

- **Where:** `git -C ~/opencrabs worktree list` vs `/root/oc-wt-*` + `/root/oc-work/*`
- **Check:** count registered worktrees vs directories present on disk; list
  directories with **no registration** (left behind by a crashed `oc-wt remove`)
  and registered worktrees whose **branch is already merged** into main.
- **Remediation:** report only. Removal is `tools/oc-wt remove <task>` — it has a
  dirty-tree gate and journals what it destroys; a raw `rm -rf` would skip both.
- **Observed 2026-09-11:** **198 dirs on disk vs 119 registered** — 79 orphans.
  This is the single biggest disk/entropy sink.

## 3. Ledger backups — `SAFE` (prune old, keep newest N)

- **Where:** `workers-ledger.json.bak.*`, `*.corrupt-*.bak`, `*.20*.bak`
- **Check:** count + total bytes; list those older than 7 days.
- **Remediation:** keep the 3 newest, delete the rest. Never delete a backup
  younger than 24 h (it may be the only copy after a bad write).
- **Observed:** 7 backups × ~600–800 KB. The ledger itself is the live artifact;
  these are crash insurance, not history.

## 4. State-dir bloat — `REPORT`

- **Where:** `$OC_DEV_STATE` total; per-file top 10.
- **Check:** total > 200 MB, or any single non-essential file > 50 MB.
- **Observed 2026-09-11:** 283 MB total; `tools.log` 2.7 MB,
  `workers-ledger.json` 788 KB.
- **Remediation:** report; rotation of `tools.log` is a Toolsmith decision, not
  an automatic one (it is audit evidence).

## 5. Disk headroom — `REPORT` + `URGENT`

- **Check:** `df -h /` → warn at ≥85%, **urgent** at ≥89%.
- **Remediation:** at ≥89% run `vds-servers/scripts/cleanup-unified.sh` (per
  AGENTS.md Gatus rule), then re-check.
- **Observed:** 66% (38 G / 58 G).

## 6. Shared-checkout cleanliness — `QUIRK` (warn, loud)

- **Where:** `/root/.opencrabs/profiles/ops/skills/opencrabs-dev` (shared main
  checkout every lane reads).
- **Check:** `git status --porcelain` — untracked or modified files that are NOT
  expected receipts.
- **Remediation:** **warn only, name the files.** An untracked tool in the shared
  checkout is one `git add -A` from being committed under the wrong identity.
  This is exactly how the untracked `tools/oc-roster*` pair appeared 08:00Z.
- **Also:** confirm `HEAD == origin/main == mirror2/main`; a divergence here means
  a lane pushed to one remote only.

## 7. Version / ledger consistency — `QUIRK`

- **Check:** `tools/oc-ledger check-version` → MISMATCH means SKILL.md and the
  ledger disagree. Also `tools/oc-drift-check` for lanes whose `last_acked` is
  stale (>7 days) — the roster's version-compliance read depends on it.
- **Remediation:** report; the fix is an `oc-ledger sync` (Supervisor release
  flow), not a tool action.

## 8. Cron liveness — `QUIRK` + `SAFE` (re-arm)

- **Check:** every **law-carrying** cron (harvest-watch-4h, oc-waiter-sweep,
  this health job) has `last_run_at` within 2× its interval and `enabled=1`.
- **Remediation:** re-enable / re-arm; report a cron that has silently stopped.
- **Also (owner 2026-09-11):** every dev cron must deliver to the forum chat
  `-1003936827469` — flag any cron whose `deliver_to` is a private DM or null.
  (The `oc-waiter-sweep` DM leak was exactly this class.)

## 9. Temp accumulation — `SAFE` (prune old)

- **Where:** `/tmp/oc-*`
- **Check:** files older than 48 h that no live pid holds.
- **Remediation:** delete; report count + bytes.
- **Observed:** 22 files, /tmp at 48 MB. Some are load-bearing while a chain
  runs (`/tmp/oc-150-resume.sh` is a live detached resume script) — **age + pid
  check is mandatory, never age alone.**

## 10. Session DB size — `REPORT`

- **Check:** `du -sh opencrabs.db`; warn > 1 GB.
- **Observed:** **723 MB.** Growing; not urgent, but it is the largest single
  artifact under the profile.

---

## Never touch (evidence / live state)

- `workers-ledger.json` itself, `tools.log`, `journal/`, `incident-evidence-*`,
  `reviews/`, `designs/`, `smoke-verdicts.log`, `orders.json`, `baseline.json`.
- Any file held open by a live pid.
- Any worktree with a dirty tree (its changes may be the only copy).
- Line 443 of `tools.log` is an evidentiary actor-correction — history is not
  edited for tidiness.

## Escalation

- **Quirks** → one line per quirk naming the file/lane + the check number.
- **Nothing found** → report that, with the counts checked (silence is not a
  clean bill of health).
- **Recurring quirk** (same check fires N hours running) → escalate to HQ as a
  process defect, not a cleanup item.
