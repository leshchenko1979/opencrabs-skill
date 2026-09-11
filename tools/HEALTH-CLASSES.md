# HEALTH-CLASSES.md — 8-Class Rotating System Health & Cleanliness Architecture

**Owner order 2026-09-11.** Toolsmith owns the cleanup/health process.
This document defines the 8-class rotating system object health catalog,
mechanized by `tools/oc-health`.

---

## 1. Architecture: Base Invariants vs. Rotating Classes

A monolithic sweep inspecting every fleet subsystem every hour creates
unnecessary I/O pressure and API churn. The 8-class rotation divides checks
into two tiers:

1. **Base Invariants (Every Run):**
   Fast, critical measurements executed on every invocation:
   - Root filesystem headroom (`df -P /` warn at 85%, urgent at 89%)
   - Critical deadlock locks (`fanout.lock.*`, `run/wave-*.lock` >24h with dead owner PID)
   - Snapshot mirror and stale `/tmp/oc-*` cleanup (when `--reap` is passed)

2. **Rotating Class (1 Class per Hourly Run or `--class <name>`):**
   One class from the 8-class ring is selected per run (advancing round-robin
   in `health-rotation.json`). A full deep audit across all 8 classes completes
   every 8 hours. Running `oc-health --all` or `oc-health --class all` executes
   all 8 classes in a single pass.

---

## 2. The 8 System Object Classes

```
                   ┌──────────────────────────────────┐
                   │    Base Critical Invariants      │
                   │ (Disk Headroom / Deadlock Locks) │
                   └────────────────┬─────────────────┘
                                    │
    ┌───────────────┬───────────────┼───────────────┬───────────────┐
    ▼               ▼               ▼               ▼               ▼
1. filesystem  2. runtime_procs 3. persistence    4. git_vcs   5. schedulers
    │                                                               │
    └───────────────┬───────────────────────────────┬───────────────┘
                    ▼                               ▼
              6. fleet_lanes                     7. logs
                    │
                    ▼
            8. issue_portfolio
```

### Class 1: `filesystem`
- **Objects Audited:** `/tmp`, `$OC_DEV_STATE`, worktrees, logs.
- **Invariants Checked:**
  - Inode usage and disk headroom (`df -P /`).
  - Stale fanout/wave locks (`fanout.lock.*`, `run/wave-*.lock`, `run/wave-*.sent`).
  - Stale temporary scratch directories (`/tmp/oc-*` >48h) and dead PID snapshot mirrors (`oc-snap-*-<pid>`).
  - State directory bloat (`$OC_DEV_STATE` >200MB).
- **Remediation:** Under `--reap`, prune dead locks, dead mirrors, and tmp >48h.

### Class 2: `runtime_procs`
- **Objects Audited:** Live processes, detached jobs (`tmp/detached/*.json`), background watchers.
- **Invariants Checked:**
  - Unthrottled `gh run watch` invocations (missing `--interval 30|60`).
  - Banned `nohup` subshell launches.
  - Handrolled sleep/polling loops.
  - Zombie/orphan background worker processes.
- **Remediation:** Report via `QUIRK`; notify owning lanes if processes are orphaned.

### Class 3: `persistence`
- **Objects Audited:** `opencrabs.db`, `workers-ledger.json`, backup artifacts.
- **Invariants Checked:**
  - Session SQLite DB size (>1GB).
  - Ledger backup retention (keep 3 newest; never delete <24h).
  - Ledger JSON schema integrity and JSON syntax validity.
  - Backup file bloat and corruption markers (`*.corrupt-*.bak`).
- **Remediation:** Under `--reap`, prune ledger backups beyond keep count.

### Class 4: `git_vcs`
- **Objects Audited:** Skill repo (`opencrabs-dev`), fork repo (`~/opencrabs`), worktree directories.
- **Invariants Checked:**
  - Orphaned / unregistered worktree directories on disk (`/root/oc-work/*`, `/root/oc-wt-*` vs `git worktree list`).
  - Shared skill checkout cleanliness (`git status --porcelain`).
  - Remote tracking divergence (`HEAD` vs `origin/main` vs `mirror2/main`).
  - Version/ledger consistency (`oc-ledger check-version`).
- **Remediation:** Report only. Worktree removal must use `oc-wt remove` (dirty-tree safety gate).

### Class 5: `schedulers`
- **Objects Audited:** `cron_jobs` table in `opencrabs.db`.
- **Invariants Checked:**
  - Law-carrying dev crons enabled (`harvest-watch-4h`, `oc-roster-detached-sweep`, `oc-health-hourly`).
  - Dev cron delivery routing: zero leaks to private DMs (positive Telegram chat ID or hardcoded owner ID).
  - Blank `deliver_to` allowed when cron delivers internally via `session_notify`.
- **Remediation:** Flag disabled crons and DM leaks via `QUIRK`.

### Class 6: `fleet_lanes`
- **Objects Audited:** Roster records in `workers-ledger.json`, active session bindings.
- **Invariants Checked:**
  - Roster integrity: valid JSON, duplicate session UUIDs, missing role tags.
  - Dead session IDs registered as active/live workers.
  - Unclaimed/orphaned work claims or unclosed task markers.
- **Remediation:** Report via `REPORT` / `QUIRK`; update roster via `oc-ledger roster-retire` if authorized.

### Class 7: `logs`
- **Objects Audited:** `$OC_DEV_STATE/tools.log`, `opencrabs.YYYY-MM-DD`, channel attachments.
- **Invariants Checked:**
  - `tools.log` JSONL syntax integrity (0 malformed lines; name historical non-JSON lines without modifying evidence).
  - Anomaly spikes in daemon log (recurring `ERROR` or malformed skill frontmatter warnings).
  - Tool execution failure rate: flag any `oc-*` tool with >15% non-zero exit rate in the last 24h.
  - Execution jitter: flag tool invocations taking >10s (e.g. heavy worktree scans).
- **Remediation:** Report only. Never delete or rewrite log evidence.

### Class 8: `issue_portfolio`
- **Objects Audited:** Fork issues (`leshchenko1979/opencrabs`), upstream issues (`adolfousier/opencrabs`), ledger issue claims.
- **Invariants Checked:**
  - Unassigned open issues on the fork lacking a worker claim in `workers-ledger.json`.
  - Stale / abandoned claims: issues claimed in ledger where lane has had 0 commits >48h.
  - Ghost claims: issues closed on GitHub but still listed as active claims in ledger.
  - Branch linkage drift: claimed issue branch deleted from git remotes.
- **Remediation:** Report via `REPORT` / `QUIRK` for Triage/HQ assignment.

---

## 3. Rotation State Schema (`health-rotation.json`)

Location: `$STATE/health-rotation.json` (overridden by `OC_HEALTH_ROTATION_FILE`).

```json
{
  "version": 1,
  "current_class": "logs",
  "next_class": "issue_portfolio",
  "last_rotated_at": "2026-09-11T22:00:00Z",
  "cycle_count": 42,
  "history": {
    "filesystem": { "last_run": "2026-09-11T16:00:00Z", "findings": 1, "reaped": 72 },
    "runtime_procs": { "last_run": "2026-09-11T17:00:00Z", "findings": 0, "reaped": 0 },
    "persistence": { "last_run": "2026-09-11T18:00:00Z", "findings": 0, "reaped": 0 },
    "git_vcs": { "last_run": "2026-09-11T19:00:00Z", "findings": 0, "reaped": 0 },
    "schedulers": { "last_run": "2026-09-11T20:00:00Z", "findings": 0, "reaped": 0 },
    "fleet_lanes": { "last_run": "2026-09-11T21:00:00Z", "findings": 0, "reaped": 0 },
    "logs": { "last_run": "2026-09-11T22:00:00Z", "findings": 1, "reaped": 0 },
    "issue_portfolio": { "last_run": "2026-09-11T15:00:00Z", "findings": 0, "reaped": 0 }
  }
}
```

---

## 4. CLI Contract & Flags

```bash
oc-health [--class <name>|--all] [--rotate] [--status] [--reap] [--json] [--quiet] [--selftest]
```

- `--class <name>`: Explicitly execute a specific class (`filesystem`, `runtime_procs`, `persistence`, `git_vcs`, `schedulers`, `fleet_lanes`, `logs`, `issue_portfolio`, or `all`).
- `--all`: Execute all 8 classes in a single pass.
- `--rotate`: (Default when `--class` is omitted) Execute base invariants + the next rotating class, advancing `health-rotation.json`.
- `--status`: Display current rotation state, last execution time per class, and next class up.
- `--reap`: Apply safe remediations (stale locks, backups > keep, dead mirrors, tmp > 48h).
- `--json`: Output machine-readable JSON matching the cron delivery contract.
- `--quiet`: Print only findings, suppressing clean lines.
- `--selftest`: Hermetic offline test suite verifying all 8 classes and rotation engine.

---

## 5. Exit Code Conventions

- `0`: Clean (no findings in active class or base invariants).
- `1`: Findings present (`WARN`, `QUIRK`, `REPORT`, or `URGENT`).
- `2`: CLI usage / argument syntax error.
- `3`: Measurement failure (a required subsystem or check failed to measure).
