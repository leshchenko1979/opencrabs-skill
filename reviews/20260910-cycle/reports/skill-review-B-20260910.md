<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"# review-lenses.md — Duty-6 reviewer lens catalog (B4+G-F4 split, v0.4.78)\n\nFull briefs for the ten Duty-6 review lenses (A–I + standing brain-scrub; regrouped v0.4.81 with C joining TOOLS and D sole in ARTIFACTS — H later joined D in ARTIFACTS, v0.4.113/115). supervisor.md §Duty 6 owns the\nmethod (read-only sub-agents, verbatim-quote verification, oc-review-persist\npersistence, poll triple-check, verdict table) and keeps only the family map\nthere; this file owns the per-lens scope briefs (brain-scrub brief lives at fleet-directives.md § Review lens brain-scrub). Letters keep chronological\nbirth order (stable report/persist keys, not an ordering). Reviewer-performance\nloop lessons (supervisor.md step 7) fold INTO these briefs at ship time,\nattributed to the reviewer that produced the evidence. Family identity is the\nOBJECT under review, not the evidence flow between lenses (regrouped v0.4.81:\nC joined TOOLS — gaps/shape/implementation pipeline; D is sole in ARTIFACTS,\nthe family IS the deletion owner gate). Membership and grouping change only\non census evidence + owner word (supervisor.md step 7).\n\n#### FAMILY: DOCS — role files (wording / reading load / organization)\n\n   - **Reviewer A — REDUNDANCY + ONTOLOGY:** same rule stated twice across\n     files; duplicated war stories; terms violating the SKILL.md test ontology\n     (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY\n     SIGNAL); undefined coinages; stale ref names (lens I-2.2\n     v0.4.116: A owns ref CONSISTENCY; B weighs refs only as load-weight —\n     first finder gets attribution); SEDIMENT — stale layers\n     that survive because adding feels safe and removing feels risky\n     (docs-lens vocabulary reference:\n     `skills/writing-for-agents/SKILL.md`). PLUS the churn-drift checklist, EVERY\n     lens-A pass: (a) ONE CONCEPT = ONE NAME — sweep for synonyms of the same\n     gate/tool/artifact; (b) GLOSSARY CONFORMANCE — every load-bearing term\n     in a rule must resolve in SKILL.md §Gl","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"---\nname: opencrabs-dev\ndescription: >\n  OpenCrabs source ops (~/opencrabs): roles EDITOR (fork issues, per-task\n  worktrees, CI gate (pr-checks), signed commits, push + sha hand-off, oc-deploy ship,\n  smoke-test-on-notify, upstream PR), SUPERVISOR (skill set + worker ledger),\n  TRIAGE (interrupt lane: idea/QUIRK intake, fix routing, enforcement — carved out of SUPERVISOR at v0.4.86),\n  TOOLSMITH (CLI tool lane: owns tools/ — makes and fixes the CLI tools every other role uses — carved out at v0.4.87); the Compiler role is retired — re-enable trigger in STEP ZERO).\n  Use when editing/fixing OpenCrabs Rust code, debugging quick-build-linux carrier or other CI runs, fetching CI artifacts, or swapping /usr/local/bin/opencrabs.\n  (/opencrabs-dev)\nversion: 0.4.132\nauthor: leshchenko1979\nmetadata:\n  tags: [opencrabs, rust, ci, quick-build, binary-swap, worktree, session-notify]\n  references:\n    - https://github.com/adolfousier/opencrabs (upstream — PRs only; new issues NEVER filed here)\n    - https://github.com/leshchenko1979/opencrabs (fork — push target + ISSUES HOME)\n  provenance:\n    - \"Full release history moved out of the load path at v0.4.43 (B6, Duty-6 run-2) — every v0.4.31+ bump entry lives in CHANGELOG.md (git-tracked, appended newest-last). This pointer replaces the inline list (~3k tokens loaded on every role-file claim). Current version: see CHANGELOG.md.\"\n---\n\n# opencrabs-dev — OpenCrabs source procedure\n\n**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the\ninstalled `opencrabs` binary. This file = shared facts + role router only. Actual\nprocedures live in FOUR role files (`editor.md` / `supervisor.md` / `triage.md` / `toolsmith.md`) + one\nARCHIVED runbook (`tools/archive/compiler.md` — retired at S3 cutover 2026-08-28, re-enable\n= one notify);\nload ONLY the one matching the session's role.\n\n**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo\nprohibition, telegram surface law, tool logging, gate","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md","o":"# EDITOR — commits and error fixes\n\n**Load only after SKILL.md confirmed the role is EDITOR.**\n\n> **RELOAD LAW (v0.4.96, lens B-F2/G-5):** after ANY context compaction or\n> session spawn — not only at claim time (Phase 1 step 0) — re-read from disk,\n> IN FULL: `SKILL.md` + this file + `fleet-directives.md` (thematic index\n> minimum; every `[LANE]`-tagged section in FULL). Same law as the other three\n> roles; this header is the in-file trigger a compacted mid-task editor hits\n> even when it never re-claims.\n\nScope: work from an issue filed on the FORK (`leshchenko1979/opencrabs` — the issues home;\nupstream receives PRs only), fix the code in a\nworktree, SIGN every commit with the session trailer, push the branch, then ship via\n`oc-ship-chain` (§Phase 5 — Ship (`oc-ship-chain`), below).\nAfter any\nswap containing your commits you TEST what shipped (test-on-notify loop,\nPhase 6b). The Editor NEVER dispatches BUILD runs (`quick-build-linux.yml`), NEVER\nwatches build runs, and NEVER touches binaries — all automation territory via\n`oc-deploy` (NO dispatch exceptions: BUILD TRIGGERS = exactly TWO — SKILL.md §Hard rules).\nThe Editor also owns CI/workflow config on the fork: changing the shipped feature\nset = one-line commit to `quick-build-linux.yml`'s `features:` input `default:`\n(the single source of truth — skills never copy it). When a feature is COMPLETE\n(merged to fork `main`, shipped green, smoke test PASS — filing itself is\nAUTO-SHIP: law home SKILL.md §ISSUE ROUTING, PR SHIPMENT row), the Editor\nadditionally\nowns its upstream contribution — Phase 7: harvest fork-only commits → upstream\nPR → close the tracked FORK issues (procedure: `editor-upstream-pr.md`).\n\n## Box law — no local cargo, ever\n\ncargo/rustc/clippy are FORBIDDEN on this box in ANY form: PATH, login shell,\n`PATH=\"$HOME/.cargo/bin:$PATH\"` prepends, explicit paths\n(`~/.cargo/bin/*`, `~/.rustup/toolchains/*/bin/*`), `source ~/.cargo/env`, any\nother bypass. The BLOCKED stubs in `/usr/local/bin` are the floor","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/supervisor.md","o":"# SUPERVISOR — skill maintenance & worker coordination\n\n**RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or\nspawn, re-read from disk: `SKILL.md` + `supervisor.md` + `fleet-directives.md`\nIN FULL (the supervisor OWNS the directives file and RULES on disputes citing\nit — a compacted HQ enforcing half-remembered directives is worse than a lane\nmissing the cadence law). Post-compaction anchor lives in ops AGENTS.md; this\nline is the in-skill backstop.\n\n**Load only after SKILL.md confirmed the role is SUPERVISOR.** This is the HQ\nsession's standing role. Interrupt-shaped duties (idea-box / QUIRK intake,\nfix routing, enforcement patrols) operate in the TRIAGE lane since v0.4.86\n(owner \"Go with Option A\" 2026-09-06) — procedure: `triage.md`; batched\nescalations from that lane land here. Skill-file authorship stays SOLELY\nwith the Supervisor (single-writer law unchanged; v0.4.87 carve-out: the\nTOOLSMITH lane owns `tools/` CODE — skill markdown never leaves this lane).\n\nScope: own the skill set (full census in SKILL.md §Hard rules — incl. `fleet-directives.md`,\n`upstream-merge-runbook.md`, `editor-phase7-rules.md`, `war-stories.md`, `s2-swap-journal-spec.md`;\n`tools/archive/compiler.md` archived), keep every worker ON the current skill version, and\nturn field evidence into rules. The Supervisor NEVER dispatches builds, NEVER swaps\nbinaries, NEVER touches the binary, NEVER writes feature code.\n\n**PROCESS-TOOL OWNERSHIP (v0.4.87 Toolsmith carve-out):** CLI tools that\nautomate OUR process steps (sealing state files, presence gates, roster\npulls, job-name verification, health receipts) are the TOOLSMITH lane's to\nCREATE, FIX, and MAINTAIN (toolsmith.md) — ops tooling, NOT opencrabs\nfeature code. Tools live in\n`skills/opencrabs-dev/tools/` (`./tools/<name>`, next to these files), one\nscript per job, single-command interface. Build only what RECURS (≥3 manual hits or one incident-class burn);\nYAGNI applies — never automate a one-off or a human-judgment cal","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md","o":"# TRIAGE — interrupt lane: idea/quirk intake, fix routing, enforcement\n\n**RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or\nspawn, re-read from disk: `SKILL.md` + `triage.md` + `fleet-directives.md`\n(thematic index minimum; every `[LANE]`-tagged section in FULL). This file\nCITES directive law (delivery cadence, editor creation) — citations are\npointers, not substitutes; briefs die at compaction, disk doesn't.\n\n**Load only after SKILL.md confirmed the role is TRIAGE.** This is the OC DEV\nTRIAGE session's standing role — carved out of the Supervisor lane at v0.4.86\n(owner word \"Go with Option A\" 2026-09-06). Interrupt-shaped duties moved HERE\nso the Supervisor (HQ) keeps uninterrupted deep-work windows: skill\nauthoring, procedure rulings, review batteries. **Upstream sync: Triage\npatrols only (census, harvest pause, post-merge re-run) — the merge itself\nis HQ-EXECUTED per upstream-merge-runbook.md (sharpened v0.4.125 after\nowner/IOC divergence on this line, 2026-09-09).**\n\nThe Triage lane is INTERRUPTIBLE BY DESIGN: every work item is small and fast —\nACK, ledger stamp, verify evidence, route. Deep work never lands here; it\nescalates to the Supervisor.\n\n**STRICT ROUTING:** code fixes, CI dispatches, binary swaps arriving here are\nROUTED to the owning worker lane — never executed by this session, no\ndeputization. Expected reply shape: \"routed to <lane>\", not done-work.\n\n## NEVER list (hard boundaries)\n\n- NEVER edits skill files — the single-writer law is UNCHANGED: only the\n  Supervisor (HQ) writes SKILL.md / role files / fleet-directives.md /\n  reference pages (SKILL.md §Hard rules census). Every skill-edit request\n  leaves this lane as an IDEA:/QUIRK: intake item, never a direct edit.\n- NEVER dispatches builds, swaps binaries, writes feature code.\n- NEVER issues binding rulings (supervisor.md Duty 5 stays at HQ); protocol\n  disputes escalate, they don't settle here.\n- NEVER messages the owner directly with verdict tables — the Supervisor owns","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md","o":"# TOOLSMITH — CLI tool lane: makes and fixes the tools every other role uses\n\n**RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or\nspawn, re-read from disk: `SKILL.md` + `toolsmith.md` + `fleet-directives.md`\n(thematic index minimum; every `[LANE]`-tagged section in FULL). This file\nCITES directive law (cadence, scope) — citations are pointers, not\nsubstitutes; briefs die at compaction, disk doesn't.\n\n**Load only after SKILL.md confirmed the role is TOOLSMITH.** This is the OC DEV\nTOOLSMITH session's standing role — carved out at v0.4.87 (owner word \"Go\ntoolsmith\" 2026-09-06), promoted from the carrier-tools editor row (topic\n39171, rostered since 2026-09-01). Owns the skill's CLI tooling under\n`tools/` — the commands every other lane runs: `oc-ledger`, `oc-deploy`,\n`oc-prchecks`, `oc-order-validate`, `oc-tg-audit`, `oc-waiter`, the\n`tools/tests` battery. Duty S1 below owns the what/how.\n\n**STRICT SCOPE:** skill markdown + fleet-directives stay Supervisor-only\n(single-writer law). The OpenCrabs daemon/carrier source (`~/opencrabs`) is\nEDITOR territory — this lane touches neither.\n\n## NEVER list (hard boundaries)\n\n- NEVER edits skill files (SKILL.md / role files / fleet-directives.md /\n  reference pages) — the single-writer law is UNCHANGED; a tooling GAP that\n  needs skill text leaves this lane as an `IDEA:` intake item to the TRIAGE\n  lane, never a direct edit.\n- NEVER edits daemon source (`~/opencrabs`), NEVER dispatches carrier builds,\n  NEVER swaps binaries — daemon defects leave as `QUIRK:`/IDEA to the TRIAGE\n  lane and ship through the normal editor flow if accepted.\n- NEVER issues binding rulings (supervisor.md Duty 5 stays at HQ); protocol\n  disputes escalate, they don't settle here.\n- NEVER messages the owner directly with verdict tables — the Supervisor owns\n  owner-facing verdict batches.\n\n## Duty S1 — Own `tools/` code (author + fixer, ex-Supervisor at v0.4.87)\n\n**Standing duties (owner 2026-09-08 \"Go then duty 4+6\", v0.4.108):**\n","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"# Fleet directives — opencrabs-dev owner rulings\n\n**Owns:** binding owner directives for opencrabs-dev work (sync policy, upstream PR law, builds/carriers, cargo prohibition, telegram surface law, tool logging, gates, editors, triage, cadence). Re-homed here from ops AGENTS.md/MEMORY.md per owner order 2026-09-02. Where a ruling's full text already lives canonically in another skill file, this file carries only a pointer — one concept, one home.\n\n**Thematic index** (lens B-17/G-F9 v0.4.90 — file is flat; jump via section name). **[LANE] tag (v0.4.95):** sections every worker MUST read in full at spawn/compaction reload (editor.md/triage.md/toolsmith.md/supervisor.md RELOAD LAW v0.4.95). EXCEPTION (v0.4.96, lens B-F1): the SUPERVISOR re-reads THIS ENTIRE FILE IN FULL (~54 kB and growing — exact size varies per cycle; it owns and rules on the directives; the other three roles may use the thematic-index minimum for non-[LANE] sections):\n**Remotes & sync** (remotes, sync policy) · **Merge-resolution shape** (upstream-wins-wholesale, overlay disposition) · **Upstream-merge cadence · HARVEST LAW · NO-HOLD** (daily patrol, filing gate, port-work ownership) · **Upstream** (issue filings, PR base-Lint, cross-fork PR, PR naming) · **Builds & ships** (S3/oc-deploy, swap-head signature, swap-sha coverage, features-compat gate, hotfix REDs, no auto-rollback) · **Process & verification** (stage-entry consent, attribution guard, inherited-claim pillars, truncated-output rule, post-compaction reload, what-now/next) · **Channels** (telegram surface law, telegram_send addressing law + TO-BE appendix (outside reload path), post-swap notify, cross-lane delivery cadence, tool logging) · **Lanes** (creating new editors, tool-problem reports/Triage, cadence boundary, parked issues, brain-scrub, discussion links, every-turn verdicts, rule-text provenance, daemon no-reap).\n\n<!-- source: AGENTS block1 (remotes/upstream/source-work/impl-comment) -->\n## Remotes & sync\n\n**~/opencrabs remotes** ","s":true}] -->

<!-- tools-v2: [{"d":"Grep '.*' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:514:\n> | PR SHIPMENT — **AUTO-SHIP LAW (single home; owner order 2026-09-09 ~10:4xZ \"the owner should not approve shipping, it should be automatic\"): feature COMPLETE + smoke PASS (v0.4.104 four-leg rubric) → Editor harvests fork-only commits, files the upstream PR — NO owner word needed; the owner is notified AFTER the act. Supersedes the 2026-08-25 owner-approval gate and the 2026-09-08 \"my go before pr\" gate. All other references to this law are pointers to THIS row — procedure: `editor-upstream-pr.md` Phase 7; fleet-directives §Upstream-merge cadence (harvest census); triage.md T4.** | mechanical gates | 2026-09-09 owner order |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:519:\n> 2026-08-22 issues/comment rule).*\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:562:\n> - Restart scope: **`opencrabs-ops` ONLY.** The `family` and default-profile daemons\n\n(3 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"---\nname: opencrabs-dev\ndescription: >\n  OpenCrabs source ops (~/opencrabs): roles EDITOR (fork issues, per-task\n  worktrees, CI gate (pr-checks), signed commits, push + sha hand-off, oc-deploy ship,\n  smoke-test-on-notify, upstream PR), SUPERVISOR (skill set + worker ledger),\n  TRIAGE (interrupt lane: idea/QUIRK intake, fix routing, enforcement — carved out of SUPERVISOR at v0.4.86),\n  TOOLSMITH (CLI tool lane: owns tools/ — makes and fixes the CLI tools every other role uses — carved out at v0.4.87); the Compiler role is retired — re-enable trigger in STEP ZERO).\n  Use when editing/fixing OpenCrabs Rust code, debugging quick-build-linux carrier or other CI runs, fetching CI artifacts, or swapping /usr/local/bin/opencrabs.\n  (/opencrabs-dev)\nversion: 0.4.132\nauthor: leshchenko1979\nmetadata:\n  tags: [opencrabs, rust, ci, quick-build, binary-swap, worktree, session-notify]\n  references:\n    - https://github.com/adolfousier/opencrabs (upstream — PRs only; new issues NEVER filed here)\n    - https://github.com/leshchenko1979/opencrabs (fork — push target + ISSUES HOME)\n  provenance:\n    - \"Full release history moved out of the load path at v0.4.43 (B6, Duty-6 run-2) — every v0.4.31+ bump entry lives in CHANGELOG.md (git-tracked, appended newest-last). This pointer replaces the inline list (~3k tokens loaded on every role-file claim). Current version: see CHANGELOG.md.\"\n---\n\n# opencrabs-dev — OpenCrabs source procedure\n\n**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the\ninstalled `opencrabs` binary. This file = shared facts + role router only. Actual\nprocedures live in FOUR role files (`editor.md` / `supervisor.md` / `triage.md` / `toolsmith.md`) + one\nARCHIVED runbook (`tools/archive/compiler.md` — retired at S3 cutover 2026-08-28, re-enable\n= one notify);\nload ONLY the one matching the session's role.\n\n**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo\nprohibition, telegram surface law, tool logging, gate","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"Gate 4 (Session-Id trailer, `quick-build-linux.yml` ORDER gates) applies to every swap head. Merge commits cannot carry trailers, so a bare merge must never be dispatched to the build leg (2026-09-03: bare merge `d02f4e08` passed pr-checks GREEN, swap blocked exit 2 pre-install; fixed forward-only with empty marker `1d0dd4cc`). Standing law:\n\n1. **Marker, not waiver** — the marker-commit procedure (tree-identical empty trailer-signed commit before the build dispatch) lives in upstream-merge-runbook.md step 8 — this file carries the RULING only: never dispatch a bare merge, never loosen gate 4. Owner's swap ruling carries over; the marker changes no bytes.\n2. **pr-checks mirrors gate 4 in swap mode** — `pr-checks.yml` (carrier branch `ci/quick-build-linux`, landed `464f77c4`) takes `swap=true`: runs the exact gate-4 regex on the gated ref before fmt/clippy/tests. Swap-mode GREEN ⇒ swappable — the build leg has no remaining semantic failure mode (clippy+tests subsume build success; the binary build itself stays quick-build's job, no duplicate artifact per the 2026-08-31 de-dup ruling). Input-gated: ordinary PR-lane runs unchanged.\n3. **Version stays put on merges/swaps** — merge-derived binaries ship with the tree's standing version; `deployed.meta.json` (sha + artifact sha256) is the identity record, not the version string. Owner 2026-09-03: a version bump is a release-flow event, not a merge or swap event.\n\n## Swap-sha test coverage — no test-blind swaps (HQ ruling 2026-09-03, owner-ratified flow)\n\nA swap may only consume an artifact whose exact tree is covered by a GREEN full-gate run (fmt + clippy + lib tests) on that same sha. Build legs may run `--no-tests` **only** with that coverage already on record; otherwise the build leg runs the tests itself. In practice: **swap-mode pr-checks before every swap.** Rationale: run `33792926801` (\"success\", no-tests) shipped test-RED `f3c03269` into prod, and the same artifact was later auto-consumed by an unordered swap. No","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"- Editors own testing THEIR features on notification: SMOKE TESTS against the\n  swapped binary running on this box (the cargo ban itself = editor.md §Box law, one\n  statement). Failures funnel back through blame attribution\n  (issue #24: `oc-attrib` over Session-Id trailers — mechanical via\n  `oc-deploy fanout` since v0.4.37),\n  which asks the guilty editors for fixes.\n- Separation holds inside the loop: the fan-out notifies + attributes but NEVER\n  fixes code; Editors fix + re-push but NEVER attribute others' failures.\n\n### session_notify mechanics (upstream #1203, commit 13a24f25)\n\n- Same-process only: pushes into a LIVE session's queue on THIS box. Target must\n  have messaged since boot; dead/cross-instance targets error → fall back to\n  `a2a_send`, else list UNREACHABLE in the report.\n- DELIVERY ≠ QUEUE ACCEPTANCE: a ping counts as delivered\n  ONLY with post-ping proof — same-turn live roster check (`session_search`),\n  target PINGED-WOKEN (`last_active` > ping time) or PINGED-SILENT. Ledger\n  entries saying \"pinged\" without wake evidence are forbidden (all roles).\n- Sender identity is mechanical — deliveries arrive prefixed\n  `[session-notify from=<uuid>]`; replies route back with `target_session = from`.\n  Neither role can forge or strip identity.\n- Delivery drains at the target's next tool-loop boundary and wakes idle\n  sessions — no polling anywhere.\n- DELIVERY MODES (v0.4.69; defaults re-ruled 2026-09-04 22:31Z — fleet-directives\n  §Cross-lane message delivery discipline is CANONICAL: deferred is the default,\n  immediate the exception, \"Do not start at `now`\"):\n\n  | Mode | Note |\n  |---|---|\n  | quiet (DEFAULT) / turn-end / now (EXCEPTION) / redirect / no-route | full table = fleet-directives.md §Cross-lane message delivery discipline (CANONICAL — this row is a failsafe pointer, lens B-F15 v0.4.96) |\n  | failsafe | target mid-turn — `interrupt: true` (\"#13 failsafe\"): message QUEUES, drains at next boundary; escalation of a stuck quiet/turn-end delivery (~3","s":true}] -->

<!-- tools-v2: [{"d":"Grep '.*' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:514:\n> | PR SHIPMENT — **AUTO-SHIP LAW (single home; owner order 2026-09-09 ~10:4xZ \"the owner should not approve shipping, it should be automatic\"): feature COMPLETE + smoke PASS (v0.4.104 four-leg rubric) → Editor harvests fork-only commits, files the upstream PR — NO owner word needed; the owner is notified AFTER the act. Supersedes the 2026-08-25 owner-approval gate and the 2026-09-08 \"my go before pr\" gate. All other references to this law are pointers to THIS row — procedure: `editor-upstream-pr.md` Phase 7; fleet-directives §Upstream-merge cadence (harvest census); triage.md T4.** | mechanical gates | 2026-09-09 owner order |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:519:\n> 2026-08-22 issues/comment rule).*\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:562:\n> - Restart scope: **`opencrabs-ops` ONLY.** The `family` and default-profile daemons\n\n(3 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"  2026-09-06): owns `tools/` code — makes + fixes the CLI tools every other role\n  uses (`toolsmith.md`); never edits skill markdown. Discover its session via\n  `session_search`, never uuid-from-memory.\n- **Roster** — the worker registry in `workers-ledger.json` (enroll / claim /\n  ack rows); `oc-attrib` joins Session-Id trailers against it.\n- **Lens (Reviewer A–I)** — one Duty-6 read-only review perspective\n  (supervisor.md §Duty 6; full briefs: `review-lenses.md`).\n- **Supervisor (HQ)** — the canonical name for the supervisor lane; unofficial\n  variants (\"Author lane\", \"Carrier\") seen in lane files are retired — lens\n  A-L3 v0.4.116.\n- **Selftest** — a tool's built-in test mode (`oc-deploy --selftest` etc.);\n  **battery** — `tools/tests/run.sh` across all tools. Both green before\n  ANY version bump.\n- **GREEN / RED** — a GitHub Actions run conclusion read by terminal truth\n  (`gh run view --json conclusion`), never exit-code inference.\n- **TOOL_ACCUM** — the per-session tool-usage rows accumulated in the unified\n  tools log; evidence base for Telegram surface-law audits (triage.md Duty T4\n  — ex supervisor.md Duty 7).\n\n## Red-run triage heuristics (shared core, v0.4.10 — moved from editor.md Phase 6)\n\nONE location: red-run diagnosis reads these (pre-S3: Compiler Step 2; now:\n`oc-deploy` RED reports + supervisor triage); the\nEditor applies the same ones in its fix round (editor.md Phase 6c). No lane\nuses them as a licence to fix outside its scope.\n\n- Fix unresolved-name/import errors FIRST (E0425/E0433...) — later errors are\n  usually poisoned fallout. When scopes look shifted, count brace DEPTH, not\n  brace counts.\n- Match-arm narrowing does not inherit through outer arms — an inner match\n  needs its own exhaustive arms regardless of the outer guard.\n- **Contradictory INCOMING verdicts → settle via live GH API before acting**\n  (v0.4.14, proposal P3): when two claims about the SAME run/sha disagree (e.g.\n  a RED report vs an ACK calling that run \"in_progress\"), re","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"   ruling):** fork `ci.yml` stays REMOVED (zombie-run risk, order cc100dc6);\n   the carrier branch is the sole build lane. oc-ci-parity RETIRED v0.4.117\n   (owner \"3 - ok\" 21:44Z: zero live use, C-H2; runbook diff check supersedes).\n7. **Fork branch lifecycle (v0.4.24)**: the fork carries\n   PERMANENT refs only — `main` (sync mirror; pre-S3: compiler rebase-port), `ci/quick-build-linux`\n   (carrier), `backup/pre-port-*` (until the port cycle settles) — plus short-lived\n   `leshchenko1979/<slug>` work branches. A work branch dies when its PR merges or the task\n   dies, and ONLY after its landing is PROVEN by one of: tip sha-reachable from upstream or\n   fork `main` · tip contained in `backup/pre-port-*` · exact mirror of a live upstream\n   branch · a MERGED PR (either repo) whose head is the branch. Deletion without proof is\n   forbidden — unproven branches stay and get reported to the owner. Every sweep archives\n   BEFORE deleting: tip tags `archive/<date>/<branch>`, an `--all` bundle, and a manifest,\n   so any deletion is reversible in one command. Branch heads riding OPEN PRs are\n   never deletable.\n\n\n## Hard rules (all roles)\n\n- Reports to Alexey: every issue/PR reference\n  carries the LINK behind the number (issues: `https://github.com/leshchenko1979/opencrabs/issues/N`\n  — the fork is the issues home; PRs: `https://github.com/adolfousier/opencrabs/pull/N`) — a bare `#N` is never enough.\n- Refer to workers by TOPIC/CHAT NAME only (owner 2026-08-31): Mermaid, Push to\n  session, Vector memory, … — NEVER by session uuid. Applies to EVERY surface:\n  owner reports, inter-lane advisories, session_notify text, verdict tables,\n  ledger commentary. Uuids are for ROUTING fields only (`target_session`,\n  `OC_ACTOR`, `Session-Id` trailers, tool arguments) — never prose. Test: an\n  owner reading the message must know WHICH chat to open without a lookup.\n- Stick to the OFFICIAL ONTOLOGY (owner 2026-08-31): all roles use the\n  vocabulary this SKILL defines — test ontology (§Te","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'oc-post-receipts' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:53:\n> | `./tools/archive/oc-post-receipts ...` | **INTERNAL/ARCHIVED** (E2 #7) — zero live consumers, do NOT call |\n\n(1 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'P1 REJECTED' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:500:\n> - P1 REJECTED (owner verdict 2026-08-26 — \"overengineering, don't do this\"):\n\n(1 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'One watcher law' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/editor.md:87:\n> 1. **One watcher law (v0.4.120, owner-ordered — supersedes all prior watcher\n\n(1 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'LIVE STATUS IS NEVER STORED' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/supervisor.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/supervisor.md:69:\n> - **LIVE STATUS IS NEVER STORED:** whenever liveness or freshness matters,\n\n(1 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'Harvest backlog patrol' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:125:\n> - **Harvest backlog patrol (owner 2026-09-08 \"Go\", v0.4.97 — DAILY):** run\n\n(1 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'P1 REJECTED' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/SKILL.md:500:\n> - P1 REJECTED (owner verdict 2026-08-26 — \"overengineering, don't do this\"):\n\n(1 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'NEVER' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md:21:\n> ## NEVER list (hard boundaries)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md:23:\n> - NEVER edits skill files (SKILL.md / role files / fleet-directives.md /\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md:27:\n> - NEVER edits daemon source (`~/opencrabs`), NEVER dispatches carrier builds,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md:28:\n>   NEVER swaps binaries — daemon defects leave as `QUIRK:`/IDEA to the TRIAGE\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md:30:\n> - NEVER issues binding rulings (supervisor.md Duty 5 stays at HQ); protocol\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md:32:\n> - NEVER messages the owner directly with verdict tables — the Supervisor owns\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/toolsmith.md:106:\n> N items beats N notifies. Receipts, ACKs, and ROUTED stamps NEVER escalate;\n\n(7 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Grep 'NEVER' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:26:\n> ## NEVER list (hard boundaries)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:28:\n> - NEVER edits skill files — the single-writer law is UNCHANGED: only the\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:32:\n> - NEVER dispatches builds, swaps binaries, writes feature code.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:33:\n> - NEVER issues binding rulings (supervisor.md Duty 5 stays at HQ); protocol\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:35:\n> - NEVER messages the owner directly with verdict tables — the Supervisor owns\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:47:\n>    + date + evidence. Ideas NEVER edit skill files — the Supervisor authors,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:212:\n> - **LIVE STATUS IS NEVER STORED:** a stored ACTIVE/DORMANT/UNREACHABLE is stale\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:241:\n> 4. NEVER relay, aggregate, summarize, or edit lane lists. The old model\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:244:\n> 5. NEVER answer the Rollcall for a lane, and never append your own queue\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:254:\n>    30220, superseding the 08:34Z topic-42487 amendment): NEVER collect or\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:269:\n> stamps NEVER escalate; they live in the ledger.\n\n(11 matches)","s":true}] -->
# Duty 6 Cycle 5 — Lens B: LLM Efficiency & Responsibility Creep Report

**Reviewer:** Reviewer B (LLM Efficiency + Responsibility Creep)  
**Target:** opencrabs-dev (v0.4.132)  
**Corpus Reviewed:** `SKILL.md`, `editor.md`, `supervisor.md`, `triage.md`, `toolsmith.md`, `fleet-directives.md`, `review-lenses.md`  
**Tool Execution Note:** Sub-agent running in read-restricted environment (#1173); output delivered verbatim as final response under the write-less reviewer fallback protocol (`review-lenses.md` §Persistence fallback).

---

## Executive Summary

| Category | HIGH | MED | LOW | Total |
|---|---|---|---|---|
| Token Weight & Cross-Role Leaks | 2 | 2 | 1 | 5 |
| Prose That Should Be Tables | 1 | 3 | 0 | 4 |
| Dead References & Duty Migrations | 1 | 2 | 1 | 4 |
| NO-OP Test (Default Behavior) | 0 | 3 | 2 | 5 |
| CACHE Test (Stale Environment Duplication) | 0 | 2 | 2 | 4 |
| NEGATION Test (Prohibition Steering) | 1 | 2 | 1 | 4 |
| ONE-TRIGGER-PER-BRANCH | 0 | 2 | 1 | 3 |
| **Total** | **5** | **16** | **8** | **29** |

---

## 1. Token Weight of Role Required Reading & Responsibility Creep

### [HIGH] B-1.1: Multiplied Token Load in Router File `SKILL.md` (4x Reload Law Multiplier)
* **File & Line:** `SKILL.md:53`
* **Verbatim Quote:**
  ```markdown
  | `./tools/archive/oc-post-receipts ...` | **INTERNAL/ARCHIVED** (E2 #7) — zero live consumers, do NOT call |
  ```
* **Analysis:** Under the Reload Law (`SKILL.md` + role file loaded in full on every compaction/spawn), every router line in `SKILL.md` costs 4x across Editor, Supervisor, Triage, and Toolsmith. Listing an archived tool explicitly noted as having "zero live consumers" pays 4x token budget on every reload across the entire fleet for zero operational value.
* **Fix:** Purge archived tools with zero live callers from `SKILL.md` canonical tooling table (preserve only in `tools/RC-CONTRACT.md` archive section).

---

### [HIGH] B-1.2: Duplicated Registry Schema & Rules Across Supervisor and Triage
* **File & Line:** `supervisor.md:69-83` vs `triage.md:181-195`
* **Verbatim Quote (`supervisor.md:69-72`):**
  ```markdown
  - **LIVE STATUS IS NEVER STORED:** whenever liveness or freshness matters,
    DISCOVER it in the same turn: `session_search` roster for sessions,
    `gh run list` for CI, `git ls-remote` for refs.
  - Seed/update ONLY from proven facts (full schema + write rules now live in
    triage.md §Duty T6 — lens B-F10 v0.4.96 cross-role move).
  ```
* **Verbatim Quote (`triage.md:181-185`):**
  ```markdown
  - **LIVE STATUS IS NEVER STORED:** a stored ACTIVE/DORMANT/UNREACHABLE is stale
    on arrival. Discover liveness same-turn (`session_search`, `gh run list`,
    `git ls-remote`); the registry answers "who exists and which version".
  - Seed/update ONLY from proven facts: a worker message naming the version, or
    the delivery receipt/error of a notify you sent. Never assume.
  ```
* **Analysis:** Even though `supervisor.md` notes that registry write ownership moved to Triage (`Duty T6`), `supervisor.md:69-95` continues to duplicate the live status prohibition, seed rules, version-skew policy, and ack contract verbatim.
* **Fix:** Collapse `supervisor.md §Duty 2` to a pure 2-line pointer to `triage.md §Duty T6` for registry write semantics, keeping only the supervisor's read responsibility.

---

### [MED] B-1.3: Cross-Role Procedure Bleed in `editor.md` CI-Wait Discipline
* **File & Line:** `editor.md:58-61` & `editor.md:87-95`
* **Verbatim Quote (`editor.md:58-61`):**
  ```markdown
  *(Waiter-discipline items — poll floor, --wait ceiling, invocation
  verify, notify wiring, log-window cuts, REST casing — are SUPERVISOR-scoped:
  supervisor.md §CI-wait & waiter discipline, items W1–W6.)*
  ```
* **Verbatim Quote (`editor.md:94-95`):**
  ```markdown
  Carrier waits remain SUPERVISOR-owned via `oc-deploy watch`/`poll`.
  ```
* **Analysis:** An Editor reading `editor.md` is forced to load summary descriptions of Supervisor-scoped rules (W1–W6) before proceeding to editor items. Items like `editor.md:124` also mix supervisor instructions ("Sweep/watchdog = oc-waiter sweep (cron-callable; ORPHANED wakes owner + HQ)").
* **Fix:** Strip the inline summary of Supervisor W1–W6 rules from `editor.md`. Replace with a single-line link: "Supervisor waiter rules (W1–W6) live in `supervisor.md`."

---

### [MED] B-1.4: Tool Reference Over-Inclusion in Role Files
* **File & Line:** `editor.md:195-207`
* **Verbatim Quote:**
  ```markdown
  | `oc-attrib` | `tools/oc-attrib --deployed` | who owns the deployed range (fanout targeting) |
  | `oc-branch-sweep` | `tools/oc-branch-sweep --repo <path>` | merged/stale branch proof; deletes MERGED only |
  | `oc-pr-fault-scope` | `tools/oc-pr-fault-scope <pr> --run <id>` | failing-files ∩ PR-files (blame hygiene) |
  ```
* **Analysis:** `oc-attrib` (used in mechanical post-swap fanout by `oc-deploy`), `oc-branch-sweep` (owned by Triage in Duty T4), and `oc-pr-fault-scope` are included in the Editor's quick reference table. `editor.md` should contain only tools directly invoked in editor phases (Phases 0–6c).
* **Fix:** Prune non-editor tools from `editor.md §Tool reference` to reduce editor context load.

---

### [LOW] B-1.5: Historical Provenance in `SKILL.md` Frontmatter
* **File & Line:** `SKILL.md:17-18`
* **Verbatim Quote:**
  ```markdown
  provenance:
    - "Full release history moved out of the load path at v0.4.43 (B6, Duty-6 run-2) — every v0.4.31+ bump entry lives in CHANGELOG.md (git-tracked, appended newest-last). This pointer replaces the inline list (~3k tokens loaded on every role-file claim). Current version: see CHANGELOG.md."
  ```
* **Analysis:** Meta-explanation describing *why* the history was moved in v0.4.43 is loaded on every skill load.
* **Fix:** Trim provenance string to: `"Release history lives in CHANGELOG.md."`

---

## 2. Prose That Should Be Tables

### [HIGH] B-2.1: Triage Enforcement Patrols (Duty T4)
* **File & Line:** `triage.md:104-171`
* **Verbatim Quote (`triage.md:104-135`):**
  ```markdown
  - **Stale-branch sweep patrol (owner 2026-09-08 "Go then duty 4+6",
    v0.4.108 — DAILY, rides the T4 census turn):** run
    `./tools/oc-branch-sweep` (fresh receipt) against the fork; the sweep
    reports contained/stale branches; deletion of any referenced branch
    (open PR head, lane worktree ref) stays lane-reference-checked — sweep
    SURFACES, owner/deletion law disposes. Closes the ownerless gap: the
    tool existed (editor.md) with no caller, and ~55 contained branches sat
    queued a full day.
  - **Telegram-law TOOL_ACCUM enforcement (v0.4.43, A12):** the violation
    pattern is caught from evidence, not intuition. On suspicion run
    `./tools/oc-tg-audit <session-uuid> [--days N]` — the only sanctioned
    scanner (raw log grep is retired; the tool embodies the log format and the
    banned-tool list). A matching row → notify the rule
    (SKILL.md §Telegram surface law); repeat → escalate to the Supervisor for a
    review-toggle decision (sanctioned-sender judgment stays HIS).
  ```
* **Analysis:** Duty T4 consists of 6 dense paragraphs outlining 6 distinct patrols: Stale-branch, TOOL_ACCUM, Delivery-cadence, Harvest backlog, Upstream PR-state, and Cron liveness. Each follows the exact pattern: Patrol Name, Trigger/Cadence, Tool Invocation, Action/Escalation.
* **Fix:** Convert Duty T4 into a structured patrol table:
  ```markdown
  | Patrol | Cadence | Tool | Gate / Action |
  |---|---|---|---|
  | Stale-branch | Daily (T4 turn) | `./tools/oc-branch-sweep` | Surface contained branches to owner |
  | TOOL_ACCUM | On suspicion | `./tools/oc-tg-audit <uuid>` | Notify rule on hit; escalate repeat to HQ |
  | Delivery cadence | Turn-level | Ledger inspection | Flag `now`-mode violations; route correction |
  | Harvest backlog | Daily 03:00Z | `./tools/oc-upstream-delta` | Post tiered census to 30220; auto-file on PASS |
  | Upstream PR state | Daily (census turn) | `gh pr view <n>` | Verify mergeability of open upstream PRs |
  | Cron liveness | Daily (census turn) | `cron` list check | Verify last-run timestamps of law crons |
  ```

---

### [MED] B-2.2: Supervisor CI-Wait & Waiter Discipline (W1–W6)
* **File & Line:** `supervisor.md:308-325`
* **Verbatim Quote:**
  ```markdown
  - **W1. Poll floor — EVERY detached gh poller ≥60s.** Waiter, watchdog,
    courtesy loop: no exceptions by mechanism.
  - **W2. `--wait` must fit the ~120s tool-runner ceiling (≤90s).** Longer
    waits = exit 5 + resume-by-run-id or a detached poller. The FIRST dispatch
    call carries an explicit ≥600s tool timeout; a mid-flight dead invocation
    (no exit code, no run URL) is recovered by API run-search and ADOPTED —
    never a blind re-dispatch.
  - **W3. Waiter legs verify invocations before launch.** Each leg of a
    detached chain checks its exact tool invocation against `--help`/tools.log
    ...
  ```
* **Analysis:** Rules W1 through W6 are structured constraints defining limits, tools, and error behaviors that are much faster to parse as a tabular contract.
* **Fix:** Convert W1–W6 into a concise table (`| Code | Rule Name | Constraint / Tool | Failure Mode / Handling |`).

---

### [MED] B-2.3: Toolsmith Standing Duties in Duty S1
* **File & Line:** `toolsmith.md:38-54`
* **Verbatim Quote:**
  ```markdown
  - **Cron liveness audit ownership:** the three law-carrying crons
    (harvest-patrol-daily, upstream-shift-watch, oc-waiter-sweep) plus any
    future law-carrying cron are TOOLSMITH's to keep alive — the lane audits
    cron health on its own cadence and repairs/re-arms a dead one with a
    ledger stamp. Triage's daily liveness patrol (Duty T4) is the check;
    this lane is the fixer.
  - **Rollback drills: RETIRED as scheduled duty (owner ruling 2026-09-08,
    "do we need rollback at all?" — v0.4.110).** Rollback readiness is
    verified on every ship instead: the swap journal + `/proc/<pid>/exe`
    identity check (v0.4.109) prove the deploy path live each cycle...
  ```
* **Analysis:** Standing duties mixed with retired duties in narrative prose.
* **Fix:** Tabulate into Active Standing Duties vs Retired Duties.

---

### [MED] B-2.4: Direct Dispatch 5 Rules
* **File & Line:** `fleet-directives.md:203-214`
* **Verbatim Quote:**
  ```markdown
  - **Rule 1 — Direct dispatch:** the sender of a work order notifies the lane that owns the resource directly. An intermediary may name the target, never carry the payload.
  - **Rule 2 — Address by receipt:** the target's full uuid comes from a same-turn roster/ledger read — never from memory or a remembered prefix. The v0.4.129 livecheck (session-DB full-id match) enforces this mechanically: dead/frankenstein ids refuse at send.
  - **Rule 3 — Ledger stays the record:** every direct dispatch stamps dispatch + delivery-receipt id via oc-ledger. No send exists that isn't on the ledger; DM history is not the record.
  - **Rule 4 — Triage re-roles to auditor:** Triage no longer relays work between lanes...
  - **Rule 5 — Escalation is direct too:** a dispatch unacked past its stated ack deadline is escalated by the sender straight to HQ. No third-lane relay.
  ```
* **Analysis:** Numbered rules formatted as repetitive paragraphs.
* **Fix:** Structure into a clean 5-row table: `| Rule | Principle | Mechanism / Enforcement |`.

---

## 3. Dead References & Duty Migrations Across Scope Lines

### [HIGH] B-3.1: Stale P1 Proposal Rejection in Hard Rules
* **File & Line:** `SKILL.md:500-505`
* **Verbatim Quote:**
  ```markdown
  - P1 REJECTED (owner verdict 2026-08-26 — "overengineering, don't do this"):
    NO evidence-parameter mechanism goes into `session_notify` — no mandatory
    evidence fields, no pattern-triggered enforcement, no tool change. The
    relay-predication rule above is the SOLE control for fabrication-class
    claims. Do not re-propose P1 in any form.
  ```
* **Analysis:** A rejected proposal from August 2026 (over 2 weeks stale) remains as a standing Hard Rule loaded by every role. A negative decision belongs in `CHANGELOG.md` or `war-stories.md`, not in active execution instructions.
* **Fix:** Remove the P1 REJECTED bullet from `SKILL.md §Hard rules`.

---

### [MED] B-3.2: Retired Compiler Runbook Speculation in `supervisor.md`
* **File & Line:** `supervisor.md:118-121`
* **Verbatim Quote:**
  ```markdown
  Inbox discipline for any (re-enabled) build lane: ORDERs / red-run handoffs /
  owner directives only; ACK bookkeeping stays ledger-internal. *(Historical:
  the compiler role was RETIRED 2026-08-28 — builds fire via `oc-deploy ship`;
  this paragraph is kept only as the runbook for any future re-enabled lane.)*
  ```
* **Analysis:** Preserving an inbox discipline paragraph in active supervisor instructions for a hypothetical re-enabled lane violates progressive disclosure.
* **Fix:** Move to `tools/archive/compiler.md`.

---

### [MED] B-3.3: Historical Migration Markers in Triage Section Headers
* **File & Line:** `triage.md:65` & `triage.md:89`
* **Verbatim Quote (`triage.md:65`):**
  ```markdown
  ## Duty T1 — Idea box intake (historical origin: ex supervisor.md Duty 7, first half — migrated v0.4.86; supervisor Duty 7 no longer carries numbered items)
  ```
* **Verbatim Quote (`triage.md:89`):**
  ```markdown
  ## Duty T2 — QUIRK intake + fix routing (historical origin: ex supervisor.md Duty 7, second half — migrated v0.4.86; supervisor Duty 7 no longer carries numbered items)
  ```
* **Analysis:** Section headers carry parenthetical migration history.
* **Fix:** Clean headers to `## Duty T1 — Idea box intake` and `## Duty T2 — QUIRK intake + fix routing`.

---

### [LOW] B-3.4: Stale Compiler Role Re-Enable Hooks in Router
* **File & Line:** `SKILL.md:8` & `SKILL.md:27-28` & `SKILL.md:116`
* **Verbatim Quote (`SKILL.md:27-28`):**
  ```markdown
  procedures live in FOUR role files (`editor.md` / `supervisor.md` / `triage.md` / `toolsmith.md`) + one
  ARCHIVED runbook (`tools/archive/compiler.md` — retired at S3 cutover 2026-08-28, re-enable
  = one notify);
  ```
* **Analysis:** Repeating `(Compiler: archived — say "re-enable compiler" to load tools/archive/compiler.md)` in router headers adds dead weight to every role initialization.
* **Fix:** Standardize role list to 4 active roles without inline re-enable commentary.

---

## 4. NO-OP Test (Default LLM Behavior / Zero Behavioral Change)

### [MED] B-4.1: General LLM Pre-training Boilerplate in `editor.md` Phase 3
* **File & Line:** `editor.md:329-332`
* **Verbatim Quote:**
  ```markdown
  - **Duplication check (DRY):** assume a helper already exists — find it before
    writing a new one. Reuse beats re-implement.
  - **Module size:** prefer extracting a NEW module over growing any file past
    ~1000 lines.
  ```
* **Analysis:** "Reuse beats re-implement" and "extract module instead of growing past 1000 lines" are standard pretrained coding behaviors. They do not enforce a measurable project-specific gate.
* **Fix:** Delete the generic DRY bullet; retain only specific tooling queries (`grep_code` / `grep_docs`).

---

### [MED] B-4.2: Abstract Convergence Axiom Repeated Across Files
* **File & Line:** `supervisor.md:144-145` & `triage.md:86-87`
* **Verbatim Quote (`supervisor.md:144-145`):**
  ```markdown
  5. Convergence beats volume: several workers burning independently on the same
     gap is stronger signal than any single proposal — merge them into one rule.
  ```
* **Verbatim Quote (`triage.md:86-87`):**
  ```markdown
  4. Overlap: an idea matching an open Duty-4 proposal MERGES into it
     (convergence beats volume); duplicate ideas stamp ONE event, not N.
  ```
* **Analysis:** "Convergence beats volume" is a cognitive guideline that produces no distinct verifiable gate beyond the concrete rule "duplicate ideas stamp ONE event, not N".
* **Fix:** State the concrete action only: "Duplicate ideas stamp ONE ledger event; merge matching proposals into a single rule."

---

### [MED] B-4.3: Supervisor Philosophical Rationale in `supervisor.md`
* **File & Line:** `supervisor.md:209-210`
* **Verbatim Quote:**
  ```markdown
  Rationale: the Supervisor authors most rules — author-blindness is structural.
  Independent subagent eyes + the owner gate keep the set honest.
  ```
* **Analysis:** Meta-philosophical rationale explaining why subagent reviews exist. Consumes tokens on every reload without directing model behavior.
* **Fix:** Move rationale to `review-lenses.md` or delete.

---

### [LOW] B-4.4: Redundant API Conclusion Warning in Hard Rules
* **File & Line:** `SKILL.md:576`
* **Verbatim Quote:**
  ```markdown
  - Never trust watcher exit codes alone — read the run's own `conclusion` via API.
  ```
* **Analysis:** This rule is already strictly codified in `SKILL.md §Glossary (GREEN / RED)`, `editor.md §CI-wait (item 4)`, and `tools/RC-CONTRACT.md`.
* **Fix:** Remove redundant one-liner from `SKILL.md §Hard rules`.

---

### [LOW] B-4.5: Redundant Narrative Description of `git fetch`
* **File & Line:** `editor.md:223-228`
* **Verbatim Quote:**
  ```markdown
  ```bash
  git -C ~/opencrabs fetch origin && git -C ~/opencrabs fetch adolfousier
  ```
  ```
* **Analysis:** The code block for Phase 0 is self-explanatory; additional prose asserting "branch off fresh origin/main" merely re-narrates the command.
* **Fix:** Keep code block, trim surrounding redundant sentences.

---

## 5. CACHE Test (Restating Environment Truth That Can Go Stale)

### [MED] B-5.1: Inlining Systemd Environment Facts in `SKILL.md`
* **File & Line:** `SKILL.md:364-370`
* **Verbatim Quote:**
  ```markdown
  - Live binary: `/usr/local/bin/opencrabs`. Daemons run as systemd **user** units
    (`systemctl --user`) — system-scope queries (`systemctl`, `/etc/systemd`) find nothing.
  - Daemon PID identity (v0.4.15): NEVER `pgrep | head -1` — three daemons share
    this box (family, default, ops) and pgrep can grab the wrong one. The ops unit's
    PID comes only from `systemctl --user show opencrabs-ops -p MainPID --value`.
  ```
* **Analysis:** Restates standard systemd user unit command line flags. If unit names or daemon topologies shift, this static cache drifts.
* **Fix:** State the unwritten convention only: "Target daemon is user unit `opencrabs-ops` (`systemctl --user`)." Leave query syntax to `--help`.

---

### [MED] B-5.2: Inlining Cargo Profile Flags in `SKILL.md`
* **File & Line:** `SKILL.md:371-375`
* **Verbatim Quote:**
  ```markdown
  - Builds are MINIMAL-FEATURE by design: `cargo build --locked --profile ci
    --no-default-features --features "<set>"` *(profile ci = thin LTO /
  codegen-units=16 — carrier yml since fork 8994be14)*. Upstream #1186 (missing #[cfg]
    gates) CLOSED 2026-08-25 — feature subsets compile clean.
  ```
* **Analysis:** `quick-build-linux.yml` is the sole source of truth for carrier compilation flags. Duplicating cargo flags and closed PR histories in `SKILL.md` creates a drift cache.
* **Fix:** State the convention: "Builds compile minimal features defined by carrier workflow."

---

### [LOW] B-5.3: Path and Argument Enumeration in Tool Reference
* **File & Line:** `editor.md:188-193`
* **Verbatim Quote:**
  ```markdown
  | `oc-issue-sweep` | `tools/oc-issue-sweep '<query>' [--fork R] [--upstream R] [--limit N]` | Phase 1 step 1 uniqueness gate (fork open+closed + upstream closed) |
  | `oc-commit` | `tools/oc-commit -m "<msg>" [--issue N] [--no-comment]` | gated SIGNED commit: Session-Id + Issue-Ref trailers derived from OC_ACTOR + ledger claim; implementation comment folded in (oc-issue-log leg) — Phase 6c step 2 default |
  ```
* **Analysis:** Full CLI flags are maintained canonically in `tools/RC-CONTRACT.md` and tool `--help` outputs.
* **Fix:** Keep tool tables strictly purpose-oriented (`Tool | Purpose | Phase`).

---

### [LOW] B-5.4: Duplicated Feature Set Default Instructions
* **File & Line:** `SKILL.md:376-384`
* **Verbatim Quote:**
  ```markdown
  - The feature set is PARAMETRIZED (`ebf44f69`, 2026-08-25): a workflow_dispatch
    input `features` (comma-separated). Its **`default:` in the workflow yml on the
    CARRIER branch `ci/quick-build-linux` is the SINGLE SOURCE OF TRUTH** for what we
    ship — these skill files NEVER copy the set (drift killed 2026-08-25).
  ```
* **Analysis:** Paragraph correctly identifies `ci/quick-build-linux` as the single source of truth, but spends 40 lines across `SKILL.md` explaining how `features` dispatch works.
* **Fix:** Compact into 2 lines.

---

## 6. NEGATION Test (Steering by Prohibition vs Positive Phrasing)

### [HIGH] B-6.1: Prohibition-Structured `NEVER` Lists in `triage.md` & `toolsmith.md`
* **File & Line:** `triage.md:26-36` & `toolsmith.md:21-33`
* **Verbatim Quote (`toolsmith.md:21-33`):**
  ```markdown
  ## NEVER list (hard boundaries)

  - NEVER edits skill files (SKILL.md / role files / fleet-directives.md /
    reference pages) — the single-writer law is UNCHANGED; a tooling GAP that
    needs skill text leaves this lane as an `IDEA:` intake item to the TRIAGE
    lane, never a direct edit.
  - NEVER edits daemon source (`~/opencrabs`), NEVER dispatches carrier builds,
    NEVER swaps binaries — daemon defects leave as `QUIRK:`/IDEA to the TRIAGE
    lane and ship through the normal editor flow if accepted.
  - NEVER issues binding rulings (supervisor.md Duty 5 stays at HQ); protocol
    disputes escalate, they don't settle here.
  - NEVER messages the owner directly with verdict tables — the Supervisor owns
    owner-facing verdict batches.
  ```
* **Analysis:** Entire sections are framed as prohibitions ("NEVER do X, NEVER do Y"). Steering by negation drags forbidden behaviors into the context window and makes them salient to the LLM.
* **Fix:** Reframe positively as strict operational scope:
  ```markdown
  ## Scope & Boundaries
  - **Toolsmith owns:** CLI tools in `tools/` and `tools/tests/run.sh`.
  - **Route to Triage:** Skill markdown improvements (`IDEA:`), daemon code bugs (`QUIRK:`).
  - **Route to HQ:** Protocol disputes, binding rulings, owner verdict tables.
  ```

---

### [MED] B-6.2: Negative Steering in Issue Claiming Rules
* **File & Line:** `SKILL.md:512` & `editor.md:248-251`
* **Verbatim Quote (`SKILL.md:512`):**
  ```markdown
  | Fork issues NEVER claimed on GitHub: no tackling comments, assignment, labels/reactions by any lane — claiming = `Issue-Ref` trailer + workers-ledger `claim` row (kind `claim`, v1.1 vocabulary since v0.4.48); uniqueness sweeps stay read-only search | ledger | owner 2026-08-27 17:07Z |
  ```
* **Analysis:** "NEVER claimed on GitHub: no tackling comments, assignment, labels/reactions" tells the model what *not* to do instead of stating the singular correct mechanism.
* **Fix:** State positively: "Claim fork issues exclusively via git `Issue-Ref: #N` trailer and ledger `claim` row; GitHub issues remain untouched."

---

### [MED] B-6.3: Staging Prohibitions in `editor.md` Phase 4
* **File & Line:** `editor.md:327-328`
* **Verbatim Quote:**
  ```markdown
  - Stage only paths YOU changed: `git add <paths>`. Never `git add -A`, never `commit -a`.
  - Never revert/reset/amend commits you did not write — report and wait, or branch off.
  ```
* **Analysis:** "Never git add -A, never commit -a" drags dangerous git shortcuts into attention.
* **Fix:** State positively: "Stage explicitly: `git add <explicit-file-paths>`. Preserve peers' commits intact; branch off or notify supervisor when encountering unowned changes."

---

### [LOW] B-6.4: Prohibitions in Issue Creation Table
* **File & Line:** `SKILL.md:510`
* **Verbatim Quote:**
  ```markdown
  | NEW issues NEVER upstream — every new issue (upstream-code bugs and fork-only infra alike) is filed on the FORK | `leshchenko1979/opencrabs` | owner 2026-08-27 14:08Z |
  ```
* **Fix:** Reframe positively: "File ALL new issues on the fork `leshchenko1979/opencrabs`; upstream receives PRs only."

---

## 7. ONE-TRIGGER-PER-BRANCH (Collapsing Synonym Branches in Context Pointers)

### [MED] B-7.1: Delivery Modes Pointer Redundancy
* **File & Line:** `SKILL.md:162-171`
* **Verbatim Quote:**
  ```markdown
  | Mode | Note |
  |---|---|
  | quiet (DEFAULT) / turn-end / now (EXCEPTION) / redirect / no-route | full table = fleet-directives.md §Cross-lane message delivery discipline (CANONICAL — this row is a failsafe pointer, lens B-F15 v0.4.96) |
  | failsafe | target mid-turn — `interrupt: true` ("#13 failsafe"): message QUEUES, drains at next boundary; escalation of a stuck quiet/turn-end delivery (~30 min, time-critical) |

  Escalation ladder canonical: fleet-directives.md §Cross-lane delivery
  (quiet → turn-end ~30 min if time-critical → interrupt last resort — lens A5
  v0.4.89: pointer only, no second copy).
  ```
* **Analysis:** Both the table row and the following paragraph act as pointers to `fleet-directives.md §Cross-lane delivery`, repeating synonym triggers and escalation summaries across three adjacent lines.
* **Fix:** Collapse to a single pointer: "Delivery modes (`quiet`, `turn-end`, `now`, `failsafe`) and escalation ladder: see `fleet-directives.md §Cross-lane message delivery discipline`."

---

### [MED] B-7.2: Divergent Reload Law Header Triggers Across 4 Role Files
* **File & Line:** `editor.md:6-12`, `supervisor.md:3-9`, `triage.md:3-8`, `toolsmith.md:3-8`
* **Verbatim Quote (`editor.md:6-12`):**
  ```markdown
  > **RELOAD LAW (v0.4.96, lens B-F2/G-5):** after ANY context compaction or
  > session spawn — not only at claim time (Phase 1 step 0) — re-read from disk,
  > IN FULL: `SKILL.md` + this file + `fleet-directives.md` (thematic index
  > minimum; every `[LANE]`-tagged section in FULL)...
  ```
* **Verbatim Quote (`supervisor.md:3-7`):**
  ```markdown
  **RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or
  spawn, re-read from disk: `SKILL.md` + `supervisor.md` + `fleet-directives.md`
  IN FULL (the supervisor OWNS the directives file and RULES on disputes citing
  it...
  ```
* **Analysis:** Each role file implements a slightly different flavor of the Reload Law with unique historical citations (v0.4.95 vs v0.4.96, varying parentheticals).
* **Fix:** Standardize the Reload Law trigger block to a single uniform snippet across all role files.

---

### [LOW] B-7.3: Multiple Redundant Pointers to `editor-upstream-pr.md`
* **File & Line:** `SKILL.md:514`, `editor.md:38-41`, `editor.md:387-391`
* **Verbatim Quote (`editor.md:38-41`):**
  ```markdown
  When a feature is COMPLETE
  (merged to fork `main`, shipped green, smoke test PASS — filing itself is
  AUTO-SHIP: law home SKILL.md §ISSUE ROUTING, PR SHIPMENT row), the Editor
  additionally
  owns its upstream contribution — Phase 7: harvest fork-only commits → upstream
  PR → close the tracked FORK issues (procedure: `editor-upstream-pr.md`).
  ```
* **Analysis:** The Phase 7 trigger is restated 3 times in `editor.md` alone.
* **Fix:** Retain single canonical pointer at `editor.md §Phase 7 + 7b`.

---

## Final Review Verdict & Prioritized Action Items

1. **Immediate Deletions (Zero Risk, High Yield):**
   - Delete archived tool row `./tools/archive/oc-post-receipts` from `SKILL.md:53`.
   - Purge `P1 REJECTED` block from `SKILL.md:500-505`.
   - Remove historical compiler runbook notes from `supervisor.md:118-121`.
2. **Table Conversions:**
   - Convert Triage Duty T4 patrols (`triage.md:104-171`) to a 6-row structured table.
   - Convert Supervisor W1–W6 waiter rules (`supervisor.md:308-325`) to a structured table.
3. **De-duplication & Positive Phrasing:**
   - Collapse `supervisor.md §Duty 2` registry write duplication into a 2-line pointer to `triage.md §Duty T6`.
   - Reframe `toolsmith.md` and `triage.md` `NEVER` lists into positive Scope & Routing blocks.
