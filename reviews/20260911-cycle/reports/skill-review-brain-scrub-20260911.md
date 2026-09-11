# DUTY 6 · BRAIN-SCRUB REVIEW — OpenCrabs Dev Cycle 5

**Lens:** `brain-scrub` (canonical brief: `skills/opencrabs-dev/fleet-directives.md:308` §Review lens `brain-scrub`)
**Scope (5 targets):** `~/.opencrabs/profiles/ops/{AGENTS.md, TOOLS.md, SECURITY.md, BOOT.md, MEMORY.md}`
**Canonical home checked against:** `~/.opencrabs/profiles/ops/skills/opencrabs-dev/`
**Mode:** read-only. **No files created, edited, or written** — per `fleet-directives.md:314` brain files are append-only; shrinks require explicit owner approval + `dedup_intent`/`cleanup_intent`. This report is findings only.

---

## Method note

- **Files read in full:** the five targets; plus `SKILL.md` (v0.4.143), `fleet-directives.md` (read in two passes — it truncates at 50 kB in a single read), `editor.md`, `CHANGELOG.md`, `review-lenses.md`, and the prior brain-scrub precedents (`reviews/skill-review-brain-scrub-20260906.md`; the 2026-09-10 report file returns `tools-v2` serialization noise, so the 2026-09-06 run is the readable precedent).
- **Every canonical home below was verified present on disk this session** (grep/read receipt in-context) before a duplication finding was written — per lens rule 3, move-with-verification.
- **Built-in `grep` matches LITERALLY unless `regex=true`.** All section-header and pattern scans were re-run with `regex=true`; a literal run returns "no matches" on text that is present (documented at `AGENTS.md:31` and `TOOLS.md:446`). This is itself a trap this lens re-encountered.
- **Secret scan pattern set:** `ghp_…|gho_…|ghs_…|github_pat_…|glsa_…|sk-[A-Za-z0-9]{20,}|xoxb-…|AAAA…|[0-9]{8,10}:AA[A-Za-z0-9_-]{30,}` — run narrow, per-file, against the five targets only. The wide variant across `ops/*.md` returns hundreds of out-of-scope matches in `memory/` and `rsi/` and was **not** re-run.
- **No numeric tallies are stated** in this report: this session runs under a read-restricted registry (no shell), so no `python3` pass was available to verify arithmetic. All line numbers and quotes below are copied from live tool output.

---

## Verdict

The five brain files carry **no live secrets**. The dominant defect class is exactly what the lens exists to catch: **full dev-process law restated in `AGENTS.md` instead of a pointer**, plus **discipline laws living in passive `MEMORY.md`**, plus a **live stale-tool cluster** — four brain-file statements still tell lanes "worktrees need `oc-index-worktree`" while the skill retires per-worktree indexing as of v0.4.143, and `TOOLS.md` still prescribes the RETIRED `modum check`.

---

## HIGH FINDINGS

### H-1 · Stale tool reference, four sites — `oc-index-worktree` contradicted by live law (v0.4.143)
**Where:** `AGENTS.md:176`; `TOOLS.md:158`, `TOOLS.md:162`, `TOOLS.md:166`

`AGENTS.md:176` verbatim:
> Reach for `grep_code` only for deep impact chains or when the repo/worktree isn't in `external_paths` (its `.codegraph` index is per-tree; worktrees need `oc-index-worktree`).

`TOOLS.md:162` verbatim:
> **Worktrees:** a worktree inherits NO index (`.codegraph` is per-tree; its `.git` is only a `gitdir:` pointer). Index it with the canonical tool — `oc-index-worktree <wt-path>` (init if absent, sync if present; built 2026-08-26 after live probing).

(`TOOLS.md:158` and `TOOLS.md:166` carry the same "worktrees need `oc-index-worktree`" clause.)

**Canonical, opposite:** `fleet-directives.md:458` `## Code-Structure Exploration & Scoutgraph Indexing Law (v0.4.143)`, whose `:460` reads verbatim:
> - **Per-worktree `.codegraph` indexing is RETIRED**: Worktrees do NOT run `oc-index-worktree` or maintain separate `.codegraph.db` SQLite instances.

Corroborated: `SKILL.md:60` — *"`./tools/oc-index-worktree <path>` | LEGACY STANDALONE (per-worktree indexing retired in v0.4.143; code queries use memory_search scope=\"external\")"*; `editor.md:231` — *"legacy standalone codegraph index (per-worktree indexing retired in v0.4.143…)"*.

**Assessment:** HIGH. This is task-rule-2 (stale tool reference) **and** rule-1 (duplication) in one: four always-loaded statements actively instruct lanes to run a tool the current law forbids, and one of them (`TOOLS.md:162`) calls it "the canonical tool". A lane following `AGENTS.md:176` will do work the skill says is retired.
**Recommendation (owner-gated):** replace all four with *"code queries → `memory_search scope="external"`; per-worktree `.codegraph` indexing RETIRED v0.4.143"* and delete the `oc-index-worktree` worktree advice. Leave the `AGENTS.md:176` routing pointer intact (that part is correct).

### H-2 · Stale tool reference — `modum check` prescribed after retirement
**Where:** `TOOLS.md:477`

Verbatim (excerpt):
> … Lint with `modum check` (naming-policy linter, `/usr/local/bin/modum`); fmt via the `/usr/local/bin/rustfmt` wrapper only (owner-approved 2026-08-27 — `--edition 2024` + entrypoint files for exact CI parity). …

**Canonical:** `SKILL.md:371` — *"modum RETIRED 2026-08-28; lint evidence = GREEN pr-checks.yml run"*; `CHANGELOG.md:143` records the retirement; `war-stories.md:53`/`:67` carry *"(NOTE v0.4.96: `modum` is a RETIRED tool…)"*.

**Assessment:** HIGH. This is the exact defect class the 2026-09-06 brain-scrub **F3** scrubbed out of `MEMORY.md` — it survives in `TOOLS.md`. Note `MEMORY.md:40-42` already carries the corrected form (*"`modum` RETIRED (brain-scrub 2026-09-06; lint = CI dispatch)"*), so `TOOLS.md:477` is now the **last** stale `modum` prescription in the brain files.
**Recommendation (owner-gated):** delete the `modum check` clause; keep *"lint evidence = GREEN `pr-checks.yml` run"*.

### H-3 · `AGENTS.md:21` — Direct dispatch law duplicated in full
**Canonical home:** `fleet-directives.md:246` §Direct dispatch — no relay hops [LANE]

Verbatim (`AGENTS.md:21`):
> **Direct dispatch — no relay hops (owner order 2026-09-10 ~02:4xZ).** Work notifications go sender → resource-owner directly; no lane re-sends or forwards work to a third lane. Canon: fleet-directives §Direct dispatch (v0.4.131) — 5 rules: direct dispatch · full-uuid from same-turn receipt · ledger stamps every send · Triage re-roles to auditor (verify-unclaimed + orphan sweeps stay, relaying goes) · escalation direct to HQ. Fanout waves and HQ rulings are not relays.

The canonical section enumerates the same five rules in full plus an Exceptions paragraph. The `AGENTS.md` copy is a **5-rule restatement**, not a one-line pointer.
**Assessment:** HIGH — rule 1. **Recommendation:** shrink to the anchor sentence + pointer; the "5 rules" enumeration belongs only at `fd:246`.

### H-4 · `AGENTS.md:225` — Skill-change lane notify law duplicated in full
**Canonical home:** `fleet-directives.md:243` (bullet *"Skill-change notifies MUST carry the reload instruction (owner order 2026-09-09)"*), inside §Cross-lane message delivery discipline (`fd:233`)

Verbatim (`AGENTS.md:225`):
> **Skill-change lane notify (owner order 2026-09-09 09:06Z; reload clause 09:3xZ):** every skill version bump / law change in the opencrabs-dev skill → **quiet-notify all active lanes** (`session_notify` delivery.mode="quiet") with a one-line summary of what changed … **AND an explicit reload instruction** — the brief MUST tell the lane to re-read the skill per the RELOAD law (editor.md §Mid-cycle skill drift: `oc-drift-check <uuid> <new-ver> --ack`, then re-read changed role files + fleet-directives.md and stamp `oc-ledger ack`). … Lanes must not learn about law changes late — e.g. TOOLSMITH's `--wait` double-duty and the 48 handrolled watchers persisted partly because lanes ran under old law.

`fd:243` carries the identical mode, reload verb, the `oc-drift-check … --ack` incantation, the `ACK after drift-check` contract, and the same v0.4.120 lesson.
**Assessment:** HIGH — rule 1 (full law: mode, verb, procedure, rationale, incident). **Recommendation:** one-line pointer + anchor.

### H-5 · `AGENTS.md:227` — "Dispatch = verify-unclaimed first" restated
**Canonical homes:** `fleet-directives.md:253` (Rule 4 — Triage re-roles to auditor: *"Verify-unclaimed (grep open claim-refs before dispatch) STAYS with Triage — it is an audit, not a relay."*) and `fleet-directives.md:405` (*"Lane-side verify-unclaimed on owner Go … Extends Dispatch=verify-unclaimed-first to the RECEIVING lane."*)

Verbatim (`AGENTS.md:227`):
> **Dispatch = verify-unclaimed first (Violations: 2).** Before routing any issue/assignment to a lane, grep the opencrabs-dev workers-ledger for open claim-refs on that issue number — owner words and prior claims pre-assign issues outside Triage's view (#106 and #107 were both already held when the n=1815 fan-out routed them; lesson noted after the first and still missed on the second). No dispatch to a lane without either a clean claim-ref grep or a lane-side confirmation.

**Assessment:** HIGH — the rule has two canonical homes and the brain copy restates the imperative in full. **Recommendation:** pointer to `fd:253`/`fd:405`.

### H-6 · `AGENTS.md:241–247` — Agent briefing law duplicated in full
**Canonical homes:** `fleet-directives.md:244` (bullet *"Forum-scope & Process-Owner Delivery guard"*), `fd:112` (Telegram surface law pointer), `fd:173` §Creating new editors item 3

Verbatim (`AGENTS.md:241` heading + bullets):
> ## Agent briefing law (hard, owner order 2026-09-10 13:11Z, reinforced 14:35Z, 15:33Z)
>
> **NEVER brief or instruct agents via `telegram_send` or Telegram topics.** Agents do NOT read or observe what is posted to Telegram chat or forum topics. When dispatching, briefing, or passing task/alert data to an agent session (including topic workers, cron alerts, or watchdog reports):
> - **Only `session_notify`** carries instructions or findings into an agent session. Use `session_notify` targeting the process owner session UUID directly.
> - Telegram forum topics exist exclusively for the human operator (Alexey) to observe, supervise, and archive discussions.
> - Automated dev tooling, watchers, and crons (e.g. `oc-waiter-sweep`) must deliver directly to the process owner's session via `session_notify`, NOT to a Telegram topic or DM.
> - Posting a briefing to Telegram via `telegram_send` does zero work for the worker agent; dispatching without `session_notify` leaves the worker idling blind.

`fd:244` verbatim (excerpt): *"Automated dev cron alerts and watchdogs MUST deliver directly to the process owner's session via `session_notify` (mode: turn-end), NEVER to a Telegram topic or the owner's private DM."*
**Assessment:** HIGH — a 4-bullet restatement of a law with three canonical homes. **Recommendation:** keep the hard anchor sentence (*"NEVER brief or instruct agents via `telegram_send` or Telegram topics"* — legitimately always-loaded) + pointer; drop the four bullets.

### H-7 · `MEMORY.md:393–395` — discipline law living in passive memory (detached poller)
**Canonical home:** `editor.md` §CI-wait / §Detached waiters (v0.4.83), plus the one-watcher law (`CHANGELOG.md:638`)

Verbatim (`MEMORY.md:393` heading + body):
> ## Hand-rolled detached poller = skill violation (owner correction 2026-09-09, "See the skill")
>
> When a gate watcher expires in-flight (oc-prchecks rc 5), the ONLY legal replacement is the standard tool: `oc-waiter arm --run <id> --ref <full-40-sha> --notify <session-uuid>` with OC_ACTOR set — NEVER a nohup bash poller to /tmp (no attribution, no terminal-state gate, no wake routing; editor.md §Detached waiters, v0.4.83). … Corollary: read back the journal start line before ending the turn (launch-death lesson, in the arm receipt).

**Assessment:** HIGH — lens rule 2 (*"MEMORY.md carries no discipline laws — passive memory never binds on a cold session; directives found there are findings"*). The text is imperative (*"the ONLY legal replacement is…"*, *"NEVER a nohup bash poller"*). It is the **post-F4 rewrite** of a section the 2026-09-06 lens already scrubbed once — it now points correctly but still states the law imperatively in passive memory.
**Recommendation (owner-gated):** reduce to dated history — *"2026-09-09 — armed a hand-rolled poller; owner corrected 'See the skill'; the standard is `oc-waiter arm` per editor.md §Detached waiters"* — and strip the imperative.

---

## MEDIUM FINDINGS

### M-1 · `AGENTS.md:145` — HQ board routing law has **no canonical skill home** (inverse defect)
Verbatim:
> - **HQ board routing (owner order 2026-09-07 ~08:11Z):** HQ replies on the board at decision-points ONLY. Pure loop-closes / ACKs / "lane idle" relays → Triage (verify + file) or nobody; no HQ reply. Rulings, gates, deviations, ship/swap chains, cross-lane conflicts → HQ. HQ's own re-verifications of already-verified facts stay silent (ledger stamp at most, no board post). Origin: HQ acknowledged an already-verified closure — redundant, the auditor's F9 hub-concentration pattern.

A `^## ` scan of `fleet-directives.md` shows **no section carrying this law**; the only skill-side trace is a provenance note, `CHANGELOG.md:415` — *"Routing-law mirror: AGENTS.md:128 (HQ board routing = decision-points only) …"*. This is dev-process law whose **only binding copy is the always-loaded brain file**.
**Assessment:** MED — the inverse of the lens's usual defect. **Recommendation:** land the canonical copy in `fleet-directives.md` (land-in-skill-first, per rule 3), then reduce `AGENTS.md` to a pointer. Owner-gated.

### M-2 · `AGENTS.md:210` — infra-quirk routing table duplicated
**Canonical:** `fleet-directives.md:189` §Tool-problem reports: direct to TOOLSMITH for tools, issues for core
Verbatim (`AGENTS.md:210`, excerpt):
> **ALL infra quirks get reported to their process owner — noting one in a lane report is NOT reporting it (owner order 2026-09-11 ~08:34Z).** … Routing: `tools/oc-*` defects → Toolsmith · skill law text (`SKILL.md`, `editor*.md`, `fleet-directives.md`) → HQ (HQ-only authorship — the former name *Supervisor* is RETIRED, owner order 2026-09-11) · core daemon faults → GitHub fork issues · VDS/host infrastructure → Alexey. …
**Assessment:** MED — duplicate routing map. The "same turn it is found" imperative is a defensible anchor; the 4-way map is the canonical content.
**Recommendation:** compress to pointer + the one-line routing map.

### M-3 · `AGENTS.md:212` — Substrate routing: long incident narrative + two hardcoded session UUIDs
Verbatim (excerpt — the bullet is ~2 300 chars):
> **Substrate routing — ask the substrate's owner for the change (owner order 2026-09-11 11:42Z).** … (session `d72bd52d-42aa-4dbd-ac99-5b5300770019`, Crabs Kanban Board topic `OC DEV HQ`) … the **fast-mcp-telegram** session (session `ef699b07-cd5a-477f-957e-7825213126d0`). … **Before declaring a capability missing: (1) find the substrate's own repo, (2) read its tool list, (3) probe the tool.**

**Assessment:** MED — two problems. (a) The 3-step procedure + the settled `#160`/`#161` routing belong in the skill, not an always-loaded file. (b) **It stores two literal session UUIDs in `AGENTS.md`**, against the naming law (*"uuids are for ROUTING fields only"*, `SKILL.md` §Hard rules; and lanes are told to *"never uuid-from-memory"* — `SKILL.md` §Glossary). Stale-UUID risk on a cold session.
**Recommendation:** pointer + dynamic resolution (`session_search` / `oc-roster live`); move the incident narrative to the skill.

### M-4 · `MEMORY.md:185–187` — daemon no-reap law still imperative after landing
**Canonical:** `fleet-directives.md:349` §Daemon no-reap — ruling 1273 *(landed in skill 2026-09-06, brain-scrub F5; law previously only in MEMORY.md)*
Verbatim (`MEMORY.md:185`, excerpt):
> … Ruling is canonical: no reap mechanism in the bounce chain, not deferred, never. Any future process-cleanup proposal: identify profile/unit membership via cmdline + cgroup FIRST; exe-sha alone is never evidence; default is no-touch.
**Assessment:** MED — the 2026-09-06 **F5** landed this law into the skill; the passive copy retains imperative force + a directive for future proposals.
**Recommendation (owner-gated):** dated history + pointer.

### M-5 · `MEMORY.md:188–190` — inherited-claim three-pillar law still imperative after landing
**Canonical:** `fleet-directives.md:355` §Inherited-claim three-pillar verification *(landed in skill 2026-09-06, brain-scrub F6; previously only in MEMORY.md)*
Verbatim (`MEMORY.md:188`, excerpt):
> **Rule:** before filing any issue from an INHERITED claim (forward, compaction, another lane), re-verify the three pillars — (1) the run's own log via `gh run view --log` …, (2) the named test/symbol exists via git grep at the exact sha, (3) the cited code site actually holds the claimed logic. …
**Assessment:** MED — same pattern as M-4: a labelled *"Rule:"* with a 3-step procedure in passive memory, already canonical at `fd:355`.
**Recommendation (owner-gated):** dated history + pointer.

### M-6 · `MEMORY.md:40–42` — Rust ban list restated in passive memory
**Canonical:** `editor.md` §Box law; `SKILL.md` §Shared environment facts
Verbatim (`MEMORY.md:40`, excerpt):
> Agents box has NO SANCTIONED Rust toolchain (hardened 2026-08-28, owner GO '1+2+3'). … Invoking cargo/rustc/clippy in ANY form (PATH, login shell, PATH-prepend, explicit path) is a ruling violation even when it works … To reverse: `bash /root/toolchain-disabled-20260828/restore.sh`.
**Assessment:** MED — full ban list in passive memory. The `modum` half is already fixed (F3 scrub worked); the ban list itself duplicates `editor.md §Box law` (canonical) — which `SKILL.md:…` explicitly declares *"the canonical home … other files reference '(box law)'"*.
**Recommendation (owner-gated):** trim to pointer.

### M-7 · `MEMORY.md:460–466` — OC_ACTOR verification procedure (imperative in passive memory)
Verbatim (`MEMORY.md:460` heading + first bullets):
> ## 2026-09-11 — a compaction playbook can carry the WRONG OC_ACTOR (verify your own uuid)
>
> … Setting it would have stamped the ledger and the commit trailer with another lane's identity.
> - **Cheap authoritative check (same turn, no guessing):** grep the daemon log for the lines of the turn you just ran — `grep -n "session_id=" ~/.opencrabs/profiles/ops/logs/opencrabs.$(date -u +%F) | tail` — the `run_tool_loop{session_id=<uuid>}` wrapper on YOUR OWN tool calls is the live receipt. Cross-check with `oc-roster live --detail | grep topic:<n>` (uuid → topic name).
**Assessment:** MED — a checkable procedure + imperative in `MEMORY.md`. `AGENTS.md:13` (identifier law) already covers the general principle; the lane-identity check belongs in `editor.md` or the skill.
**Recommendation (owner-gated):** land-in-skill-first, then dated history here.

### M-8 · `MEMORY.md:468–474` — scope ruling: binding behaviour in passive memory
Verbatim (`MEMORY.md:468` heading + tail):
> ## Scope: this lane (ai-antispam) vs opencrabs-dev — HQ ruling 2026-09-11
> … Behaviour: on receiving a fork-rebase FREEZE (or other opencrabs-dev fork/ship directive) here, **check scope before stopping work** — if it targets ai-antispam, ignore it and do NOT send the worktree/dirty-count reply.
**Assessment:** MED — a binding behavioural rule governing a roster-scope defect, living in passive memory. Canonical home would be `fleet-directives.md` §Lanes / roster-scope.
**Recommendation:** land + pointer. Owner-gated.

### M-9 · `AGENTS.md:185–187` — Owner design gate inline restatement
**Canonical:** `fleet-directives.md:122` §Discussion links + fix-approval gate
Verbatim (`AGENTS.md:185`):
> ## Owner design gate (v0.4.128)
>
> All implementation designs require canonical terms, vertical Mermaid diagrams, and explicit owner approval before code. Canon: `skills/opencrabs-dev/fleet-directives.md §Discussion links + fix-approval gate`.
**Assessment:** MED (low end) — it *does* carry a pointer, but also restates the three requirements inline. Borderline: the 3-element summary is arguably a legitimate anchor.
**Recommendation:** keep the anchor, drop *"All implementation designs require…"* to a shorter form.

### M-10 · `TOOLS.md:475–479` — Rust ban restated outside its canonical home
Verbatim (`TOOLS.md:477`, excerpt):
> `cargo`/`rustc`/`clippy` are FORBIDDEN on this box in ANY form (ruling 2026-06-16, hardened 2026-08-28: compile binaries moved to `/root/toolchain-disabled-20260828/` …). … **Never claim local build evidence (learned 2026-09-05, theme-2 lane):** … Local Rust evidence is never valid regardless — CI carrier only.
**Assessment:** MED — the ban list + the `${PIPESTATUS[0]}` narrative restate `editor.md §Box law` and `fd:418` (shell-verdicts law) outside their canonical homes. (Contains the H-2 stale `modum` clause too.)
**Recommendation:** pointer to `editor.md §Box law` + `fd:418`; drop the duplicate narrative.

---

## LOW FINDINGS

### L-1 · `AGENTS.md:255` — duplicate POST-COMPACTION anchor (intentional)
Verbatim:
> **POST-COMPACTION:** the skill is gone from context after any compaction — reload it before any ruling, dispatch or status claim. This line is the recovery anchor.
`AGENTS.md:196` carries the primary POST-COMPACTION LAW block; `fd:151` §Post-compaction skill reload [LANE] is the skill-side copy. **Assessment:** LOW — deliberate redundancy so the anchor survives section-level reads; the 2026-09-06 lens left the analogous case as "extend-or-leave". **Note it; no action.**

### L-2 · `AGENTS.md:286–292` — "Lane Management & Reuse": no skill home
Verbatim (`AGENTS.md:286`):
> ## Lane Management & Reuse (owner order 2026-09-11: "You are still using spawn_agent instead of working with lanes. …")
> - **REUSE EXISTING LANES over spawning new ones.** …
A grep of the skill repo for `Lane Management` / `reuse existing lanes` / `spawn_agent` returns **no canonical section**. **Assessment:** LOW–MED — arguably a legitimate `AGENTS.md` anchor (it governs all lanes on the box, including non-dev factories), but it is dev-process law without a skill home. **Recommendation:** land in `fleet-directives.md` §Lanes, then pointer.

### L-3 · `AGENTS.md:23–31` — five verification-discipline bullets duplicated at `fd:413–419`
Verbatim headers: `AGENTS.md:23` *"Defect claims about file/ledger content need a read-back-immune proof"* · `:25` *"Shell verdicts are read first-hand, never through a pipe"* · `:27` *"A probe against a path that does not exist returns silence, not a verdict"* · `:29` *"Hash anchors come from a same-turn read of that exact region"* · `:31` *"Verification is scoped by load-bearing, and its value-add is the CONTRADICTION check"*.
**Duplication confirmed** — `fleet-directives.md:413` §Verification-discipline additions (Task-8 governance pass, 2026-09-11) carries near-verbatim copies at `fd:416` (literal COMMAND beside control hash), `fd:417` (probe-against-nonexistent-path), `fd:418` (shell verdicts first-hand), `fd:419` (verification scoped by load-bearing + the `grep` literal-match corollary).
**Assessment:** LOW (prior-lens precedent treats the Execution Discipline family as legitimately always-loaded) — but note these bullets are the heaviest single items in `AGENTS.md` and the identical law already sits in the skill. **Recommendation:** keep the law in `AGENTS.md`; trim the incident/rationale prose to the skill.

### L-4 · `TOOLS.md:142`, `TOOLS.md:221` — stale `execute_code` reference
Verbatim (`TOOLS.md:142`):
> **Do not do math in reasoning.** Use `execute_code` Python for calculations.
`execute_code` is **not** in the core tool list (`TOOLS.md:235` enumerates the core set and does not include it). The canonical math law (`AGENTS.md:9`) says use **`python3`** via bash. `TOOLS.md:221` repeats `execute_code` in the tg_send_message failure text.
**Assessment:** LOW — stale tool name (task rule 2). **Recommendation:** change to `python3` / `bash`.

### L-5 · `TOOLS.md:353` vs `BOOT.md:46` — `config_tool` / `config_manager` naming drift
`TOOLS.md:353` — *"(or `config_tool` `set_working_directory`)"*; `TOOLS.md:235` lists `config_tool` as core. `BOOT.md:46` — *"Offer to save it as a custom command** using `config_manager` with `add_command`"*. Two names for one tool surface.
**Assessment:** LOW — naming inconsistency across brain files. **Recommendation:** settle on one name.

### L-6 · `BOOT.md:51–56` — memory-routing bullet conflicts with the authoritative routing law; `COMMANDS.md` does not exist
Verbatim (`BOOT.md:52`):
> - **MEMORY.md** — Lessons learned, patterns discovered, infrastructure details, troubleshooting fixes
Verbatim (`BOOT.md:59`):
> - Use `write_opencrabs_file` to update `TOOLS.md` or `COMMANDS.md` with corrections
**Conflict:** `AGENTS.md:120–131` §Memory — new-rules routing law is authoritative: route to a **specialised skill file** if one applies, otherwise **`AGENTS.md`** — *"never MEMORY.md"*; *"Facts, context, dated history → MEMORY.md"*. The `BOOT.md` bullet sends "lessons learned, patterns discovered" to MEMORY.md without the passive/never-auto-loaded caveat and without the skill route.
**Stale file:** no `COMMANDS.md` exists in `~/.opencrabs/profiles/ops/`.
**Assessment:** LOW–MED — two defects (routing conflict + stale file reference). **Recommendation:** add the *"never for always-hold rules; dev process law → skill"* caveat; fix/remove the `COMMANDS.md` reference.

### L-7 · `BOOT.md:129`, `BOOT.md:138` — stale `/srv/rs/opencrabs` paths; `/rebuild` contradiction
Verbatim (`BOOT.md:129`): *"Read `~/srv/rs/opencrabs/README.md` for the full feature list and docs"* · (`BOOT.md:138`): *"cd /srv/rs/opencrabs    # or wherever your source lives"*.
The live checkout is **`/root/opencrabs`** (`SKILL.md` §Shared environment facts: *"Checkout `~/opencrabs`…"*; `TOOLS.md:534` *"…`cd /root/opencrabs`"*). Neither `/srv/rs/opencrabs` nor `~/srv/rs/opencrabs/` appears in the skill canon — shipped-template paths never localized.
**Contradiction:** `BOOT.md:21` *"You can rebuild yourself with `/rebuild` or `cargo build --release`"* (and `:81`, `:83`, `:94`) vs `TOOLS.md:355` *"`/rebuild` — RETIRED on ops profile (local `cargo` compile is forbidden; deployment is managed via `oc-ship-chain` and CI)"*.
**Assessment:** LOW–MED — stale paths (task rule 2) + a direct cross-file contradiction on `/rebuild`. **Recommendation:** fix paths to `/root/opencrabs`; reconcile the `/rebuild` statement.

### L-8 · `SECURITY.md:243` vs `SECURITY.md:277` — duplicate Grafana #3 entry + mixed numbering
Verbatim (`SECURITY.md:277`):
> - Grafana Service Account Token #3 (`<GRAFANA-TOKEN-REDACTED>`) appeared in bash output Cycle 194. NOT redacted. Distinct from entry #9 (`glsa_****...`) and entry #10 (`glsa_****...`) — different service account token. **This entry was added in Cycle 211, removed by another session by Cycle 215, and re-added here.**
The identical entry appears twice — once mid-file (`:243`, inside §Secret Handling in Bash Commands) and once appended at the tail (`:277`, after §Confidential File Protection), out of numerical order. Numbering switches between `-` bullets and explicit `19.`-style numbering; redaction placeholder formats vary.
**Assessment:** LOW — no secrets leaked, no dev-process law; structural hygiene only. **Recommendation:** dedupe the Grafana #3 entry; normalize numbering.

### L-9 · `AGENTS.md:13` — partial session UUIDs in prose
Verbatim (excerpt):
> … Incidents: 39-char hand-typed sha; merge trailer `462181e9-6798…` (ledger prefix + fabricated tail, blocked the ship gate); theme-1 ack sent to `aaa8d8ae-279b…` (theme-1 prefix on theme-4's tail, wrong session).
**Assessment:** LOW — the law is general (always-loaded) but the incident evidence is dev-specific; two partial UUIDs appear in prose against the "refer to workers by topic name" law (low severity — they are partial/illustrative). **Recommendation:** trim the dev incidents to the skill.

---

## Secret-scan verdict (task rule 2)

- **All five target files: CLEAN.** A narrow regex scan of each — `ghp_… | gho_… | github_pat_… | glsa_… | sk-[A-Za-z0-9]{20,} | xoxb-… | [0-9]{8,10}:AA[A-Za-z0-9_-]{30,}` — returned **"No matches found"** for `AGENTS.md`, `TOOLS.md`, `MEMORY.md`, `BOOT.md`, and `SECURITY.md`. No literal live secrets.
- `SECURITY.md`'s evidence entries are all in redaction placeholders (`<GH-PAT-REDACTED>`, `<GATUS-BEARER-REDACTED>`, `<BOT-TOKEN-REDACTED-2026-09-09-c4>`, `<MIXPANEL-SECRET-REDACTED>`, `<GRAFANA-PASS-REDACTED>`, `<GEMINI-KEY-REDACTED>`, `<API-HASH-REDACTED>`, `<N8N-JWT-REDACTED>`, `<GRAFANA-TOKEN-REDACTED>`, `<SSH-PASS-REDACTED>`, `[REDACTED-2026-09-08-1930Z]`). The only residue is unusable 10-char Grafana SA prefixes (`glsa_****...`), already flagged LOW by the 2026-09-08 c2 lens.
- **Boundary observation (out of this lens's scope, no action against the five files):** the wide scan (not re-run here) previously surfaced a live Grafana SA token #3 at `rsi/improvements.md:2728`, plus full tokens in `rsi/history/*.md` and dozens in `memory/*.md`. The 2026-09-08 c2 lens recommended the owner extend the redaction ruling to `rsi/` or explicitly scope it out. `rsi/` ≠ `memory/`, and neither is one of the five files under review — recorded as a boundary note only.

---

## Move-with-verification & owner-approval gate

- **Canonical copies verified present on disk this session** for: H-3 (`fd:246`), H-4 (`fd:243`), H-5 (`fd:253`+`fd:405`), H-6 (`fd:244`+`fd:112`+`fd:173`), H-1 (`fd:458–460`+`SKILL.md:60`+`editor.md:231`), H-2 (`SKILL.md:371`+`CHANGELOG.md:143`), M-4 (`fd:349`), M-5 (`fd:355`), M-9 (`fd:122`), L-3 (`fd:413–419`).
- **No canonical home found** for: M-1 (HQ board routing — only `CHANGELOG.md:415` provenance), L-2 (Lane Management & Reuse). These require **land-in-skill-first** before any shrink.
- **Gate:** brain files are **append-only**. Every recommendation above is a *proposal*; executing any shrink requires **explicit owner approval** plus `dedup_intent` / `cleanup_intent` (`fleet-directives.md:314`). This lens produces findings; it does not edit.
- **Persistence:** the report persists via `oc-review-persist brain-scrub <text|@file>` — the index line IS the "persisted" receipt (`fd:316`). **Not executed here:** this session runs under the read-restricted registry (no shell), so the persist call must be made by the cycle harness / HQ on this report's text.

---

## What now/next

- **In flight:** Cycle-5 brain-scrub report — complete, emitted above (read-only; no brain file touched).
- **Next step + owner:** persist this report (`oc-review-persist brain-scrub @file`) and feed it into the Duty-6 review-battery consolidation → **HQ** (skill-only authorship) and the **cycle harness**. The two `land-in-skill-first` items (M-1 HQ board routing, L-2 Lane Management & Reuse) are **HQ** work before any `AGENTS.md` shrink.
- **Blocked on Alexey:** every shrink recommendation (H-1…H-7, M-1…M-10, L-2, L-6, L-7) is owner-gated — brain files are append-only; nothing is removed without explicit owner approval + `dedup_intent`/`cleanup_intent`. **Highest-value single ask:** approve the H-1 stale-`oc-index-worktree` fix (four sites contradicting live v0.4.143 law) and the H-2 `modum` fix — these actively misdirect lanes today.

*Bwoo. Report filed — beep.*
