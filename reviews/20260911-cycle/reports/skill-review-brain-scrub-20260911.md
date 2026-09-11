[2026-09-11T22:49:11Z] NOTE: same-day overwrite of prior version
# Duty 6 Cycle 7 — Lens BS Review: Ops Brain (Containment & Process Leakage)

**Reviewer:** Lens BS (BRAIN — Ops Brain Containment & Process Leakage)
**Cycle:** 7
**Date:** 2026-09-11
**Scope:** `/root/.opencrabs/profiles/ops/AGENTS.md` (44,496 B / 294 lines) · `TOOLS.md` (58,698 B / 635 lines) · `MEMORY.md` (91,341 B / 528 lines)
**Charter:** (1) AGENTS.md token weight + opencrabs-dev process-law leakage (pointerization vs bloated inline law); (2) broken anchors from AGENTS.md into skill files; (3) MEMORY.md hygiene (stale incident logs → war-stories); (4) TOOLS.md duplication with core tool definitions.
**Lens canon:** fleet-directives.md §Review lens `brain-scrub` (rule 1: AGENTS.md carries only one-line pointers + always-loaded anchors for dev-process law — a full law text duplicated here is a finding; rule 2: MEMORY.md carries no discipline laws; rule 3: every finding lands as a move-with-verification — canonical copy verified present in the skill BEFORE removal).

---

## Executive Summary

The **anchor web from AGENTS.md into the skill is sound** — every cited skill file exists and every cited section header resolves (10/10 verified, incl. both sha anchors `3ab07c68` and `bb402cbf` in the skill's git history). Damage is not in broken pointers but in **law-text duplication, stale interface documentation, and a broken post-scrub digestion discipline**.

Three load-bearing defects drive the **HIGH** grade:

1. **AGENTS.md duplicates full law text whose canonical, condensed home already exists in the skill.** Four of the 2026-09-11 Execution Discipline entries (read-back/branix 2,758 chars, probe-silence 910, shell-verdicts 643, verification-scoped 824) are near-verbatim expansions of four one-liners landed the same day in `fleet-directives.md` §Verification-discipline additions (lines 444–452). The brain-scrub lens rule 1 is violated with the canonical copy already in place — a pure shrink job, no land-first needed.
2. **TOOLS.md §plan is a stale interface doc that teaches the WRONG plan tool.** It prescribes "Four operations" and `init` "auto-approves" — the live tool is two-track (design/checklist), user-approval-gated by default, with `add_tasks`/`add_task`/`approve`/`discard`/`grant_autonomy`/`revoke_autonomy`/`show_plan`. A lane following TOOLS.md would believe plans self-approve and would not learn the primary append op.
3. **MEMORY.md teaches a RETIRED standard.** The CI-watcher lesson (MEMORY.md:245) anchors "detached waiters are `oc-waiter` — THE standard (editor.md §CI-wait item 10, v0.4.83)": editor.md §CI-wait now numbers items 1–9 (no item 10), and the skill's git history shows `v0.4.135 — native detached bash standard & oc-waiter retirement`. The lesson's anchor is broken *and* its prescription is retired.

Secondary: AGENTS.md has grown **×2.17 in 14 days** (20,516 B Aug 28 → 44,496 B today) into an 11–13K-token always-loaded document; ~18 opencrabs-dev incident post-mortems have re-accumulated in MEMORY.md since the 2026-09-02 scrub while `war-stories.md` has not been updated since 2026-09-05; TOOLS.md duplicates its own content internally (write_opencrabs_file path rules ×2, cargo prohibition ×2, grep_code routing ×3) and carries stale tool names (`http_client`, `config_tool`, `follow_up_question`).

---

## Findings Matrix

| ID | Severity | Category | Target File | Summary |
|---|---|---|---|---|
| **BS-H1** | HIGH | Law leakage (duplicate, canonical present) | `AGENTS.md:23,29,27,33` ↔ `fleet-directives.md:447-450` | Four 09-11 Execution Discipline entries are expanded duplicates of one-liners already canonical in fleet-directives §Verification-discipline additions |
| **BS-H2** | HIGH | Stale interface doc | `TOOLS.md:323-338` | §plan teaches "Four operations" + `init auto-approves`; live tool is two-track, approval-gated, `add_tasks`-based |
| **BS-H3** | HIGH | Retired standard + broken anchor | `MEMORY.md:245` | CI-watcher lesson prescribes `oc-waiter` "THE standard (editor.md §CI-wait item 10, v0.4.83)" — no item 10 exists; oc-waiter retired at v0.4.135 |
| **BS-H4** | MEDIUM | Cross-file contradiction | `TOOLS.md:477` vs `MEMORY.md:42` | TOOLS.md teaches `modum check` as local lint; MEMORY.md records `modum` RETIRED (brain-scrub 2026-09-06) |
| **BS-M1** | MEDIUM | Token weight | `AGENTS.md` (whole) | 44.5 KB always-loaded (~11-13K tokens); ×2.17 in 14 days; Execution Discipline alone 27.5% (11.8 KB), 7 of 16 entries from one 09-11 lane |
| **BS-M2** | MEDIUM | Digestion discipline | `MEMORY.md` (many) | ≥18 opencrabs-dev incident post-mortems accumulated since 09-02 scrub; `war-stories.md` last entry 09-05 |
| **BS-M3** | MEDIUM | Stale pending-state | `MEMORY.md:151-160` | "Cron deliver_to outage" ends "awaiting Alexey's A or B" — resolved 09-05 (keys.toml `[channels.telegram]` token), no pointer to resolution |
| **BS-M4** | MEDIUM | Intra-file duplication | `TOOLS.md:52-73 / 475 / 152-166`, `539-556 / 590` | write_opencrabs_file path rules ×2, cargo prohibition ×2, grep_code routing ×3 |
| **BS-M5** | MEDIUM | Law leakage (canonical NOT yet present) | `AGENTS.md:17,31,35` | compaction-snapshot, hashline-anchors, history-rewrite laws — incident-shaped, no fleet/war-stories twin (verified absent); land-in-skill-first required |
| **BS-M6** | MEDIUM | Heading misorganization | `AGENTS.md §Telegram identity law` | Heading bundles 7 unrelated receipt/session laws; 3 are opencrabs-dev routing law with canonical homes (fleet-directives, triage.md) |
| **BS-L1** | LOW | Stale tool names | `TOOLS.md:235,353` | `http_client`/`config_tool`/`follow_up_question` vs live `http_request`/`config_manager`/`suggest_options` |
| **BS-L2** | LOW | Anchor impedance | `SKILL.md:464` | `§ISSUE ROUTING` cited as a section by AGENTS.md; it is a bullet inside §Hard rules, not a `##` header |
| **BS-L3** | LOW | Cosmetic structure | `MEMORY.md:1,3,325` | Two H1s at top (stock + scrub subtitle at H1 level) and a duplicate stock H1 mid-file at 325 |

---

## Detailed Findings

### BS-H1 — HIGH — AGENTS.md carries full law text whose canonical copy exists in the skill

The brain-scrub lens rule 1 says AGENTS.md carries "only one-line pointers + always-loaded anchors for dev-process law — a full law text duplicated here is a finding." Four Execution Discipline entries added 2026-09-11 are expanded narrative versions of four laws that were landed **the same day** in condensed canonical form in `fleet-directives.md` §Verification-discipline additions (Task-8 governance pass):

| AGENTS.md (full text) | Fleet-directives.md (canonical one-liner) |
|---|---|
| `AGENTS.md:23` — "Defect claims about file/ledger content need a read-back-immune proof" — **2,758 chars**, full 4-hit branix saga (n=2755/2762/2775, hex/len arithmetic, fork #163) | `fleet:447` — "Always record the literal COMMAND beside any control hash" (~600 chars, same origin cited) |
| `AGENTS.md:29` — "A probe against a path that does not exist returns silence" — **910 chars** | `fleet:448` — same law, condensed |
| `AGENTS.md:27` — "Shell verdicts are read first-hand, never through a pipe" — **643 chars** | `fleet:449` — same law, same dash/PIPESTATUS mechanics |
| `AGENTS.md:33` — "Verification is scoped by load-bearing…" — **824 chars** | `fleet:450` — same law incl. the grep-literal corollary |

The canonical copy is verified present in the skill, so this is a **shrink-only** finding per lens rule 3 (no land-first needed). The AGENTS.md entries should reduce to one line + pointer to `fleet-directives.md §Verification-discipline additions` — the pattern already modeled by the file's own "OpenCrabs dev — rules live in the skill" section.

### BS-H2 — HIGH — TOOLS.md §plan documents an obsolete plan-tool interface

`TOOLS.md:323-338` describes the plan tool as: *"The `plan` tool structures work into ordered steps. Four operations… `init` | Create/import a plan (**auto-approves**)"* — with `add_task`/`start`/`complete` and no mention of `add_tasks`, `approve`, `discard`, `grant_autonomy`/`revoke_autonomy`, `show_plan`, or the design/checklist two-track.

The live tool (v0.5.x, per this session's runtime schema): `init` is **design or checklist track, and by default the plan waits in Editing for the USER to Approve** before `start` works; `add_tasks` is the primary append operation; `approve` is refused unless the user granted autonomy. The TOOLS.md claim that `init` "auto-approves" is **factually false for the current tool** and is load-bearing in the wrong direction: a lane following it believes plans self-activate and never learns the approval gate or the `add_tasks` append path. This is the stale-interface-doc class — the tool schema is the single source of truth, TOOLS.md should carry quirks/lessons only (e.g., plan-as-durable-memory-across-compactions is worth keeping).

### BS-H3 — HIGH — MEMORY.md prescribes a retired standard and a broken anchor

`MEMORY.md:245-248` (CI-watcher lesson, owner correction 2026-09-03):
> "detached waiters are `oc-waiter` — THE standard (editor.md §CI-wait item 10, v0.4.83)… never hand-roll a poller."

Verified against the skill:
- **Anchor broken:** editor.md §CI-wait discipline & actor attribution (lines 79–146) now numbers items **1–9 only**; there is no item 10.
- **Standard retired:** `git log --all` on the skill repo shows `472fa65a "feat: release v0.4.135 — native detached bash standard & oc-waiter retirement"`. The native detached `background: true` / harness-wake mechanism (documented in TOOLS.md §bash and AGENTS.md) replaced oc-waiter.

A lesson that instructs a lane to use a retired tool is worse than a stale lesson — it re-imports the hand-rolled-poller failure mode the lesson was written to prevent. The MEMORY.md entry needs correcting to the native detached-bash standard (and the current oc-prchecks/gh-run-watch practice in editor.md §CI Watcher Discipline & Throttling, v0.4.143), with the anchor re-pointed or the entry digested into war-stories with the correction baked in.

### BS-H4 — MEDIUM — modum: direct contradiction between TOOLS.md and MEMORY.md

- `TOOLS.md:477` §Rust builds on this box: *"Lint with `modum check` (naming-policy linter, `/usr/local/bin/modum`)"*
- `MEMORY.md:42` §Rust toolchain removed: *"`modum` RETIRED (brain-scrub 2026-09-06; lint = CI dispatch)"*

Same box, same question (what local lint is sanctioned), two answers a session apart. One of the two was never updated after the 09-06 brain-scrub ruling. Bounded blast radius (local lint choice only) but a direct contradiction on a sanctioned-tool question — MED. Owner/HQ confirmation of the 09-06 retirement is the premise; then TOOLS.md:477 must match MEMORY.md.

### BS-M1 — MEDIUM — AGENTS.md always-loaded token weight, ×2.17 in 14 days

AGENTS.md is injected into every ops-profile session. Measured: **44,496 B file / 42,764 B content / 294 lines ≈ 11–13K tokens** at 3.2–4 ch/tok for this mixed prose-and-code text. Growth: **20,516 B (bak-1787945222, 2026-08-28) → 44,496 B today = +117% in 14 days**; +2,210 B in the last 8 hours alone (42,286 B @14:36 → 44,496 B @22:19). Section weight: **Execution Discipline = 11,780 B (27.5%)**, next 11 sections sum to ~38%. Of the 16 Execution Discipline entries, **7 are dated 2026-09-11** and come from a single lane (the #150 ship-chain + #116 smoke family): a day's incident log was appended as law, not digested. The law-first vs incident-first split drive this (see BS-H1 for the 4 that also duplicate the skill; BS-M5 for the 3 with no skill home yet).

### BS-M2 — MEDIUM — opencrabs-dev post-mortems accumulating in MEMORY.md, war-stories.md stalled

MEMORY.md's own header owns the law: *"opencrabs-dev records live in the skill: fleet-directives.md (owner directives) + war-stories.md (lessons); scrubbed 2026-09-02."* Verified actual state:

- `war-stories.md` last entry: **2026-09-05** (Mermaid × buttons, `ed5a42f7`).
- MEMORY.md since the drop: **≥18 incident sections** in the opencrabs-dev family — the phantom family ×6 (08-25 push self-heal, #110 events, sync-wake, 08-30 phantom CI findings x2, 09-05 phantom law commit `b8145f1`, phantom completion), CI-misc 08-30, smoke misattribution, swap coma, `send_buttons` #118 post-mortem, #138 probe rig, compaction OC_ACTOR, plus the 09-11 verification-discipline war stories that BS-H1 found duplicated into AGENTS.md.

Exactly the corpus the header assigns to `war-stories.md`. MEMORY.md is on-demand (never auto-injected, so no token cost) — the issue is **single-home discipline and retrievability**: `memory_search` ranks daily notes and buried incident text above the distilled war-story, so the lessons are effectively parked in the wrong drawer. The 09-11 verification-discipline family should land in `war-stories.md` (fleet §Verification-discipline additions already carries the condensed laws).

### BS-M3 — MEDIUM — stale pending-state with no resolution pointer

`MEMORY.md:151-160` "Cron deliver_to outage" (2026-08-26) ends with the pending line **"awaiting Alexey's A or B"** (fix now vs schedule-defer). `MEMORY.md:321-323` "Cron delivery forensics" (2026-09-05) records the resolution: fixed by appending the `[channels.telegram]` token to `keys.toml`. The 08-26 entry was never updated — a reader finds a superseded open question with no link to its own verdict nine days later. Stale-pending-state class.

### BS-M4 — MEDIUM — TOOLS.md duplicates its own content

Three intra-file duplication clusters (one concept, multiple homes — exactly what the lens polices, here within a single file):

| Cluster | Location 1 | Location 2 | Notes |
|---|---|---|---|
| write_opencrabs_file path rules | §write_opencrabs_file (52–73, 1,582 B) | "TOOLS addendum" (539–556, 1,367 B) | Same profile-relative, no-leading-slash, verify-returned-path rules twice |
| cargo prohibition | §Rust builds on this box (475–479) | §Rust verification — never local, never piped (590–597) | Same ban, different incident attached |
| grep_code routing law | `TOOLS.md:152-166` two bullets + AGENTS.md §Dynamic tool tails | — | The section says the routing "moved to AGENTS.md" but re-states it in full twice anyway — **3 copies of one law** (AGENTS.md + 2 in TOOLS.md) |

### BS-M5 — MEDIUM — incident-shaped Execution Discipline entries with NO skill home yet (land-first)

Three 09-11 laws in AGENTS.md have **no** condensed twin in the skill (verified by grep across fleet-directives/war-stories/editor.md/SKILL.md):

- "A mid-loop compaction summary is a SNAPSHOT" (847 ch) — NOT in skill
- "Hash anchors come from a same-turn read of that exact region" (910 ch) — NOT in skill
- "After a history rewrite, verify lane completion by CONTENT" (654 ch) — NOT in skill

Per lens rule 3 (move-with-verification), these are **land-in-skill-first** findings: the laws must first be added to `war-stories.md`/fleet in condensed form (they are genuine cross-session laws, not one-off noise), then AGENTS.md's entries shrink to one line + anchor. Removing them now without a skill home would orphan the laws.

### BS-M6 — MEDIUM — §Telegram identity law heading misnames a bundle of 7 laws

AGENTS.md's **5,017 B (11.7%)** "Telegram identity law (owner order 2026-09-04 22:23Z)" section contains only 2 telegram-identity laws (the `tg_send_message` ban; the routed/delivered receipt law). The other 5 entries under that heading are unrelated session/receipt law: "Claims from truncated tool output" (generic receipt law), "ANY identifier in a report needs a same-turn receipt" (generic), "Session naming convention" (opencrabs-dev lane naming — skill ontology home), "Skill-change lane notify" (opencrabs-dev skill-change process — fleet-directives canon already referenced in-file), "Dispatch = verify-unclaimed first" (Triage routing law — `triage.md` home). The heading inflation makes the true telegram-identity law look 3× bigger than it is and parks routing law under a misnamed banner. The 3 opencrabs-dev entries are pointers already referencing their canon (fleet/triage), but the section boundary should be redrawn.

### BS-L1 — LOW — stale tool names in TOOLS.md core-set list

`TOOLS.md:235` core list names `http_client` / `config_tool` / `follow_up_question`; `TOOLS.md:353` references `config_tool set_working_directory`. Live core tools (this session): `http_request` / `config_manager` / `suggest_options`. A lane told to prefer `http_client` in a pinned note gets a tool-not-found. LOW — resolvable by name-sync.

### BS-L2 — LOW — §ISSUE ROUTING anchor impedance

AGENTS.md cites "SKILL.md §ISSUE ROUTING"; in SKILL.md the ISSUE ROUTING table is a bullet-row **inside** §Hard rules (line 464), not a `##` heading. Text-search resolves it, heading-anchor tooling would not. The related **PR SHIPMENT LAW** row self-describes as "single home" — the section boundary markers should be promoted so the anchor is a real header.

### BS-L3 — LOW — MEMORY.md header cosmetics

Three H1-level lines where the stock layout expects one: line 1 `# OpenCrabs Long-Term Memory` (stock), line 3 scrub-subtitle as `# MEMORY — repo pointers` (H1 instead of a `<br>` note), and line 325 a **duplicate stock H1 mid-file** (`# OpenCrabs Long-Term Memory`) — an append artifact before the 09-06 block. The 09-07 H1-conflict entry claims the stock H1 "lives at line 1"; it also lives at 325. Cosmetic (no rule binds on it) but breaks the stock-header assumption both the template and the H1-conflict note rely on.

---

## Anchor Verification — positive results (NEGATIVE axis clean)

Every opencrabs-dev citation from AGENTS.md/TOOLS.md/MEMORY.md was resolved against the skill (file exists + header found, or sha in `git log`):

| Citation | Resolution |
|---|---|
| fleet-directives §Direct dispatch (v0.4.131) | ✓ §Direct dispatch, line 277 |
| fleet-directives §Creating new editors item 3 | ✓ editor item 3, line 181+ |
| fleet-directives §Cross-lane message delivery discipline (`bb402cbf`) | ✓ line 264; sha `bb402cbf` in skill `git log` |
| fleet-directives §Discussion links + fix-approval gate | ✓ line 122 |
| fleet-directives §Tool-problem reports | ✓ line 197 |
| fleet-directives §Upstream-merge cadence · HARVEST LAW · NO-HOLD | ✓ line 17 |
| fleet-directives what-now/next anchor (`3ab07c68`) | ✓ sha in skill `git log` |
| SKILL.md §Upstream relations | ✓ line 417 |
| editor.md §Mid-cycle skill drift (oc-drift-check) | ✓ line 147 |
| gatus-recovery / miidas / meta-factory / outreach-reply-sweep skills | ✓ all exist in skills/ |
| tools/archive/compiler.md · HEALTH-CHECKS.md | ✓ exist |
| session-notify.journal (TOOLS.md §session_notify) | ✓ exists, 264,688 B @22:42 |
| oc-ping-proof tool (TOOLS.md register) | ✓ exists |

---

## Overall Grade: **HIGH**

Damage is concentrated in **mis-education** (3 load-bearing items: TOOLS.md §plan teaches the wrong tool shape, MEMORY.md teaches a retired standard, AGENTS.md duplicates four laws whose canonical condensation already exists) rather than in the anchor web (which is sound). The positive axis — every pointer into the skill resolves — means remediation is shrink/digest, not re-point, and is mechanical once the premise checks are done.

## Recommended Remediation Order

1. **BS-H1 (shrink, canonical verified present):** reduce the four duplicated Execution Discipline entries to one-line pointers to `fleet-directives.md §Verification-discipline additions`. Owner approval for the shrink (brain files are append-only; `dedup_intent` path).
2. **BS-H2:** replace TOOLS.md §plan with a two-line pointer to the live plan-tool schema + keep only the durable quirks (plan-as-memory-across-compaction). Never re-document the operations list.
3. **BS-H3:** correct MEMORY.md CI-watcher lesson → native detached bash (`background: true`), drop oc-waiter, re-point or move to war-stories with correction baked in.
4. **BS-H4:** confirm the 09-06 `modum` retirement premise with HQ/owner, then sync TOOLS.md:477 to MEMORY.md:42.
5. **BS-M5 (land-first):** land the 3 homeless laws (compaction-snapshot, hashline-anchors, history-rewrite) in `war-stories.md` (HQ-only edit per single-writer law), then shrink AGENTS.md entries to pointers.
6. **BS-M2:** digest the ≥18 phantom-family + 09-11 incident sections from MEMORY.md into `war-stories.md`; leave one-line dated pointers (per the header's own routing law).
7. **BS-M1/M3/M4/M6/L1–L3:** housekeeping — rebalance Execution Discipline, add the resolution pointer to the cron-deliver_to entry, de-duplicate the three TOOLS.md clusters, redraw the §Telegram identity law section boundary, sync tool names, promote the ISSUE ROUTING header, fix the MEMORY.md H1s.

All shrinks require owner approval (brain files append-only; `dedup_intent`/`cleanup_intent` gate). No skill file was modified by this review.
