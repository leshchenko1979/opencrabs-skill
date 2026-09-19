## Lens B — AGENTS.md (ops profile brain, 3 finding blocks)

FINDING 1: Retired sqlite3 / binutils history and verbose explanation
  CLASS: CACHE
  QUOTE: (before that order, verified 2026-09-19: not on `PATH`, not on disk, and **never a package on this host** — `dpkg-query -W sqlite3` → `unknown ok not-installed`; `/var/log/dpkg.log` and `/var/log/apt/history.log`, both covering 2026-02-17 → 09-19, carry 0 sqlite3 lines and 0 `remove`/`purge` lines; `/var/backups/dpkg.status.0` has no `Package: sqlite3` entry and the only sqlite3 hit in `apt.extended_states` is `libsqlite3-0`. So there was **no removal to attribute** — the CLI was never part of this host's declared spec. `sh: 1: sqlite3: not found` (code 127) hit five sessions on 09-19 (`6ca0d547` ×3, `2646d31a` ×2, `23549292` ×2, `1122b15e` ×1, `63d775f9` ×1), and AGENTS.md itself prescribed the missing command. **Never infer that it once worked from a clean grep:** a caller that appends `2>/dev/null` hides this error, so a count of log lines is not a count of executions). Working readers: `python3 -c "import sqlite3; c=sqlite3.connect('file:<home>/opencrabs.db?mode=ro',uri=True); c.execute(...)"` (module present, SQLite 3.45.1 — note `python3 - <<EOF` heredocs are refused by the bash tool, so pass `-c` or write a script file), or the hand-built `/root/sqlite-recover-build/sqlite3-recover "file:<home>/opencrabs.db?mode=ro" "<sql>"` (3.45.1, verified reading the live DB). **`apt-get install sqlite3` was forbidden and is now ALLOWED** — the owner order above (2026-09-19 10:52Z) supersedes that clause. **`binutils` (the `strings(1)` provider) was likewise ABSENT from this host and is now ALLOWED — owner order "Install strings", 2026-09-19: `apt-get install -y binutils` rc=0 → `/usr/bin/strings`, GNU Binutils 2.42, `dpkg -l binutils` = `ii`.** Two consequences worth knowing: (a) `strings` and a raw-byte scan AGREE on the live binary (markers `incremental_vacuum`=4, `attempting bounded reclaim`=1 by both methods), so the pre-order hand-rolled byte-scan workaround is now cross-validated, not replaced; (b) the install SILENTLY ACTIVATED a dormant code path — `oc-artifact-verify` gates its marker leg on `command -v strings`, so that branch had never executed on this box and now does. The general rule stands for every *other* system package: an owner order must NAME the package, and it authorizes only that package. The intent of this clause is unchanged and is the part that matters: **read in place via the URI; never copy the DB.** Copying the file to `/tmp` to query it is BOTH stale (paragraph above) and a disk leak — on 2026-09-18 one cron lane minted five 1.1 GB copies of `profiles/ops/opencrabs.db` in 75 minutes (5.2 GB into a 58 G disk) because it re-derived the read path after a compaction instead of finding it written down. If you are about to `cp` a `.db` file, stop and use the URI form. **A 0-byte `*.db` stub is legacy residue, not an empty database — and a stub is identified by (PATH, SIZE), never by name alone** (correction 2026-09-18, Infra Factory HQ, verified across all five stub names). Nine such stubs sat across the profile homes (`cron.db`, `state.db`, `memory.db`, `hermes.db`, `feedback_ledger.db`); all nine were **deleted 2026-09-18 on owner order**, each verified 0 B with no fd holder and its live counterpart confirmed non-empty first. The name-only test is the trap: `grep -rn 'cron.db' src/` → 0 matches would have read as "unreferenced, safe to delete" — but the SAME test on `memory.db` returns **28 matches**, because `memory.db` is the LIVE store name (`memory_dir().join("memory.db")` = `<home>/memory/memory.db`, 395,833,344 B). Every one of those 28 hits is the real path or a test-local tempdir; **none** is the profile-root stub. So a stub shares a filename with a live DB and differs only in PATH — never infer "unreferenced" or "empty" from a name match, and never diagnose from a stub: opening one returns nothing, which is indistinguishable from "no state". (lines 45-45)
  WHY: This 5,087-character block caches ephemeral forensics logs, obsolete package absences, and historical stub investigations that can be verified live or kept in MEMORY.md.
  FIX: Condense line 45 to state the positive command rule: `**Reading daemon state: the mode=ro URI IS the read path — never copy the DB in order to read it.** Read host DB via sqlite3 "file:<home>/opencrabs.db?mode=ro" "<sql>" or python3 sqlite3 module. In containers, use python3 module.`
  LOC: 0

FINDING 2: No-op conversational filler in Core Behaviors
  CLASS: NO-OP
  QUOTE: - **Loyalty is non-negotiable.** Finish what you start. (line 74)
  WHY: "Loyalty is non-negotiable" is purely emotive prose that does not change LLM execution behavior vs default instructions.
  FIX: Delete the bullet point or merge actionable intent into execution rules.
  LOC: -1

FINDING 3: Factory-specific Grafana rule in global always-loaded AGENTS.md
  CLASS: WRONG-SCOPE
  QUOTE: - **Grafana panel self-check (owner order 2026-09-15):** Whenever modifying or deploying Grafana dashboards or panel queries, always self-check EVERY panel against live data queries and layout geometry (see `/grafana` skill tools `skills/grafana/tools/grafana-verify` and `grafana-test-panels`) before reporting completion. A dashboard change is never done on deploy alone — verify that all charts return non-empty series and render without overlaps. (line 72)
  WHY: Rules specific to Grafana dashboard verification belong in the `/grafana` skill, not in the always-loaded ops runbook.
  FIX: Remove this bullet from AGENTS.md and rely on the `/grafana` skill definition.
  LOC: -1

FINDING 4: Factory-specific outreach database storage rule in global AGENTS.md
  CLASS: WRONG-SCOPE
  QUOTE: # Outreach storage rule (2026-08-25)

Outreach campaign operational state lives in Postgres `ai_spam_bot` schema `outreach` on apps (targets/candidates/sends/replies/state). Single writer: `outreach/lib/db.py`. The ai-antispam-outreach repo stores code, plans, and nightly `export/*.jsonl` snapshots only — never edit repo JSON as if it were live state. Cron `ai-antispam-outreach-db-sync` runs `export_db.py` (DB→repo); the old repo→DB `etl_sends.py` direction is retired (caused double-writer duplication). (lines 240-243)
  WHY: Database schema and storage specifics for the `ai_spam_bot` outreach campaign belong in the `skills/outreach-reply-sweep` or ai-antispam repo skills rather than the global ops runbook.
  FIX: Move the section to `skills/outreach-reply-sweep/SKILL.md` and remove it from AGENTS.md.
  LOC: -5

FINDING 5: Redundant opencrabs-dev dev process laws inline in AGENTS.md
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: All opencrabs-dev owner rulings (remotes/sync policy, upstream PR law, carriers/builds, cargo prohibition, telegram surface law, tool logging rule, discussion links + fix-approval gate, upstream filings, stage-entry consent, no-auto-rollback, post-swap fanout, attribution guard, PR naming, CI-wait discipline, creating new editors, HQ triage routing, cadence stamping, fork-issue standdowns) live in `~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md`. Load the `/opencrabs-dev` skill before ANY opencrabs-dev work (editors do; HQ loads it for triage, merges, and editor creation).

Kept in this file: execution discipline, core behaviors, Gatus runbook, SSH targets, browser tasks, file delivery, mermaid syntax, dynamic tools, memory rule, outreach, session rules. (lines 249-251)
  WHY: The file explicitly states opencrabs-dev rules belong in `fleet-directives.md`, but then restates dozens of opencrabs-dev laws inline across later sections.
  FIX: Maintain only the one-line recovery anchor pointer and delegate opencrabs-dev process governance to `fleet-directives.md`.
  LOC: -4

FINDING 6: Unformatted dangling order line outside section structure
  CLASS: SPRAWL
  QUOTE: owner order 2026-09-07 09:34Z: always use the project's codified ontology when one exists — if a project has official terms (e.g. opencrabs-dev's ontology in fleet-directives.md), use those exact terms in reports and explanations; never invent shorthand (e.g. "cron card") when a codified name exists. If the term is NOT codified, say so explicitly and define it in plain words on first use. (line 281)
  WHY: An unformatted paragraph sits orphaned between subsection boundaries, bloating the file with unindexed text.
  FIX: Format as a standard bullet in Execution Discipline or integrate into fleet-directives.md ontology guidance.
  LOC: 0

FINDING 7: Opencrabs-dev PR smoke rubric inline in global AGENTS.md
  CLASS: WRONG-SCOPE
  QUOTE: ## Smoke rubric — 4 legs required (v0.4.125)

**NEVER file unsmoked PRs (hard rule, owner order 2026-09-11):** A PR may NEVER be filed against upstream (or marked ready for shipping/harvest) without a verified 4-leg smoke pass (Lineage, Identity, CI Gate, Behavioral probe or structural N/A) recorded with live receipts in `smoke-verdicts.log`. Filing an unsmoked PR or claiming harvest readiness without a live behavioral proof on the running binary is a critical process breach.

**Live verification stamp required for live-testable UX features (hard rule, owner order 2026-09-16):** For any UX, UI, card rendering, interactive command, or user-facing feature that is live-testable on the running binary, static binary string probes or symbol searches alone are STRICTLY FORBIDDEN as proof of a smoke PASS. Binary strings prove only that code was compiled into the artifact; they do not prove runtime execution or UI correctness. A smoke PASS for live-testable UX features requires an explicit live behavioral execution receipt stamped into the stamp system (`smoke-verdicts.log` / `workers-ledger.json`). If the behavioral verification cannot be fully automated and requires the owner's visual inspection, the lane MUST record `PARKED-OWNER-EYE` naming the exact owner action and packaging sha — never substitute a binary string probe for a live UX verification.

Verification requires (1) lineage, (2) identity, (3) CI gate, (4) live behavioral probe or structural N/A. Canon: `skills/opencrabs-dev/upstream-merge-runbook.md §Upstream-merge cadence · HARVEST LAW · NO-HOLD`. (lines 288-295)
  WHY: PR verification laws bind only opencrabs-dev editor sessions and already have a canon cited in `upstream-merge-runbook.md`.
  FIX: Remove the section from AGENTS.md and rely on the canon pointer in `upstream-merge-runbook.md`.
  LOC: -9

FINDING 8: Meta-factory boundary explanation in global AGENTS.md
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: ## Miidas factory — its HQ lane (owner order 2026-09-11 12:37Z)

The **Miidas Factory** group (`-1003996392908`) is a member factory's own surface, and this profile serves its **HQ lane**: the session bound to **topic 4** — `e4f96a33-45ac-412e-8788-1b678cf2addb`, owner-designated 2026-09-11 ("This is the HQ session"). Supervising that factory's process is that lane's job and is **not** a breach of the meta-factory boundary above — that boundary governs the **Factories** group (meta-factory HQ topic 21, Delegate topic 68), which analyses factories and talks to member HQs, never implementing for them. Canonical Miidas process law: `skills/miidas/SKILL.md` — load it before ANY miidas task. (lines 327-329)
  WHY: Factory-specific topic assignments and meta-factory relationship justifications violate the rule that factory laws live in their own skills (`skills/miidas/SKILL.md`).
  FIX: Remove the section and maintain the rule in `skills/miidas/SKILL.md`.
  LOC: -3

FINDING 9: Specific bot skill link boilerplate for avito-realty-bot
  CLASS: WRONG-SCOPE
  QUOTE: ## avito-realty-bot — its law lives in its own skill (owner order 2026-09-12)

The Avito realty bot (AI agent running Vadim's Avito dialogues) has its own skill:
**`skills/avito-realty-bot/SKILL.md`** — sourced from the project repo
`/root/avito-realty-bot/skills/avito-realty-bot/` via symlink, so it is versioned with the code.
Load it before ANY avito task: a code change, a deploy, a dialogue diagnosis, or a Vadim/Alexey question.
It carries the engage gate, the deploy path, the live Avito API paths, and the known-traps playbook.
New avito rules go THERE, not here. (lines 342-349)
  WHY: Stating that a factory's rules live in its own skill is already covered by the generic factory law (§Agent factories) and should not be repeated per project.
  FIX: Delete the dedicated Avito section as it is subsumed by the generic factory pointer rule.
  LOC: -9

FINDING 10: Verbose retrospective narrative on cron repacing incident
  CLASS: SPRAWL
  QUOTE: Owner order in the `Opencrabs Dev Factory` chat at **21:15:10Z**: *"Pace them all to
every 6h or less frequent"* (daemon log line 839008, sender Алексей 133526395).
Applied the same evening across all factories. **Verified independently by the
ai-antispam Triage lane on 2026-09-18: 0 enabled jobs on the box have a sub-6 h
minimum gap** — a cron-parsing census over all 34 rows, not a `LIKE` pattern (the
pattern form reports 0 while missing `*/2`-style schedules entirely, i.e. it can
only ever return the answer you want). The repacing lane's own count of its edits
was **14**; this lane counted **11 rows with `updated_at` in its 21:49Z sweep
window** — the two figures are not reconciled, and the load-bearing claim is the
outcome (0 sub-6 h), which is verified. State a repace count only with the
predicate that produced it. (lines 395-405)
  WHY: Paragraph-length incident narratives and census count reconciliations bloat the core rule ("crons must not fire more often than every 6h").
  FIX: Replace the narrative paragraph with a single-line rule statement: `**Cadence floor:** No cron job may fire more often than every 6 h (owner order 2026-09-18).`
  LOC: -10

FINDING 11: Explanatory background on cgroup memory limits
  CLASS: CACHE
  QUOTE: **Resized 2026-09-18 22:45Z: the host is now 4 cores / 3921 MiB RAM** (verified `free -m`
2026-09-19; the earlier "1 vCPU / 961 MiB" figure is DEAD — do not quote it). **The binding
constraint is no longer the host but the unit's own cgroup — and these are USER-scope units,
so read them from the user manager.** All three daemons are systemd *user* services
(`/root/.config/systemd/user/opencrabs{,-ops,-family}.service`, cgroup under
`user.slice/user-0.slice/user@0.service/app.slice/opencrabs*.service`; command surface in
TOOLS.md §Service Control). **The trap: a system-scope `systemctl show opencrabs-ops`
resolves to a STUB and reports `MemoryHigh=infinity` with an empty `FragmentPath` — a false
"no caps" reading, not a cap that was lifted** (hit first-hand 2026-09-19). Correct read:
`XDG_RUNTIME_DIR=/run/user/0 systemctl --user show opencrabs-ops -p MemoryHigh,MemoryMax,MemoryCurrent,MemoryPeak`
or the cgroup files directly. All three carry the same `MemoryHigh=768M` / `MemoryMax=1G`
pair (verified 2026-09-19 08:5xZ): **ops 767.8 MiB current / 768.6 MiB peak** — 0.2 MiB of
headroom under the soft cap, peak already **past** it — default 387.7 MiB, family 15.5 MiB.
The cap is not theoretical: the ops cgroup's `memory.events` reads **`high 1598`** (throttled
or reclaimed 1,598 times) with `oom_kill 0`, and `OOMPolicy=continue` means a kill costs a
tool call rather than a restart (the call is lost either way). So memory is a cgroup
decision, not a host one, and the budget below is UNCHANGED by the resize — a 200 MB child is
**just over a quarter (26%) of the daemon's 768 MiB soft cap**, yet only 5% of host RAM,
which is exactly why the host figure must never be the basis. Every script decision stays a
memory decision. (lines 463-481)
  WHY: Restates static systemd service layouts, cgroup path debugging, and historical event counts that can be inspected via CLI tools.
  FIX: Trim the preamble to state the rule and measurement command directly: `**Script RSS limit: 200 MB.** Read user cgroup via XDG_RUNTIME_DIR=/run/user/0 systemctl --user show opencrabs-ops -p MemoryHigh,MemoryMax,MemoryCurrent.`
  LOC: -17

TOTAL FINDINGS: 11 | NET LOC: -60


FINDING 1: Inlined history and package forensics for sqlite3 and binutils
  CLASS: CACHE
  QUOTE: The pre-order history is kept because it explains why the URI form is the read path at all: (before that order, verified 2026-09-19: not on `PATH`, not on disk, and **never a package on this host** — `dpkg-query -W sqlite3` → `unknown ok not-installed`; `/var/log/dpkg.log` and `/var/log/apt/history.log`, both covering 2026-02-17 → 09-19, carry 0 sqlite3 lines and 0 `remove`/`purge` lines; `/var/backups/dpkg.status.0` has no `Package: sqlite3` entry and the only sqlite3 hit in `apt.extended_states` is `libsqlite3-0`. So there was **no removal to attribute** — the CLI was never part of this host's declared spec. `sh: 1: sqlite3: not found` (code 127) hit five sessions on 09-19 (`6ca0d547` ×3, `2646d31a` ×2, `23549292` ×2, `1122b15e` ×1, `63d775f9` ×1), and AGENTS.md itself prescribed the missing command. **Never infer that it once worked from a clean grep:** a caller that appends `2>/dev/null` hides this error, so a count of log lines is not a count of executions). Working readers: `python3 -c "import sqlite3; c=sqlite3.connect('file:<home>/opencrabs.db?mode=ro',uri=True); c.execute(...)"` (module present, SQLite 3.45.1 — note `python3 - <<EOF` heredocs are refused by the bash tool, so pass `-c` or write a script file), or the hand-built `/root/sqlite-recover-build/sqlite3-recover "file:<home>/opencrabs.db?mode=ro" "<sql>"` (3.45.1, verified reading the live DB). **`apt-get install sqlite3` was forbidden and is now ALLOWED** — the owner order above (2026-09-19 10:52Z) supersedes that clause. **`binutils` (the `strings(1)` provider) was likewise ABSENT from this host and is now ALLOWED — owner order "Install strings", 2026-09-19: `apt-get install -y binutils` rc=0 → `/usr/bin/strings`, GNU Binutils 2.42, `dpkg -l binutils` = `ii`.** Two consequences worth knowing: (a) `strings` and a raw-byte scan AGREE on the live binary (markers `incremental_vacuum`=4, `attempting bounded reclaim`=1 by both methods), so the pre-order hand-rolled byte-scan workaround is now cross-validated, not replaced; (b) the install SILENTLY ACTIVATED a dormant code path — `oc-artifact-verify` gates its marker leg on `command -v strings`, so that branch had never executed on this box and now does. The general rule stands for every *other* system package: an owner order must NAME the package, and it authorizes only that package. The intent of this clause is unchanged and is the part that matters: **read in place via the URI; never copy the DB.** Copying the file to `/tmp` to query it is BOTH stale (paragraph above) and a disk leak — on 2026-09-18 one cron lane minted five 1.1 GB copies of `profiles/ops/opencrabs.db` in 75 minutes (5.2 GB into a 58 G disk) because it re-derived the read path after a compaction instead of finding it written down. If you are about to `cp` a `.db` file, stop and use the URI form. **A 0-byte `*.db` stub is legacy residue, not an empty database — and a stub is identified by (PATH, SIZE), never by name alone** (correction 2026-09-18, Infra Factory HQ, verified across all five stub names). Nine such stubs sat across the profile homes (`cron.db`, `state.db`, `memory.db`, `hermes.db`, `feedback_ledger.db`); all nine were **deleted 2026-09-18 on owner order**, each verified 0 B with no fd holder and its live counterpart confirmed non-empty first. The name-only test is the trap: `grep -rn 'cron.db' src/` → 0 matches would have read as "unreferenced, safe to delete" — but the SAME test on `memory.db` returns **28 matches**, because `memory.db` is the LIVE store name (`memory_dir().join("memory.db")` = `<home>/memory/memory.db`, 395,833,344 B). Every one of those 28 hits is the real path or a test-local tempdir; **none** is the profile-root stub. So a stub shares a filename with a live DB and differs only in PATH — never infer "unreferenced" or "empty" from a name match, and never diagnose from a stub: opening one returns nothing, which is indistinguishable from "no state". (lines 45-45)
  WHY: This 5,000+ character single-line block caches package installation forensics, historical apt log analysis, and deleted stub files that are already settled in the OS environment.
  FIX: Trim the rule to the binding constraint: read daemon state in place via `sqlite3 "file:<home>/opencrabs.db?mode=ro"` or python3 `sqlite3`, never copy DB files, and treat container reads separately.
  LOC: 0

FINDING 2: Full Grafana verification toolsuite procedure inlined in core behaviors
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: - **Grafana panel self-check (owner order 2026-09-15):** Whenever modifying or deploying Grafana dashboards or panel queries, always self-check EVERY panel against live data queries and layout geometry (see `/grafana` skill tools `skills/grafana/tools/grafana-verify` and `grafana-test-panels`) before reporting completion. A dashboard change is never done on deploy alone — verify that all charts return non-empty series and render without overlaps. (lines 72-72)
  WHY: Grafana dashboard query verification is on-demand domain work belonging in the `/grafana` skill rather than always-loaded workspace governance.
  FIX: Move panel verification rules into `skills/grafana/SKILL.md` and remove the line from AGENTS.md.
  LOC: -1

FINDING 3: Stale Git branch uncommitted changes conflict resolution recipe
  CLASS: NO-OP
  QUOTE: **Git uncommitted changes blocking pull:** `git pull --ff-only` fails with "Your local changes would be overwritten by merge" when uncommitted local changes exist. Fix: `git stash`, then `git pull`, then `git stash pop`. Alternatively, commit or discard local changes before pulling. Never use `git pull --ff-only` in a repo with uncommitted changes. (lines 155-155)
  WHY: Standard git stash/pull error handling is textbook tool mechanics that every model obeys by default.
  FIX: Remove the paragraph completely.
  LOC: -2

FINDING 4: Repetitive separate Outreach storage rule section
  CLASS: SPRAWL
  QUOTE: # Outreach storage rule (2026-08-25)

Outreach campaign operational state lives in Postgres `ai_spam_bot` schema `outreach` on apps (targets/candidates/sends/replies/state). Single writer: `outreach/lib/db.py`. The ai-antispam-outreach repo stores code, plans, and nightly `export/*.jsonl` snapshots only — never edit repo JSON as if it were live state. Cron `ai-antispam-outreach-db-sync` runs `export_db.py` (DB→repo); the old repo→DB `etl_sends.py` direction is retired (caused double-writer duplication). (lines 240-244)
  WHY: This duplicates the `/outreach-reply-sweep` skill reference already stated in §Outreach campaign and defines single-factory database schemas in the global runbook.
  FIX: Delete lines 240-244 and keep the single pointer in `## Outreach campaign (ai-antispam)` pointing to `skills/outreach-reply-sweep/SKILL.md`.
  LOC: -5

FINDING 5: Upstream PR and harvest smoke rubric duplication
  CLASS: WRONG-SCOPE
  QUOTE: ## Smoke rubric — 4 legs required (v0.4.125)

**NEVER file unsmoked PRs (hard rule, owner order 2026-09-11):** A PR may NEVER be filed against upstream (or marked ready for shipping/harvest) without a verified 4-leg smoke pass (Lineage, Identity, CI Gate, Behavioral probe or structural N/A) recorded with live receipts in `smoke-verdicts.log`. Filing an unsmoked PR or claiming harvest readiness without a live behavioral proof on the running binary is a critical process breach.

**Live verification stamp required for live-testable UX features (hard rule, owner order 2026-09-16):** For any UX, UI, card rendering, interactive command, or user-facing feature that is live-testable on the running binary, static binary string probes or symbol searches alone are STRICTLY FORBIDDEN as proof of a smoke PASS. Binary strings prove only that code was compiled into the artifact; they do not prove runtime execution or UI correctness. A smoke PASS for live-testable UX features requires an explicit live behavioral execution receipt stamped into the stamp system (`smoke-verdicts.log` / `workers-ledger.json`). If the behavioral verification cannot be fully automated and requires the owner's visual inspection, the lane MUST record `PARKED-OWNER-EYE` naming the exact owner action and packaging sha — never substitute a binary string probe for a live UX verification.

Verification requires (1) lineage, (2) identity, (3) CI gate, (4) live behavioral probe or structural N/A. Canon: `skills/opencrabs-dev/upstream-merge-runbook.md §Upstream-merge cadence · HARVEST LAW · NO-HOLD`. (lines 288-296)
  WHY: Detailed 4-leg smoke criteria, PARKED-OWNER-EYE stamps, and harvest requirements belong strictly in `upstream-merge-runbook.md` as cited by the text itself.
  FIX: Remove the §Smoke rubric section and let the `/opencrabs-dev` skill carry the smoke rules.
  LOC: -9

FINDING 6: Inline Miidas Factory specific HQ session definition
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: ## Miidas factory — its HQ lane (owner order 2026-09-11 12:37Z)

The **Miidas Factory** group (`-1003996392908`) is a member factory's own surface, and this profile serves its **HQ lane**: the session bound to **topic 4** — `e4f96a33-45ac-412e-8788-1b678cf2addb`, owner-designated 2026-09-11 ("This is the HQ session"). Supervising that factory's process is that lane's job and is **not** a breach of the meta-factory boundary above — that boundary governs the **Factories** group (meta-factory HQ topic 21, Delegate topic 68), which analyses factories and talks to member HQs, never implementing for them. Canonical Miidas process law: `skills/miidas/SKILL.md` — load it before ANY miidas task. (lines 327-329)
  WHY: Directly violates the rule established in line 306 ("a factory's own rules go in a skill inside its own repo, never here") by embedding Miidas factory topic/UUID details in the global file.
  FIX: Move the Miidas topic binding and role text to `skills/miidas/SKILL.md` and delete lines 327-329.
  LOC: -3

FINDING 7: Inline avito-realty-bot runbook pointer block
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: ## avito-realty-bot — its law lives in its own skill (owner order 2026-09-12)

The Avito realty bot (AI agent running Vadim's Avito dialogues) has its own skill:
**`skills/avito-realty-bot/SKILL.md`** — sourced from the project repo
`/root/avito-realty-bot/skills/avito-realty-bot/` via symlink, so it is versioned with the code.
Load it before ANY avito task: a code change, a deploy, a dialogue diagnosis, or a Vadim/Alexey question.
It carries the engage gate, the deploy path, the live Avito API paths, and the known-traps playbook.
New avito rules go THERE, not here. (lines 342-349)
  WHY: Another factory-specific section in the global AGENTS.md; factory skills are discovered dynamically through `skills/` and should not consume always-loaded tokens.
  FIX: Remove lines 342-349 completely.
  LOC: -8

TOTAL FINDINGS: 7 | NET LOC: -28


FINDING 1: Non-actionable platitudes in Core Behaviors
  CLASS: NO-OP
  QUOTE: - **Your human knows their infra better than you.** Ask, don't assume.
- **Loyalty is non-negotiable.** Finish what you start.
  WHY: Anthropomorphic slogans convey no checkable execution constraints and waste token budget on every session.
  FIX: Delete the two bullet lines from Core Behaviors.
  LOC: -2

FINDING 2: Historical package logs and dead stub forensics cached in SQLite discipline
  CLASS: CACHE
  QUOTE: **Reading daemon state: the `mode=ro` URI IS the read path — never copy the DB in order to read it.** The URI opens the live DB read-only, in place: no bytes copied, no writer blocked, and the answer is current. **The `sqlite3` CLI IS installed on this box as of 2026-09-19 10:52Z** — owner order ("You may install sqlite on this machine"); `apt-get install -y sqlite3` landed **3.45.1 at `/usr/bin/sqlite3`** (`sqlite3 --version` → `3.45.1 2024-01-30`, rc=0), so the simplest reader is now `sqlite3 "file:<home>/opencrabs.db?mode=ro" "<sql>"`. **The CLI's presence changes the READER, never the DISCIPLINE** — still read in place via a `mode=ro` URI and never copy a DB. **And it is the HOST read path ONLY (scope drawn 2026-09-19 on Miidas HQ's finding):** a container read path is a DIFFERENT FILESYSTEM and stays on the python module — Alpine-based images ship no `sqlite3` CLI (BASH.md §Alpine-based containers), and `docker` is not even on `PATH` on this box, so a host install here says nothing about a container a factory execs into on `apps`. Never convert an exec'd-into-a-container read to the CLI: doing so breaks a working production query. The pre-order history is kept because it explains why the URI form is the read path at all: (before that order, verified 2026-09-19: not on `PATH`, not on disk, and **never a package on this host** — `dpkg-query -W sqlite3` → `unknown ok not-installed`; `/var/log/dpkg.log` and `/var/log/apt/history.log`, both covering 2026-02-17 → 09-19, carry 0 sqlite3 lines and 0 `remove`/`purge` lines; `/var/backups/dpkg.status.0` has no `Package: sqlite3` entry and the only sqlite3 hit in `apt.extended_states` is `libsqlite3-0`. So there was **no removal to attribute** — the CLI was never part of this host's declared spec. `sh: 1: sqlite3: not found` (code 127) hit five sessions on 09-19 (`6ca0d547` ×3, `2646d31a` ×2, `23549292` ×2, `1122b15e` ×1, `63d775f9` ×1), and AGENTS.md itself prescribed the missing command. **Never infer that it once worked from a clean grep:** a caller that appends `2>/dev/null` hides this error, so a count of log lines is not a count of executions). Working readers: `python3 -c "import sqlite3; c=sqlite3.connect('file:<home>/opencrabs.db?mode=ro',uri=True); c.execute(...)"` (module present, SQLite 3.45.1 — note `python3 - <<EOF` heredocs are refused by the bash tool, so pass `-c` or write a script file), or the hand-built `/root/sqlite-recover-build/sqlite3-recover "file:<home>/opencrabs.db?mode=ro" "<sql>"` (3.45.1, verified reading the live DB). **`apt-get install sqlite3` was forbidden and is now ALLOWED** — the owner order above (2026-09-19 10:52Z) supersedes that clause. **`binutils` (the `strings(1)` provider) was likewise ABSENT from this host and is now ALLOWED — owner order "Install strings", 2026-09-19: `apt-get install -y binutils` rc=0 → `/usr/bin/strings`, GNU Binutils 2.42, `dpkg -l binutils` = `ii`.** Two consequences worth knowing: (a) `strings` and a raw-byte scan AGREE on the live binary (markers `incremental_vacuum`=4, `attempting bounded reclaim`=1 by both methods), so the pre-order hand-rolled byte-scan workaround is now cross-validated, not replaced; (b) the install SILENTLY ACTIVATED a dormant code path — `oc-artifact-verify` gates its marker leg on `command -v strings`, so that branch had never executed on this box and now does. The general rule stands for every *other* system package: an owner order must NAME the package, and it authorizes only that package. The intent of this clause is unchanged and is the part that matters: **read in place via the URI; never copy the DB.** Copying the file to `/tmp` to query it is BOTH stale (paragraph above) and a disk leak — on 2026-09-18 one cron lane minted five 1.1 GB copies of `profiles/ops/opencrabs.db` in 75 minutes (5.2 GB into a 58 G disk) because it re-derived the read path after a compaction instead of finding it written down. If you are about to `cp` a `.db` file, stop and use the URI form. **A 0-byte `*.db` stub is legacy residue, not an empty database — and a stub is identified by (PATH, SIZE), never by name alone** (correction 2026-09-18, Infra Factory HQ, verified across all five stub names). Nine such stubs sat across the profile homes (`cron.db`, `state.db`, `memory.db`, `hermes.db`, `feedback_ledger.db`); all nine were **deleted 2026-09-18 on owner order**, each verified 0 B with no fd holder and its live counterpart confirmed non-empty first. The name-only test is the trap: `grep -rn 'cron.db' src/` → 0 matches would have read as "unreferenced, safe to delete" — but the SAME test on `memory.db` returns **28 matches**, because `memory.db` is the LIVE store name (`memory_dir().join("memory.db")` = `<home>/memory/memory.db`, 395,833,344 B). Every one of those 28 hits is the real path or a test-local tempdir; **none** is the profile-root stub. So a stub shares a filename with a live DB and differs only in PATH — never infer "unreferenced" or "empty" from a name match, and never diagnose from a stub: opening one returns nothing, which is indistinguishable from "no state".
  WHY: 5 KB of dpkg log excerpts, package installation history, and already-deleted stub forensics turn a simple rule into a bloated historical cache.
  FIX: Condense into a concise 1-line rule stating `mode=ro` URI read discipline and host vs container tool selection, removing the post-mortem narrative.
  LOC: 0

FINDING 3: Campaign database schemas and ETL scripts in global runbook
  CLASS: WRONG-SCOPE
  QUOTE: # Outreach storage rule (2026-08-25)

Outreach campaign operational state lives in Postgres `ai_spam_bot` schema `outreach` on apps (targets/candidates/sends/replies/state). Single writer: `outreach/lib/db.py`. The ai-antispam-outreach repo stores code, plans, and nightly `export/*.jsonl` snapshots only — never edit repo JSON as if it were live state. Cron `ai-antispam-outreach-db-sync` runs `export_db.py` (DB→repo); the old repo→DB `etl_sends.py` direction is retired (caused double-writer duplication).
  WHY: Specific database schema names and ETL scripts for the ai-antispam outreach campaign belong in `skills/outreach-reply-sweep/SKILL.md` or `skills/ai-antispam/`.
  FIX: Move Postgres storage details to `skills/outreach-reply-sweep/SKILL.md` and delete this section.
  LOC: -5

FINDING 4: Factory-specific skill pointer in always-loaded brain
  CLASS: RESPONSIBILITY-CREEP
  QUOTE: ## avito-realty-bot — its law lives in its own skill (owner order 2026-09-12)

The Avito realty bot (AI agent running Vadim's Avito dialogues) has its own skill:
**`skills/avito-realty-bot/SKILL.md`** — sourced from the project repo
`/root/avito-realty-bot/skills/avito-realty-bot/` via symlink, so it is versioned with the code.
Load it before ANY avito task: a code change, a deploy, a dialogue diagnosis, or a Vadim/Alexey question.
It carries the engage gate, the deploy path, the live Avito API paths, and the known-traps playbook.
New avito rules go THERE, not here.
  WHY: Explaining that Avito rules belong in its own skill violates the principle that factory rules belong exclusively in on-demand skills.
  FIX: Delete the avito-realty-bot section.
  LOC: -9

FINDING 5: Member factory HQ topic and UUID bindings in ops runbook
  CLASS: WRONG-SCOPE
  QUOTE: ## Miidas factory — its HQ lane (owner order 2026-09-11 12:37Z)

The **Miidas Factory** group (`-1003996392908`) is a member factory's own surface, and this profile serves its **HQ lane**: the session bound to **topic 4** — `e4f96a33-45ac-412e-8788-1b678cf2addb`, owner-designated 2026-09-11 ("This is the HQ session"). Supervising that factory's process is that lane's job and is **not** a breach of the meta-factory boundary above — that boundary governs the **Factories** group (meta-factory HQ topic 21, Delegate topic 68), which analyses factories and talks to member HQs, never implementing for them. Canonical Miidas process law: `skills/miidas/SKILL.md` — load it before ANY miidas task.
  WHY: Factory-specific group IDs, session UUIDs, and topic bindings belong in `skills/miidas/SKILL.md` rather than global AGENTS.md.
  FIX: Move Miidas HQ routing details to `skills/miidas/SKILL.md` and delete this section.
  LOC: -5

FINDING 6: Opencrabs-dev process laws, upstream etiquette, and smoke rubric restated inline
  CLASS: WRONG-SCOPE
  QUOTE: ## Upstream repo etiquette

Never ping upstream maintainers on Telegram; keep all PR feedback on GitHub PR comments; never run uninvited CI polls on upstream repo. Canon: `skills/opencrabs-dev/SKILL.md §Upstream relations`.

**No fork PRs:** Never open PRs against `leshchenko1979/opencrabs` (fork changes land via ff-merge on fork main via `oc-deploy`/`oc-ship-chain`); GitHub PRs are upstream-harvest only (`adolfousier/opencrabs`). Canon: `skills/opencrabs-dev/SKILL.md §ISSUE ROUTING`.

## Smoke rubric — 4 legs required (v0.4.125)

**NEVER file unsmoked PRs (hard rule, owner order 2026-09-11):** A PR may NEVER be filed against upstream (or marked ready for shipping/harvest) without a verified 4-leg smoke pass (Lineage, Identity, CI Gate, Behavioral probe or structural N/A) recorded with live receipts in `smoke-verdicts.log`. Filing an unsmoked PR or claiming harvest readiness without a live behavioral proof on the running binary is a critical process breach.

**Live verification stamp required for live-testable UX features (hard rule, owner order 2026-09-16):** For any UX, UI, card rendering, interactive command, or user-facing feature that is live-testable on the running binary, static binary string probes or symbol searches alone are STRICTLY FORBIDDEN as proof of a smoke PASS. Binary strings prove only that code was compiled into the artifact; they do not prove runtime execution or UI correctness. A smoke PASS for live-testable UX features requires an explicit live behavioral execution receipt stamped into the stamp system (`smoke-verdicts.log` / `workers-ledger.json`). If the behavioral verification cannot be fully automated and requires the owner's visual inspection, the lane MUST record `PARKED-OWNER-EYE` naming the exact owner action and packaging sha — never substitute a binary string probe for a live UX verification.

Verification requires (1) lineage, (2) identity, (3) CI gate, (4) live behavioral probe or structural N/A. Canon: `skills/opencrabs-dev/upstream-merge-runbook.md §Upstream-merge cadence · HARVEST LAW · NO-HOLD`.

- **HQ delegation law (owner order 2026-09-09 ~13:35Z; term folded into HQ 2026-09-11):** HQ must use EVERY opportunity to delegate work to other lanes — sub-agent work, HQ-executed chains, and HQ-side tasks are handed to lanes the moment ownership is clear, not accumulated at HQ. Sub-agents for multi-step work are the last resort: such work runs in a monitorable forum topic instead (owner order same day: no subagents for merge work).
  WHY: Dev-process rules (PR etiquette, fork bans, 4-leg smoke rubrics, HQ delegation) are specific to opencrabs-dev and already codified in `fleet-directives.md` and `upstream-merge-runbook.md`.
  FIX: Remove these dev-process sections from AGENTS.md, relying on the mandatory post-compaction reload of `/opencrabs-dev`.
  LOC: -20

FINDING 7: tg-scanner-hub routing procedures in global workspace rules
  CLASS: WRONG-SCOPE
  QUOTE: ## Telegram Scanner Misrouted Messages Law (tg-scanner-hub)

When processing messages ingested via `tg-scanner-hub`:
- **Ops profile receives non-ops message:** If a message belongs to RedeVest business/real-estate (`default`) or household/private logistics (`family`), immediately reassign it:
  `tg-inbox reassign --id <ID> --to-profile default` (or `family`) with a short reason.
- **Family profile receives non-family message:** If a message is about infrastructure/servers/GitHub (`ops`) or RedeVest business/real-estate (`default`), immediately reassign it:
  `tg-inbox reassign --id <ID> --to-profile ops` (or `default`) with a short reason.
- **Multi-intent messages:** Use `tg-inbox clone --id <ID> --to-profile <target>` so both profiles receive the message in their respective queues.
- **Never drop or silently ignore misrouted messages:** Always reassign them so they reach the intended profile queue.
  WHY: Command-line procedures for `tg-inbox` belong in the tg-scanner-hub skill documentation rather than loaded unconditionally into every session.
  FIX: Move message routing command rules into the tg-scanner-hub skill and remove this section.
  LOC: -10

FINDING 8: Explicit Mermaid styling and shape tutoring
  CLASS: NO-OP
  QUOTE: - **Visual structure, numbering & styling law (owner order 2026-09-16):**
  - **Numbered references:** Nodes and steps MUST include explicit numbers (e.g. `1.`, `2.`, `[Step 1]`, `[N1]`) for ease of reference during review and discussion.
  - **Colors & styling:** Use distinct fill/stroke styles (`style`, `classDef`, `:::class`) to visually separate functional layers, subgraphs, status states, and ownership boundaries.
  - **Shapes:** Use distinct node shapes intentionally for instant structural recognition — e.g. `[rectangles]` for processes/actions, `[(cylinders)]` for storage/databases/queues, `{"{diamonds}"}` for decisions/gates, `([stadiums])` for terminals/endpoints, `[/parallelograms/]` for I/O/events.
  - **Icons & emoji:** Use relevant emoji/icons in labels (e.g. 💾, 🔒, ⚡, 📡, 🚨, ⚙️) for high visibility and quick scanning.
  WHY: Describing standard Mermaid diagram syntax (rectangles for actions, cylinders for DBs, diamonds for gates) restates model defaults and expands token overhead.
  FIX: Remove the shape and emoji sub-bullets, keeping only the numbered reference requirement.
  LOC: -4

TOTAL FINDINGS: 8 | NET LOC: -55
