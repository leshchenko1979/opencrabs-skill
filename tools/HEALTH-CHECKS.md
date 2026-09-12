# HEALTH-CHECKS.md — hourly fleet health & cleanliness

**Owner order 2026-09-11.** Toolsmith owns the cleanup/health process. This file
is the operational runbook and remediation catalog mechanized by `tools/oc-health`
(see `tools/HEALTH-CLASSES.md` for the 8-class architecture and CLI contract).

**Primary rule (owner):** *workers clean after themselves.* A lane that leaves
debris behind owns that debris. This process exists to (a) catch mechanical
debris automatically, and (b) **warn** on quirks — not to silently tidy up
after sloppy lanes and hide the pattern.

**Discipline for every check below:**
- **Report first, remediate only the SAFE class.** Safe = provably dead
  (age > threshold AND no live owner). Never delete anything a live lane may
  still hold; never delete evidence (see *Never touch* at the end).
- **Warn, don't silently fix, on the QUIRK class** — a lane leaving debris is a
  process signal; the health check names the lane/object, it does not erase the symptom.
- **Every remediation prints a receipt line** (what, count, bytes freed). A
  cleanup with no receipt is indistinguishable from a no-op.
- **Idempotent:** running twice in succession must be a no-op the second time.

---

## 1. Stale fanout & wave locks — `SAFE` (reap) + `QUIRK` (warn)

- **Where:** `$OC_DEV_STATE/fanout.lock.<runid>`, `$OC_DEV_STATE/run/wave-*.lock`
- **Content:** `pid=<n> ts=<ISO> run=<n>`
- **Invariant:** Lock age >24h **and** associated PID dead (`kill -0`), or recorded run completed.
- **Remediation (`--reap`):** Remove stale lock; report `reaped N locks`.
- **Quirk form:** A lock whose PID is active but age >24h $\to$ warn, do not reap.

## 2. Orphaned / unregistered worktrees — `SAFE` (report) + `QUIRK` (warn)

- **Where:** `git -C ~/opencrabs worktree list` vs `/root/oc-wt-*` + `/root/oc-work/*`
- **Invariant:** Count registered worktrees vs directories on disk. Flag directories
  with no registration (crashed `oc-wt remove`) and registered worktrees whose
  branch is already merged into main.
- **Remediation:** Report only. Removal is `tools/oc-wt remove <task>` — enforces dirty-tree
  gate and journals deletion; never use raw `rm -rf`.

## 3. Ledger backups — `SAFE` (prune old, keep newest N)

- **Where:** `$OC_DEV_STATE/workers-ledger.json.bak.*`, `*.corrupt-*.bak`, `*.20*.bak`
- **Invariant:** Backups older than 7 days when backup count >3.
- **Remediation (`--reap`):** Keep 3 newest backups, delete older. Never delete a backup
  younger than 24h (crash insurance for active writes).

## 4. State-dir bloat — `REPORT`

- **Where:** `$OC_DEV_STATE` total; per-file top 10.
- **Invariant:** Total state-dir size >200 MB, or any single non-essential file >50 MB.
- **Remediation:** Report; rotation of `tools.log` is a Toolsmith decision, not an automatic one.

## 5. Disk headroom — `REPORT` + `URGENT`

- **Where:** Root filesystem (`df -P /`)
- **Invariant:** Headroom $\ge 85\%$ triggers `WARN`; $\ge 89\%$ triggers `URGENT`.
- **Remediation:** At $\ge 89\%$, execute `vds-servers/scripts/cleanup-unified.sh` (per
  AGENTS.md Gatus rule), then re-verify headroom.

## 6. Shared-checkout cleanliness — `QUIRK` (warn, loud)

- **Where:** `/root/.opencrabs/profiles/ops/skills/opencrabs-dev` (shared skill repository).
- **Invariant:** `git status --porcelain` must be clean of unexpected untracked/modified files.
  Remote tracking must satisfy `HEAD == origin/main == mirror2/main`.
- **Remediation:** Warn only, naming untracked/modified files.

## 7. Version / ledger consistency — `QUIRK`

- **Where:** `SKILL.md` version vs `workers-ledger.json` metadata.
- **Invariant:** `tools/oc-ledger check-version` must report MATCH. Lane `last_acked` must
  not be stale (>7 days).
- **Remediation:** Report; resolution requires `oc-ledger sync` (HQ release flow).

## 8. Cron liveness & routing — `QUIRK` + `SAFE` (re-arm)

- **Where:** OpenCrabs profile cron table (`opencrabs cron list` / DB).
- **Invariant:** Every law-carrying cron has `last_run_at` within $2\times$ its interval
  and `enabled=1`. Delivery target must route to forum chat `-1003936827469` or active session.
- **Remediation:** Re-enable / re-arm; report any silently stopped cron or misrouted delivery.

## 9. Temp accumulation — `SAFE` (prune old)

- **Where:** `/tmp/oc-*`
- **Invariant:** Temporary files/directories older than 48h with no live PID holding them.
- **Remediation (`--reap`):** Delete provably dead files; report count and freed bytes.
  Age check alone is insufficient; live PID verification is mandatory.

## 10. Session DB size — `REPORT`

- **Where:** `$HOME/.opencrabs/profiles/ops/opencrabs.db`
- **Invariant:** Warn if SQLite database file exceeds 1 GB.
- **Remediation:** Report to operator/Toolsmith.

## 11. `tools.log` JSONL integrity — `QUIRK` (report only)

- **Where:** `$OC_DEV_STATE/tools.log` (`OC_HEALTH_LOG` overrides).
- **Invariant:** Total line count must match JSON-parsable lines (`jq -Rr 'fromjson? | .ts'`).
- **Remediation:** Report only — never rewrite or delete audit evidence.
  Known historical non-JSON evidentiary lines (e.g. line 443 actor-correction) remain immutable.

## 12. Detached watcher compliance — `WARN` (report only)

- **Where:** `$HOME/.opencrabs/profiles/ops/tmp/detached/*.json` (`OC_HEALTH_DETACHED_DIR` overrides).
- **Invariant:** No detached task inside the **rolling window** may run `gh run watch`
  with no `--interval` (the forbidden 3s default) or at an interval other than 30/60;
  no `nohup` launches; no hand-rolled `while … sleep` pollers.
- **Window:** `OC_HEALTH_WATCHER_WINDOW_H` (default **24**; `0` = all history). Tasks
  spawned before `now − N hours` are not re-audited, so a long-terminal task stops
  re-alarming once it ages out.
- **Count semantics:** the finding carries the **real** number of violations plus a
  per-type breakdown (`[UNTHROTTLED_WATCHx3 NOHUP_SPAWNx1]`) and the count of
  violations whose task state is still `Running`. A payload that cannot be parsed is
  a **measurement failure** (`QUIRK unthrottled-watch-unparsed`, rc 3), never a
  fabricated count.
- **Remediation:** Report only — the audit names the offending lane; a sweep must not
  rewrite another lane's detached-task record.

## 13. Ledger JSON integrity — `URGENT` (report only)

- **Where:** `$OC_DEV_STATE/workers-ledger.json`.
- **Invariant:** File parses as JSON.
- **Remediation:** Report only; corrupting evidence is never the fix.

## 14. Ledger roster consistency — `QUIRK` (report only)

- **Where:** `$OC_DEV_STATE/workers-ledger.json`.
- **Invariant:** Every enrolled worker carries the fields the roster verbs require.
- **Remediation:** Report only — HQ owns roster repair.

## 15. Tool failure-rate — `REPORT`

- **Where:** `$OC_DEV_STATE/tools.log` (`OC_HEALTH_LOG` overrides).
- **Invariant:** For any tool with ≥10 invocations, a failure rate above 15% is reported.
- **Remediation:** Report to operator/Toolsmith — a high-rate tool is a tool defect signal.

## 16. Daemon error volume — `WARN` (report only)

- **Where:** `$HOME/.opencrabs/profiles/ops/logs/opencrabs.<today>`.
- **Invariant:** Warn above 50 ` ERROR ` lines in the current UTC day.
- **Remediation:** Report only. A nonzero baseline is expected: ordinary non-zero tool
  exits (`[TOOL_EXEC] … failed: code X`) are logged as errors, so the check flags
  volume, not correctness.

## 17. Issue claim structure — `REPORT`

- **Where:** `$OC_DEV_STATE/workers-ledger.json` claim events.
- **Invariant:** No open claim without an owning session uuid.
- **Remediation:** Report to Triage/HQ, who own issue routing.

---

## Never touch (evidence / live state)

- `workers-ledger.json` itself, `tools.log`, `journal/`, `incident-evidence-*`,
  `reviews/`, `designs/`, `smoke-verdicts.log`, `orders.json`, `baseline.json`.
- Any file held open by a live PID.
- Any worktree with a dirty tree (uncommitted work).
- Historical evidentiary entries in logs/ledgers.

## Escalation

- **Quirks:** Single-line summary naming the object/lane and failed check.
- **Clean Bill:** Explicitly report objects checked and 0 findings (silence is not a receipt).
- **Recurring Quirks:** Escalate to HQ when the same check fires repeatedly across cycles.
