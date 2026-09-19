I'll start by reading my brief.


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"# review-lenses.md — Duty-6 reviewer lens catalog (B4+G-F4 split, v0.4.78)\n\nFull briefs for the eleven Duty-6 review lenses (A–J + standing brain-scrub; regrouped v0.4.81 with C joining TOOLS and D sole in ARTIFACTS — H later joined D in ARTIFACTS, v0.4.113/115; the MECHANICAL family + Reviewer J added v0.4.161 on owner order). hq.md §Duty 6 owns the\nmethod (read-only sub-agents, verbatim-quote verification, oc-review-persist\npersistence, poll triple-check, verdict table) and keeps only the family map\nthere; this file owns the per-lens scope briefs (brain-scrub brief lives at review-lenses.md § Review lens brain-scrub). Letters keep chronological\nbirth order (stable report/persist keys, not an ordering). Reviewer-performance\nloop lessons (hq.md step 7) fold INTO these briefs at ship time,\nattributed to the reviewer that produced the evidence. Family identity is the\nOBJECT under review, not the evidence flow between lenses (regrouped v0.4.81:\nC joined TOOLS — gaps/shape/implementation pipeline; D is sole in ARTIFACTS,\nthe family IS the deletion owner gate). Membership and grouping change only\non census evidence + owner word (hq.md step 7).\n\n#### FAMILY: DOCS — role files (wording / reading load / organization)\n\n   - **Reviewer A — REDUNDANCY + ONTOLOGY:** same rule stated twice across\n     files; duplicated war stories; terms violating the SKILL.md test ontology\n     (SMOKE TEST / CODE TESTS / FEATURE-PRESENCE CHECK / EXECUTION SANITY\n     SIGNAL); undefined coinages; stale ref names (lens I-2.2\n     v0.4.116: A owns ref CONSISTENCY; B weighs refs only as load-weight —\n     first finder gets attribution); SEDIMENT — stale layers\n     that survive because adding feels safe and removing feels risky\n     (docs-lens vocabulary reference:\n     `skills/writing-for-agents/SKILL.md`). PLUS the churn-drift checklist, EVERY\n     lens-A pass: (a) ONE CONCEPT = ONE NAME — sweep for synonyms of the same\n     gate/tool/artifact; (b) GLOSSARY CONFORMANCE — every load-bearing term\n ","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"[SKILL GATE] This call touches '/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools' which matches skill 'opencrabs-dev' (globs: ~/opencrabs/**, ~/oc-wt-*/**, ~/.opencrabs/profiles/*/skills/opencrabs-dev/**, ~/.opencrabs/profiles/*/opencrabs-dev/**, ~/.opencrabs/profiles/*/projects/opencrabs-dev/**), not loaded in the current session context. The full skill body follows. Read it, then re-issue the identical call.\n\n---\n\n# opencrabs-dev — OpenCrabs source procedure\n\n**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the\ninstalled `opencrabs` binary. This file = shared facts + role router only. Actual\nprocedures live in FOUR role files (`editor.md` / `hq.md` / `triage.md` / `toolsmith.md`);\nload ONLY the one matching the session's role.\n\n**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo\nprohibition, telegram surface law, tool logging, gates, editor creation, tool-problem triage (Triage lane),\ncadence) live in `fleet-directives.md` — re-homed from ops AGENTS.md/MEMORY.md per\nowner order 2026-09-02. Load it before ANY opencrabs-dev work. Executing procedure for the sync\npolicy's rebase procedure: `upstream-merge-runbook.md` (freeze gate, roles, conflict\nclasses, migration-union rule, semantic-triage defaults).\n\n## STEP ZERO — establish the role (mandatory on every load)\n\nAsk the operator which role this session employs before doing anything:\n\n> **Editor, HQ, Triage, or Toolsmith?**\n\n| Role | Owns | Procedure file |\n|------|------|----------------|\n| **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE → upstream PR filed on smoke PASS (procedure `editor-upstream-pr.md` Phase 7) | `editor.md` |\n| **HQ** | Skill set maintenance, worker ledger, Duty 4 worker polls, Duty 6 periodic 11-lens reviews (details in `hq.md` and `review-lenses.md`) | `hq.md` |\n| **TRIAGE** | Intake & hygiene: issue ","s":false}] -->
<!-- reasoning -->
I need to find the Reviewer E entry. Let me grep the review-lenses.md for "Reviewer E".
<!-- /reasoning -->

Let me locate the Reviewer E brief specifically.


<!-- tools-v2: [{"d":"Grep 'Reviewer E' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:194:\n  191:      a lane is told to hold in context. One site, one lens; the two never both claim\n  192:      the same finding.\n  193: \n>    - **Reviewer E — INTERFACE/TOPOLOGY:** the TOOL SURFACE itself — pairs of\n  195:      tools whose invocations are bound to come one after another in practice\n  196:      (merge candidates), verbs that belong in one tool instead of two, a flag\n  197:      duplicating another tool's job, a ritual two tools cover in half each.\n\n(1 matches)","s":true}] -->

<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"     whose calls cluster on rc 2 is a broken interface), documented tools\n     never invoked in the window (YAGNI/deletion evidence for Reviewer D),\n     hand-built ritual artifacts that a proposal should replace. Findings\n     cite the log rows they rest on. ADOPTION-COMPLIANCE CHECK (v0.4.120,\n     owner-ordered): every C pass samples runtime `Detaching '...'` records\n     and flags ANY `gh run watch` / hand-rolled nohup CI poller spawn as a\n     law violation (one-watcher law, editor.md) — official surfaces are\n     native detached execution (`background: true`) and one-shot `gh run view`\n     (for a blocking gate, `oc-prchecks --wait`); also flags\n     `oc-prchecks --wait` used as a verdict waiter (double-duty). Each\n     violation names the session id from the log row. Boundary watch vs A/B: C's dimension is\n     GAPS (what should be a command), not doc wording or weight.\n     BOUNDARY vs J (v0.4.161): C's object is a PROCEDURE carrying a recurring\n     multi-step ritual; J's object is LAW TEXT carrying a single decision that is a\n     pure function of state on disk — including one-shot checks and any set or list\n     a lane is told to hold in context. One site, one lens; the two never both claim\n     the same finding.\n\n   - **Reviewer E — INTERFACE/TOPOLOGY:** the TOOL SURFACE itself — pairs of\n     tools whose invocations are bound to come one after another in practice\n     (merge candidates), verbs that belong in one tool instead of two, a flag\n     duplicating another tool's job, a ritual two tools cover in half each.\n     Lens A reviews duplicate RULES; E reviews duplicate/chainable INTERFACES.\n     Each finding names the merge/verb-move + its single-command shape.\n     EXCLUDES: one-off chains, anything with an approval gate between the\n     steps (a gate is human judgment — never merged away).\n     STANDING EXTRA (owner ruling 2026-09-09 18:55Z): E also reviews the\n     upstream-drift census surface (`oc-upstream-delta` patrol output) for\n     silent dri","s":true}] -->
<!-- reasoning -->
Now I understand my scope: Reviewer E — INTERFACE/TOPOLOGY: the TOOL SURFACE itself — merge candidates, verbs that belong in one tool instead of two, flags duplicating another tool's job, rituals covered in half by two tools. Excludes one-off chains, anything with an approval gate between steps. Plus STANDING EXTRA: review the upstream-drift census surface (oc-upstream-delta patrol output) for silent drift.

The object under review: tools/ surface as it is now (post-split 2026-09-19). Focus: tools that read law text or anchor on it may now read nothing after fleet-directives.md split.

Let me list the tools directory.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"     <DIR>  2026-09-18 13:51:46  __pycache__/\n     <DIR>  2026-09-15 03:40:05  archive/\n     <DIR>  2026-09-19 03:32:00  lib/\n     <DIR>  2026-09-19 04:06:42  tests/\n     11284  2026-09-15 19:33:19  HEALTH-CHECKS.md\n      9598  2026-09-15 19:33:27  HEALTH-CLASSES.md\n     68037  2026-09-18 21:25:12  RC-CONTRACT.md\n      8032  2026-09-01 13:44:27  oc-artifact-verify\n     10740  2026-09-17 00:07:03  oc-attrib\n     13593  2026-09-18 01:08:15  oc-branch-sweep\n      6027  2026-09-01 17:58:58  oc-carrier-features\n     10843  2026-09-18 09:50:03  oc-commit\n    201401  2026-09-17 00:07:03  oc-deploy\n     15907  2026-09-17 00:07:03  oc-drift-check\n     97758  2026-09-19 03:52:20  oc-harvest-census\n     87010  2026-09-19 03:30:10  oc-harvest-dispatch\n      6970  2026-09-17 16:10:21  oc-harvest-sweep\n     43422  2026-09-17 00:07:03  oc-health\n     64262  2026-09-18 13:44:59  oc-issue-dispatch\n      3492  2026-09-01 13:44:27  oc-issue-log\n      8151  2026-09-12 18:06:46  oc-issue-sweep\n      7147  2026-09-11 14:42:36  oc-job-verify\n    167288  2026-09-18 09:49:30  oc-ledger\n     15151  2026-09-15 12:15:09  oc-lint-laws\n      7375  2026-09-11 22:11:22  oc-log-search\n     70610  2026-09-17 07:35:46  oc-notify-fanout\n      5383  2026-09-17 00:07:03  oc-order-validate\n      4646  2026-09-17 00:07:03  oc-ping-proof\n      5875  2026-09-06 07:43:14  oc-pr-atomicity\n      4565  2026-09-01 14:32:36  oc-pr-fault-scope\n     70362  2026-09-18 09:20:35  oc-prchecks\n     12130  2026-09-12 12:08:24  oc-rebase-safety\n     19647  2026-09-12 13:18:08  oc-review-persist\n     12302  2026-09-14 10:50:55  oc-roster\n     13744  2026-09-17 00:07:03  oc-seal-state\n      2329  2026-09-17 00:07:03  oc-shadow-rotate\n     10271  2026-09-17 00:07:03  oc-ship-audit\n     98731  2026-09-18 10:49:11  oc-ship-chain\n      5947  2026-09-15 14:20:23  oc-skew-scan\n     13376  2026-09-17 18:19:58  oc-smoke\n     19393  2026-09-17 00:07:03  oc-smoke-evidence\n      8863  2026-09-17 00:07:44  oc-start\n      6450  2026-09-","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/lib","o":"     <DIR>  2026-09-19 03:32:08  __pycache__/\n       912  2026-09-01 04:41:10  oc-embed.sh\n      8076  2026-09-14 17:55:05  oc-log.sh\n      6514  2026-09-14 17:55:13  oc-notify.sh\n      5587  2026-09-11 15:11:41  oc-snap.sh\n     24427  2026-09-19 03:32:00  oc_claims.py\n","s":true}] -->
<!-- reasoning -->
The key defect pattern: tools that read law text or anchor on it may now read nothing after the fleet-directives.md split. Let me grep for "fleet-directives" across tools/.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'fleet-directives' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-rebase-safety:5:\n> # LAW (fleet-directives, v0.4.125): a rebase/merge onto a shifted main may skip\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:476:\n> # lane sloppiness (fleet-directives.md §Attribution & Goal Hygiene A1, owner\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:1007:\n>   # places (hq.md Duty 4, editor.md, fleet-directives.md routing table,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:2260:\n>   # triage.md, fleet-directives.md §Work orders) as THE dynamic way to resolve\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:30:\n> #   headings in fleet-directives.md. Hardcoding A-J + brain-scrub here would be\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:71:\n>   LENSES_MD=\"$ROOT/review-lenses.md\"; FD_MD=\"$ROOT/fleet-directives.md\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:193:\n>   printf '# fd\\n## Review lens `brain-scrub` (owner order)\\nbody\\n' > \"$CR/fleet-directives.md\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-smoke-evidence:39:\n> #   lane-authored by hand. LATE ENTRY is sanctioned (fleet-directives.md); this\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws:70:\n> DEFAULT_CORPUS=\"SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-notify-fanout:14:\n> #   2. RELOAD line per fleet-directives.md (L158 law) + explicit ack contract\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md:41:\n> | oc-notify-fanout | 0 | 2 | **wave receipt attribution (#19, 2026-09-12):** the `notify-fanout` ledger row now passes an explicit `--by \"${OC_ACTOR:-oc-notify-fanout}\"`, because `oc-ledger stamp` refuses an anonymo","s":true}] -->
<!-- reasoning -->
Key candidates:

1. `oc-review-persist:71` — known defect, do not report. But `oc-review-persist:30` also mentions fleet-directives.md headings. Let me check that — the comment says "headings in fleet-directives.md. Hardcoding A-J + brain-scrub here would be...". That's a comment though.

2. `oc-lint-laws:70` — DEFAULT_CORPUS includes fleet-directives.md. If the split moved 25 sections out, the corpus still lists fleet-directives.md (still exists, just smaller) — but does it now MISS the role/topic files that received the moved sections? Actually the corpus includes editor.md, hq.md, triage.md, toolsmith.md, review-lenses.md etc. Hmm, the split moved 25 sections OUT of fleet-directives.md into "role/topic files". If new topic files were created (e.g., war-stories.md, or others), and DEFAULT_CORPUS wasn't updated, lint-laws would not lint them. Let me check.

3. `oc-ship-chain` — anchors on fleet-directives.md §Pure-docs LEG1 skip law, and possibly reads the file.

4. `oc-ledger:1007, 2260` — comments referencing fleet-directives.md.

Let me check which files actually READ fleet-directives.md as data (not just comments). Let me grep for reading patterns. Also check whether new topic files exist post-split. Let me list the skill dir.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/","o":"     <DIR>  2026-09-19 04:09:35  reviews/\n     <DIR>  2026-09-18 20:33:34  run/\n     <DIR>  2026-09-19 03:52:20  tools/\n    278084  2026-09-18 20:01:51  CHANGELOG.md\n      5494  2026-09-19 03:38:59  README.md\n     46882  2026-09-19 03:33:57  SKILL.md\n     31523  2026-09-19 02:04:11  editor-upstream-pr.md\n     52141  2026-09-19 03:38:51  editor.md\n     73666  2026-09-19 03:38:15  fleet-directives.md\n     25990  2026-09-19 02:04:11  hq.md\n     21338  2026-09-19 02:04:11  review-lenses.md\n      6810  2026-09-19 00:57:11  s2-swap-journal-spec.md\n     12771  2026-09-19 00:52:54  toolsmith.md\n     28997  2026-09-19 02:04:11  triage.md\n     47129  2026-09-19 00:54:19  upstream-merge-runbook.md\n     15578  2026-09-11 11:46:36  war-stories.md\n","s":true},{"d":"Grep 'FD_MD|fleet_directives|fleet-directives\\.md' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"No matches found for pattern: 'FD_MD|fleet_directives|fleet-directives\\.md'","s":true}] -->
<!-- reasoning -->
Wait, grep found no matches for `fleet-directives\.md`? But the earlier grep with literal "fleet-directives" found matches including `oc-review-persist:71`. Hmm, the regex might have issues with the alternation or escaping. Actually the pattern `fleet-directives\.md` — maybe the tool treats `\.` oddly. Let me retry with regex=true.

Also note: fleet-directives.md still exists (73666 bytes) after the split. So the split moved 25 sections out but the file remains. So tools reading fleet-directives.md for specific sections may find them gone.

Let me re-grep with regex enabled.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'fleet-directives\\.md' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:476:\n  472: \n  473: # ---- actor defaulting (v0.4.152 §Attribution & Goal Hygiene A1) ------------\n  474: # A tool that ALREADY KNOWS the owning session MUST default the actor to it —\n  475: # an `(unattributed — pass --by or export OC_ACTOR)` row is a TOOL defect, not\n> # lane sloppiness (fleet-directives.md §Attribution & Goal Hygiene A1, owner\n  477: # order 2026-09-12).\n  478: # This chain is handed the commit it is shipping (--sha), and every editor\n  479: # commit carries a `Session-Id: <full-uuid>` trailer (SKILL.md §Session-notify\n  480: # loop) — so the owning session is ON DISK, inside a sha the chain already\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:1007:\n  1003:   bash \"$ME\" stamp note \"\" >/dev/null 2>&1; chk \"empty-what\" 2 $?\n  1004:   bash \"$ME\" stamp skill-bump \"x\" >/dev/null 2>&1; chk \"skill-bump-refused\" 2 $?\n  1005:   bash \"$ME\" stamp claim \"CLAIM #1234 — v1.1 kind\" >/dev/null 2>&1; chk \"stamp-claim-v1.1\" 0 $?\n  1006:   # Duty-4 `proposal` (v0.4.152 A1): the law mandates `stamp proposal` in four\n>   # places (hq.md Duty 4, editor.md, fleet-directives.md routing table,\n  1008:   # CHANGELOG v0.4.144) but the kind was absent from KINDS, so the verb died\n  1009:   # rc 2 and the channel had NEVER accepted a row (0 of 3558 events, 2026-09-12).\n  1010:   # A law that names a verb the tool refuses is a dead channel, not a lane error.\n  1011:   bash \"$ME\" stamp proposal \"Duty-4 proposal (fixture)\" >/dev/null 2>&1; chk \"stamp-proposal\" 0 $?\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:2260:\n  2256: # ---- roster (read-only; defect fix 2026-09-11, lane d18ce16a) -----------------\n  2257: cmd_roster() { # oc-ledger roster [--role <substr>] [--live] [--json]\n  2258:   # role -> FULL uuid resolution — the backend the skill already promised.\n  2259:   # The skill cites `oc-ledger roster` in THREE role files (editor.md,\n>   # triage.md, fleet-d","s":true}] -->
<!-- reasoning -->
Now let me focus. My lens is E: interface/topology of the tool surface, with the split-context hint that tools reading law text may now read nothing. So I should find tools that read law text at runtime (not just comments) and anchor on sections that moved.

Candidates that actually READ law files:
- oc-review-persist:71 — LENSES_MD and FD_MD. Known defect (zero standing lenses). Do not report. But there may be a SECOND aspect: the comment at :28-30 says standing lenses derived from `## Review lens <name>` headings in fleet-directives.md. Post-split, the brain-scrub brief moved to review-lenses.md (§ Review lens brain-scrub). Wait — the review-lenses.md I read contains "#### Review lens `brain-scrub`". So post-split, the standing lens heading lives in review-lenses.md, not fleet-directives.md. That IS the known defect (zero standing lenses). Skip.

- oc-lint-laws:70 — DEFAULT_CORPUS. Post-split, 25 sections moved out of fleet-directives.md into role/topic files. The corpus lists fleet-directives.md and role files, but are there NEW topic files created by the split that the corpus misses? Looking at the dir listing: files are SKILL.md, editor-upstream-pr.md, editor.md, fleet-directives.md, hq.md, review-lenses.md, s2-swap-journal-spec.md, toolsmith.md, triage.md, upstream-merge-runbook.md, war-stories.md, README.md, CHANGELOG.md, tools/RC-CONTRACT.md. DEFAULT_CORPUS includes: SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md. It excludes war-stories.md (deliberate) and CHANGELOG.md (deliberate). README.md is not a law file. So the corpus seems complete. Hmm. But wait — the split moved 25 sections "into the role/topic files". If a NEW topic file was created (e.g. something not in this listing), the corpus would miss it. The listing shows no obviously new file. Let me check git or the CHANGELOG for what the split created. Actually, let me check the README or SKILL.md for the file list.

Actually, my lens is INTERFACE/TOPOLOGY, not tool code review (that's F). But the brief hint explicitly directs me to find tools that read law text and now read nothing. That's arguably within E's "tool surface" scope... Actually the hint is the mission. Let me be pragmatic: find defects in the tool surface caused by the split.

Let me search for tools that read law files at runtime. Grep for patterns like `grep` on law files, `SKILL.md`, `editor.md`, `hq.md` inside tools.

Let me grep tools for references to law files being read.

Better: grep for lines with the law file names in a reading context. Let me grep for "hq.md" and "editor.md" and "SKILL.md" and "fleet-directives" in tools.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '(SKILL|editor|hq|triage|toolsmith|review-lenses|upstream-merge-runbook|s2-swap-journal-spec|war-stories|fleet-directives)\\.md' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-harvest-census:552:\n> # v0.4.201, triage.md \"Closure predicate for fork-only base-fault fixes\") makes\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-harvest-census:970:\n>     # triage.md \"Closure predicate for fork-only base-fault fixes\"). The old\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-seal-state:180:\n>       # the single source of truth (SKILL.md:53); resolve via oc-carrier-features,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:476:\n> # lane sloppiness (fleet-directives.md §Attribution & Goal Hygiene A1, owner\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:479:\n> # commit carries a `Session-Id: <full-uuid>` trailer (SKILL.md §Session-notify\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:893:\n>   # the same trailer every editor commit carries (SKILL.md §Session-notify\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:63:\n> #   check-version                          SKILL.md vs 3 ledger fields (RO)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:488:\n>   # SKILL.md must already carry the version (tool never writes it first)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:489:\n>   grep -Eq \"^version: $v\\$\" \"$SKILL_DIR/SKILL.md\" \\\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:490:\n>     || die 6 \"sync: SKILL.md frontmatter does not say version: $v — bump the doc first\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:564:\n>   # Exempt: the version docs (SKILL.md, CHANGELOG.md) and the battery receipt,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:587:\n>       # porcelain emits a ONE-char status for a worktree modification (\" M SKILL.md\"),\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:588:\n>       # so the exempt list was INERT - SKILL.md/CHANGELOG.md were rep","s":true}] -->
<!-- reasoning -->
The output is huge. Let me be targeted. I need tools that READ law text at runtime and anchor on content that moved. Let me look at the specific tools:

1. `oc-lint-laws` — DEFAULT_CORPUS. Does the split create a new file not in the corpus? Let me check what the split did. Let me search for "SPLIT" in CHANGELOG or README.

2. `oc-review-persist` — known.

3. `oc-drift-check` — the RELOAD line, drift-check reads law? It's about version drift.

Let me look at README.md (5494 bytes, modified 2026-09-19 03:38) — it might list the file structure post-split.

Also, let me check the "war-stories.md" — the skill's SKILL.md body mentions war-stories.md. And fleet-directives.md split moved 25 sections into "role/topic files". Which topic files? Possibly new files. Let me check git status/log for the skill dir. But I'm read-only, and I have no shell tool. Hmm, actually the capability note says shell execution tools are absent. Let me check if bash is available... The tool list includes only read tools. So no shell.

Let me read README.md and the CHANGELOG tail for the split.

Actually, let me focus on the mission: "any tool that reads law text or anchors on it may now read nothing."

Let me grep for tools that grep/read law files at runtime. Look for lines with `grep` and a `.md` law file, or `SKILL_DIR`.

Let me grep specifically for `SKILL_DIR` and for reading of law files.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md","o":"# opencrabs-dev\n\nOperational skill for **OpenCrabs source work** on `~/opencrabs`: the fork\n(`leshchenko1979/opencrabs`), upstream contact (`adolfousier/opencrabs`, PRs only),\nCI carrier lanes, artifact builds, and binary swaps to `/usr/local/bin/opencrabs`.\n\nSkill entry point: `SKILL.md` — invoked as `/opencrabs-dev`.\nThis README is the repo map; **SKILL.md is the law.** Where they disagree, SKILL.md wins.\n\n## Layout\n\n| Path | What it is |\n|---|---|\n| `SKILL.md` | Main entry: roles, hard rules, tool register, ship path, glossary |\n| `editor.md` | EDITOR role procedure — Phases 0–7b (issue claim → worktree → edit → gate → commit → ship → upstream PR) |\n| `editor-upstream-pr.md` | Harvest & upstream PR filing procedure (Phase 7b/7c) |\n| `hq.md` | HQ role — worker roster, duty cadence, CI-wait & waiter discipline, review lenses |\n| `review-lenses.md` | Full Duty-6 lens briefs (A–J) — split from hq.md v0.4.78 |\n| `war-stories.md` | Incident histories behind the hard rules (disclosed from SKILL.md, v0.4.80) |\n| `fleet-directives.md` | Binding owner directives that apply to EVERY lane — the `[LANE]` cross-role law + a residual of cross-cutting rulings, with a pointer table to the role/topic file that owns scoped law. Re-homed from ops AGENTS.md/MEMORY.md, 2026-09-02; split 2026-09-18 |\n| `upstream-merge-runbook.md` | Procedure for the REBASE sync model: gates, roles, conflict classes, migration-union rule |\n| `s2-swap-journal-spec.md` | Journal vocabulary spec for the oc-deploy swap leg |\n| `CHANGELOG.md` | Version history, **newest entry FIRST** |\n| `tools/` | The `oc-*` tool fleet |\n| `tools/lib/` | Shared shell libs: `oc-log.sh` (journal + rc register + flood guard), `oc-embed.sh` (job-embed decoder) |\n| `tools/RC-CONTRACT.md` | SOLE per-tool rc register: fleet conventions + verdict codes (v0.4.78) |\n| `tools/HEALTH-CHECKS.md` | Systematic health checks registry for the tool fleet |\n| `tools/HEALTH-CLASSES.md` | Health classification taxonomy and remediations |\n| `too","s":true},{"d":"Grep 'DEFAULT_CORPUS|CORPUS|corpus' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws","o":"No matches found for pattern: 'DEFAULT_CORPUS|CORPUS|corpus'","s":true}] -->
<!-- reasoning -->
The grep with `|` didn't match — seems regex needs regex=true. Fine.

Note README says fleet-directives.md "split 2026-09-18". Now, which topic files received the 25 sections? README's layout table doesn't list any new file beyond the ones already there. Hmm, but README was modified 2026-09-19 03:38 — after the split. So README already reflects the post-split state, and there is no new file listed. So the 25 sections went into existing role/topic files: editor.md, hq.md, triage.md, toolsmith.md, review-lenses.md, upstream-merge-runbook.md, etc.

So the key question: which tools read a specific law section that MOVED out of fleet-directives.md into a role file, and now read nothing (or the wrong file)?

oc-review-persist is one (known). Let's find others.

Let me look at oc-lint-laws corpus: DEFAULT_CORPUS = "SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md". That's 11 files. RC-CONTRACT says "Corpus = the 11 normative markdown files". Hmm — but wait, the split moved sections into topic files. If a new topic file exists it'd be missed. README doesn't list one. But maybe the split created files not in README. Let me list all .md in the skill dir recursively... Actually the ls showed the dir contents; only those .md files exist at root. So the corpus is complete for law files. Unless "war-stories.md" became law-bearing. No.

Hmm, but wait: the split moved 25 sections OUT of fleet-directives.md into role/topic files. Note the corpus is fine.

Now, the interesting angle for Lens E (interface/topology): tools whose invocations chain. But the mission hint is about law-reading. Let me examine oc-drift-check, which the RELOAD law uses.

Let me look at the tools that actually READ law text at runtime. Let me grep for `grep` inside tools referencing .md law files, or `SKILL_DIR`.

Let me grep for "SKILL_DIR=" definitions and usages reading .md.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'SKILL_DIR' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/tests/negctl-307-mutation-guard.sh:29:\n  25: [ \"${OC_REPRO_DEPTH:-0}\" -ge 1 ] && exit 99\n  26: export OC_REPRO_DEPTH=1\n  27: ulimit -u $(( $(ps -e --no-headers | wc -l) + 200 )) 2>/dev/null || true\n  28: \n> SKILL_DIR=\"/root/.opencrabs/profiles/ops/skills/opencrabs-dev\"\n  30: SRC=\"$SKILL_DIR/tools\"\n  31: export OC_TOOLS_NOLOG=1\n  32: \n  33: WORK=\"$(mktemp -d)\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/tests/negctl-307-mutation-guard.sh:30:\n  26: export OC_REPRO_DEPTH=1\n  27: ulimit -u $(( $(ps -e --no-headers | wc -l) + 200 )) 2>/dev/null || true\n  28: \n  29: SKILL_DIR=\"/root/.opencrabs/profiles/ops/skills/opencrabs-dev\"\n> SRC=\"$SKILL_DIR/tools\"\n  31: export OC_TOOLS_NOLOG=1\n  32: \n  33: WORK=\"$(mktemp -d)\"\n  34: cleanup() { rm -rf \"$WORK\"; }\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/tests/negctl-307-anchored-fence.sh:13:\n  9: [ \"${OC_REPRO_DEPTH:-0}\" -ge 1 ] && exit 99\n  10: export OC_REPRO_DEPTH=1\n  11: ulimit -u $(( $(ps -e --no-headers | wc -l) + 200 )) 2>/dev/null || true\n  12: \n> SKILL_DIR=\"/root/.opencrabs/profiles/ops/skills/opencrabs-dev\"\n  14: TOOLS=\"$SKILL_DIR/tools\"\n  15: REPO=\"/root/opencrabs\"\n  16: ISSUE=297\n  17: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/tests/negctl-307-anchored-fence.sh:14:\n  10: export OC_REPRO_DEPTH=1\n  11: ulimit -u $(( $(ps -e --no-headers | wc -l) + 200 )) 2>/dev/null || true\n  12: \n  13: SKILL_DIR=\"/root/.opencrabs/profiles/ops/skills/opencrabs-dev\"\n> TOOLS=\"$SKILL_DIR/tools\"\n  15: REPO=\"/root/opencrabs\"\n  16: ISSUE=297\n  17: \n  18: export OC_TOOLS_DIR=\"$TOOLS\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-health:36:\n  32: STATE=\"${OC_HEALTH_STATE:-$HOME/.opencrabs/profiles/$PROFILE/opencrabs-dev}\"\n  33: FORK=\"${OC_HEALTH_FORK:-$HOME/opencrabs}\"\n  34: DB=\"${OC_HEALTH_DB:-$HOME/.opencrabs/profiles/$PROFILE/opencrabs.db}\"\n  35: TMP_GLOB=\"${OC_HEALTH_TMP_GLOB:-/tmp/oc-*}\"\n> SKILL_CHECK=\"${OC_HEALTH_SKILL_DIR:-$(","s":true}] -->
<!-- reasoning -->
I'm getting a lot of noise. Let me be strategic. My lens E is about interface/topology. The mission: find tools that read law text or anchor on it and now read nothing post-split.

Let me directly examine the tools most likely to read law text:
- oc-review-persist (known, skip)
- oc-lint-laws (corpus)
- oc-drift-check
- oc-harvest-census/dispatch (reference triage.md sections)
- oc-notify-fanout (LLM Ergonomics §2 in fleet-directives)

Let me check oc-notify-fanout: it references "per fleet-directives LLM Ergonomics §2". Does it READ fleet-directives.md to get the flag list? The RC-CONTRACT says "unrecognized flags output the complete valid candidate flag list on stderr with rc=2 per fleet-directives LLM Ergonomics §2". That's a reference, probably not a read.

Let me instead grep for actual file-read patterns on law files: e.g., `cat "$ROOT/...`, `grep ... "$SKILL_DIR/fleet-directives.md"`. Search for the string "fleet-directives.md" appears in oc-lint-laws (corpus) and oc-review-persist (FD_MD). Also comments elsewhere.

Search for other law files being read: "review-lenses.md" read by oc-review-persist. Let me grep for law filenames in a read context. Let me grep for `"$ROOT` or `$SKILL_DIR/` combined with .md.

Actually let me grep for `\.md` occurrences with `$` variables. Let me just grep for "\.md" in tools and filter.

Hmm, huge. Let me instead look at the specific known-relevant tool: oc-lint-laws. Post-split, does the corpus need updating? The split moved 25 sections out of fleet-directives.md into role/topic files. The corpus already includes the role files. But what about a NEW topic file created by the split? README lists no new file. But wait — the split's target "role/topic files". Perhaps the split created files like `attribution.md`? No, README is current.

Hmm, but actually — maybe the split created files that README doesn't list. Let me list all files recursively in the skill root (non-hidden) to confirm.

Actually ls already showed the root. No new topic files. So the split moved content into the existing role files.

So for oc-lint-laws, the corpus is unchanged and complete. Not a defect... unless the split created a file that IS law-bearing but excluded. Let me check: is there any .md under the skill dir not in the corpus? Files at root: CHANGELOG.md (excluded by design), README.md (not law), war-stories.md (excluded by design), and the 11 corpus files. Under tools/: RC-CONTRACT.md (in corpus), HEALTH-CHECKS.md, HEALTH-CLASSES.md (not in corpus). Hmm — HEALTH-CHECKS.md and HEALTH-CLASSES.md are catalogs referenced by oc-health. Are they law? They're registry docs. Not in corpus. Probably fine.

OK, let me pivot. The mission says "any tool that reads law text or anchors on it may now read nothing". Let me search for tools that grep law files for content. Search for `grep` lines mentioning `.md`.

Let me grep for `grep .*\.md` regex.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '(grep|awk|sed|cat|read).{0,60}\\.md' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:212:\n  207:   # only call site is a command substitution (already a subshell), but a cwd\n  208:   # leak out of a path-resolver is the kind of bug that surfaces a hundred lines\n  209:   # later in an unrelated `git` call.\n  210:   (\n  211:     cd \"$FORK_REPO\" 2>/dev/null || exit 0\n>     grep -rloE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' src --include=*.rs 2>/dev/null \\\n  213:       | while IFS= read -r rs; do\n  214:           grep -oE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' \"$rs\" 2>/dev/null \\\n  215:             | sed -E 's/.*\"([^\"]+\\.md)\".*/\\1/' \\\n  216:             | while IFS= read -r rel; do\n  217:                 realpath -m --relative-to=. \"$(dirname \"$rs\")/$rel\" 2>/dev/null || true\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:214:\n  209:   # later in an unrelated `git` call.\n  210:   (\n  211:     cd \"$FORK_REPO\" 2>/dev/null || exit 0\n  212:     grep -rloE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' src --include=*.rs 2>/dev/null \\\n  213:       | while IFS= read -r rs; do\n>           grep -oE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' \"$rs\" 2>/dev/null \\\n  215:             | sed -E 's/.*\"([^\"]+\\.md)\".*/\\1/' \\\n  216:             | while IFS= read -r rel; do\n  217:                 realpath -m --relative-to=. \"$(dirname \"$rs\")/$rel\" 2>/dev/null || true\n  218:               done\n  219:         done | sort -u\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:215:\n  210:   (\n  211:     cd \"$FORK_REPO\" 2>/dev/null || exit 0\n  212:     grep -rloE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' src --include=*.rs 2>/dev/null \\\n  213:       | while IFS= read -r rs; do\n  214:           grep -oE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' \"$rs\" 2>/dev/null \\\n>             | sed -E 's/.*\"([^\"]+\\.md)\".*/\\1/' \\\n  216:             | while IFS= read -r rel; do\n  217:                 realpath -m --relative-to=. \"$(dirname \"$rs\")/$r","s":true}] -->
<!-- reasoning -->
These greps produce too much. Let me be surgical and read specific candidate files.

Key candidates:
1. oc-review-persist (known defect at :71) — but check whether there's an ADDITIONAL aspect not covered by the dispatched defect. The dispatched defect: "derives ZERO standing lenses". The comment at :28-30 says standing lenses derived from `## Review lens <name>` headings in fleet-directives.md. Post-split, brain-scrub brief lives in review-lenses.md. So FD_MD reads fleet-directives.md and finds no standing lens headings → zero. That's the known one. Skip.

But hold on — is there ANOTHER tool that reads review-lenses.md for the reviewer letters? oc-review-persist derives reviewer letters from review-lenses.md. That still works. OK.

2. oc-lint-laws DEFAULT_CORPUS — check whether the split created a law file not in the corpus. Need to determine the split's output files. Let me check the CHANGELOG for the split entry (v0.4.x, 2026-09-18). Let me grep CHANGELOG for "split".

3. oc-harvest-census/dispatch reference triage.md sections — "Closure predicate for fork-only base-fault fixes". Is that section in triage.md now? They're comments, not reads.

Let me think about which tools READ law text at runtime (not comments):
- oc-ledger:489 `grep -Eq "^version: $v\$" "$SKILL_DIR/SKILL.md"` — reads SKILL.md frontmatter. Still valid.
- oc-lint-laws: reads corpus files.
- oc-review-persist: reads review-lenses.md and fleet-directives.md.
- oc-drift-check: reads SKILL.md version? Let me check.
- oc-notify-fanout: reads? It appends RELOAD line. Does it read law? Probably reads version from SKILL.md.
- oc-tg-audit: reads?
- oc-harvest-census/dispatch: reference law sections in comments.
- oc-ship-chain: `--eval-docs-skip` per fleet-directives.md Pure-docs LEG1 skip law. Does it READ fleet-directives.md? The comment says "per fleet-directives.md Pure-docs LEG1 skip law (v0.4.161)". If the split moved the Pure-docs LEG1 skip law OUT of fleet-directives.md, then the anchor is stale. Let me check whether fleet-directives.md still contains "Pure-docs".

Let me grep fleet-directives.md and other files for section names that tools anchor on:
- "Pure-docs LEG1 skip" (oc-ship-chain, oc-prchecks?)
- "LLM Ergonomics" (oc-notify-fanout, other tools)
- "Attribution & Goal Hygiene" (oc-ship-chain)
- "Work orders" (oc-ledger)
- "brain-scrub" (oc-review-persist)

The mission says "25 sections moved out of it into the role/topic files". So let me find which sections moved. Let me grep fleet-directives.md for its section headings now, and compare with what tools reference.

Let me read fleet-directives.md headings.
<!-- /reasoning -->

Let me look at the actual law file's structure post-split and what tools anchor on.


<!-- tools-v2: [{"d":"Grep '^#{1,4} ' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:1:\n> # Fleet directives — opencrabs-dev cross-role law\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:32:\n> ## Owner Push Freeze — soaking groups held from upstream harvest (owner order 2026-09-18) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:53:\n> ## Telegram surface law (owner 2026-08-28, skill v0.4.31) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:57:\n> ## Discussion links + fix-approval gate (owner 2026-08-28 14:28Z)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:64:\n> ## External lanes — fork issue reporting vs dev non-participation (owner order 2026-09-13) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:82:\n> ## Stage-entry consent (owner 2026-08-28 16:57Z)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:86:\n> ## Post-compaction skill reload & context manifest curation (owner 2026-09-04, updated 2026-09-17) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:97:\n> ## Receiver-side dedupe of reload demands (HQ ruling 2026-09-10, anomaly: duplicate v0.4.130 fanout wave)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:101:\n> ## Attribution guard (post-compaction wakes)\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:105:\n> ## PR naming convention (owner 2026-08-30) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:112:\n> ## Strict Atomicity & Zero Bundling (owner order 2026-09-13; lane 1a63f103 proposal) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:119:\n> ## LLM Ergonomics & Efficiency Law (owner order 2026-09-13) [LANE]\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:128:\n> ## Upstream Coding & Testing Standards (CONTRIBUTING.md & Adolfo DM 2026-09-13) [LANE]\n\n/roo","s":true},{"d":"Grep 'Pure-docs|LLM Ergonomics|Attribution & Goal Hygiene' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:495:\n> - **LLM Ergonomics & Efficiency Law (`fleet-directives.md`):**\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:846:\n> - **§Attribution & Goal Hygiene (`fleet-directives.md`)** — A1: every `oc-*` call exports `OC_ACTOR`; a tool that ALREADY knows the owning session (`oc-ship-chain` inside a chain) MUST default the actor to it rather than emit `(unattributed …)` — an unattributed row is a TOOL defect, dispatched to Toolsmith (34 such rows on 2026-09-12). Stamp as your ROSTER ROLE (a factory label trips `unrostered-actor`). A2: a shift-length `/goal` must carry a turn budget covering the shift, and its death MUST notify — goal `eefd9a20` expired at turn 20 (03:18Z) and the shift ran ~4.5 h more with no judge while reports still described the clock as running.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md:18:\n> \",\"s\":true},{\"d\":\"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md\",\"o\":\"## Docs-Only LEG1 Gate Skip (v0.4.161, owner ruling 2026-09-12 11:04Z) [LANE]\\n\\n**Owner ruling (verbatim, 2026-09-12 11:04Z):** *\\\"We don't need the pure docs commits to pass through ci on our side.\\\"* Origin: lane `6630dc9a`'s docs commit `eee36027` (ONTOLOGY.md + CONTRIBUTING.md, zero code) burned LEG1 run `34688939568` in full before the ruling landed.\\n\\n- **The law.** A commit whose changed paths are ALL **pure docs** SKIPS the LEG1 CI gate on the fork ship chain. A skip is neither PASS nor RED — it is a **SKIP**, and it MUST be recorded as one (see §Recording).\\n- **\\\"Pure docs\\\" is DEFINED HERE, in the law — never left to a tool's discretion.** A commit is pure docs iff **every** changed path (a) ends in `.md`, **and** (b) is **NOT compiled into the binary** via `include_str!` / `include_bytes!`. Clause (b) is load-bearing: a `.md` compiled into the binary changes COMPILED OUTPUT, so a commit touch","s":true}] -->
<!-- reasoning -->
Interesting! fleet-directives.md still has "## Docs-Only LEG1 Gate Skip (v0.4.161...)" — so the Pure-docs law still lives there. And "## LLM Ergonomics & Efficiency Law" and "## Attribution & Goal Hygiene" still there. So those anchors are fine.

Note: the split is described as 25 sections moved out. The current fleet-directives.md has ~52 sections? Hmm, the grep showed 52 matches of `^#{1,4} ` in fleet-directives.md — wait, no, the first grep result block was for fleet-directives.md with limit 120, and it listed 52 matches? Actually it listed up to line 465. Then the second grep (Pure-docs|LLM Ergonomics|Attribution & Goal Hygiene) returned 16 matches across the skill dir.

Hmm wait, actually re-reading: the first result block header says path fleet-directives.md and shows headings up to line 465. That's the current post-split state. So fleet-directives.md still has many sections. But 25 moved out.

Key: which sections moved OUT that tools anchor on? The oc-review-persist case: `## Review lens brain-scrub` moved out (to review-lenses.md). Are there other "## Review lens" headings that moved? Let me check what other tools anchor on headings that no longer exist.

Let me now directly check each tool that reads law files. Let me identify tools that read law at runtime by grepping for `.md"` in read contexts like `grep`, `cat`, `awk`, `<`, `read`.

Actually let me reconsider: the mission says "any tool that reads law text or anchors on it may now read nothing." The reviewer's job (Lens E) is interface/topology. But the mission is specific. The known defect is oc-review-persist:71. Find the others.

Let me look at oc-review-persist in full to understand its law-reading and check for a SECOND independent defect there (e.g., it also reads the FD for something else). But the dispatched defect covers "derives ZERO standing lenses". Let me read the file to see whether there's a distinct second defect.

Also let me check oc-lint-laws: does it verify the corpus files exist and die if missing? Post-split, all corpus files exist. So no.

Let me check other tools that read law: search for `"$ROOT/` and `.md` or `grep -q` on md.

Let me grep for `-q` grep on law filenames, and for `sed -n` reading md. Let me grep for "\.md\"" with variable.

Alternative approach: grep for `law` in tools.

Let me grep for lines containing "law" and a filename in tools.

Actually, let me grep for reading of review-lenses.md / hq.md / editor.md / triage.md / toolsmith.md / SKILL.md in tools.

We saw oc-ledger reads SKILL.md (version). oc-review-persist reads review-lenses.md + fleet-directives.md.

Let me check oc-lint-laws corpus more: "Corpus = the 11 normative markdown files". Post-split, are there 11? DEFAULT_CORPUS lists 11. OK.

Hmm, but wait — the split moved 25 sections into role/topic files. If the split created NEW topic files (beyond the role files), the corpus would miss them. README says fleet-directives.md "split 2026-09-18" and its description: "the `[LANE]` cross-role law + a residual of cross-cutting rulings, with a pointer table to the role/topic file that owns scoped law." So the moved sections went into existing role/topic files. So no new file. Corpus fine.

Let me now check the tools that reference specific law sections by name and grep for those section names in the law files to see if they still exist:

- oc-ship-chain: "§Attribution & Goal Hygiene A1" — exists (line 325/327). OK.
- oc-ship-chain: "fleet-directives.md Pure-docs LEG1 skip law (v0.4.161)" — the heading is "Docs-Only LEG1 Gate Skip (v0.4.161...)". "Pure-docs" appears in the section text. OK.
- oc-ledger:1007 "fleet-directives.md routing table" — does fleet-directives.md still have a routing table? README says "with a pointer table to the role/topic file that owns scoped law." Let me check if fleet-directives.md still has a routing table. This is a comment though, not a read.
- oc-ledger:2260 "fleet-directives.md §Work orders" — does fleet-directives.md still have a §Work orders section? The headings list didn't show "Work orders". Hmm! Let me check. The headings I saw: Owner Push Freeze, Telegram surface law, Discussion links, External lanes, Stage-entry consent, Post-compaction skill reload, Receiver-side dedupe, Attribution guard, PR naming convention, Strict Atomicity, LLM Ergonomics, Upstream Coding, Unified Event Capture, Autonomous Priority Authority, Autonomous Editor Goal, Full-Gate Pre-PR, Docs-Only LEG1, Owner-Dependent Smoke Legs, Out-of-Feature-Set, Dispatch Eligibility, Claim Release, Guard-Flag Escalation, Attribution & Goal Hygiene, Post-Rewrite Swap Recovery, Carrier Concurrency, Features-compat gate, Cross-lane message delivery, Direct dispatch, Designated Domain Affinity, Early Claim, Every turn ends, Explain open questions, Upstream PR filing, Verification during truncated-output, Daemon no-reap, telegram_send addressing rule. That's ~36 headings shown (limit 120 but 52 matches?). Hmm the grep said "52 matches" in the summary but listed ~37. Possibly more headings beyond line 465 that got cut? No, the result showed all with limit 120... Actually the output showed matches up to line 465 and said 52 matches — maybe truncated. Anyway.

"§Work orders" — not in the visible list. Hmm, but the heading might be different. Let me grep fleet-directives.md for "Work orders".

But these are comments in oc-ledger, not runtime reads. Lens E is about interface/topology, but the mission is about law-reading. Comments referencing moved sections would be a Lens A/B/F concern maybe. Hmm. But the mission explicitly says find tools that "read law text or anchor on it". "Anchor on it" could include comments... but the quote-or-no-finding rule and the "may now read nothing" phrasing suggests runtime behavior.

Let me focus: find tools whose RUNTIME behavior depends on law text that moved.

Let me search for actual file reads. Let me grep for `grep -` with `.md` and for `"$` ... Let me grep for `SKILL.md` and `fleet-directives` and `review-lenses` in a non-comment context (lines not starting with #).

Let me use grep with pattern that excludes comments: search for lines containing `.md` and `grep` or `sed` or `awk` or `-f` or `read`.

Hmm. Let me just read the key tools: oc-review-persist fully (small, 19647 bytes ~ 500 lines), oc-drift-check, oc-lint-laws.

Let me read oc-review-persist around lines 1-120.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist","o":"#!/usr/bin/env bash\n# =============================================================================\n# oc-review-persist — Duty-6 lens reports land on disk the moment they exist.\n# Born from the 2026-08-29 ghost incident + the 16:45Z \"all four persisted\"\n# correction: a report that lives only in session memory is NOT persisted.\n#\n# usage: oc-review-persist <lens> <text | @file | -> [--dir DIR]\n#   lens ∈ A-J + self + named lenses (see LENSES whitelist below)\n#          deletion-safety\n#   @file reads the report body from a file; - reads stdin; anything else is\n#         literal report text (quote it).\n#   DIR defaults to the I-5.1 CORPUS: reviews/<YYYYMMDD>-cycle/reports/ in the\n#   skill repo (cycle-local index.log - the one that wins on divergence).\n#   OC_REVIEW_DIR=/tmp restores the volatile fallback. Writes\n#   skill-review-<lens>-<YYYYMMDD>.md (same-day\n#   re-run OVERWRITES, noted in the file header) and appends ONE index line:\n#       skill-review-index.log:  ts|lens|path|sha256|bytes\n#   The index line is the receipt Duty-6/7 quote — no receipt, no \"persisted\".\n#\n# Exit codes: 0 persisted + re-read verified · 2 usage (bad lens/empty input)\n#   · 3 re-read sha256 mismatch (storage NOT trusted) · 4 write failure.\n#\n# usage: oc-review-persist check-cycle <cycle-dir> [--catalog DIR] [--strict-receipt]\n#   The Duty-6 CENSUS GATE (I-6.1 remedy 2, v0.4.162). \"Did every catalog lens\n#   run?\" is a pure function of state on disk, so it is a gate, not a reviewer's\n#   memory -- assigning it to a reviewer is agent-memory-as-gate-input, the exact\n#   defect class lens J exists to kill.\n#   Derives the expected lens set from the CATALOG AT GATE TIME: reviewer letters\n#   from review-lenses.md, standing lenses from the `## Review lens <name>`\n#   headings in fleet-directives.md. Hardcoding A-J + brain-scrub here would be\n#   the same rot class as the docs-only 21-path list -- the catalog moves, the\n#   gate must move with it.\n#   A deliberately-skipped lens is a DECISION,","s":true}] -->
<!-- reasoning -->
OK so oc-review-persist:71 is `LENSES_MD="$ROOT/review-lenses.md"; FD_MD="$ROOT/fleet-directives.md"` and line ~76-78 derives reviewer letters from review-lenses.md and standing lenses from fleet-directives.md `## Review lens <name>`. Post-split, the standing lens brief moved to review-lenses.md, so FD_MD yields nothing → zero standing lenses. Known defect. Skip.

Now let me look for OTHER tools. Let me think about the interface/topology lens too: the split is context, but Lens E's own scope includes merge candidates, verb moves, flag duplications. So I should ALSO look for interface/topology defects independent of the split.

Let me be systematic but bounded. Let me look at the tools' option handling for duplicated flags/verbs.

Candidate interface/topology findings:
- oc-smoke wraps oc-smoke-evidence (documented).
- oc-start wraps oc-ledger claim + oc-wt add.
- oc-waiter RETIRED.
- oc-harvest-census and oc-harvest-dispatch share logic; oc_claims.py is a shared lib.
- oc-drift-check vs oc-ledger ack (delegates).
- oc-ship-chain wraps oc-prchecks + oc-issue-log + oc-deploy.

Hmm, that's a lot. The mission hint strongly directs to the split-caused law-reading defects. Let me focus there but also do a quick topology sweep.

Let me search for tools that read law text at runtime more comprehensively. Let me grep for `_MD=` or `_FILE=` assignments pointing to .md, and for `cat`/`grep`/`sed` on md.

Let me grep for "\.md" in tools excluding comments... hard. Let me grep for lines that contain `.md"` AND (`grep` or `cat` or `sed` or `awk` or `-f` or `[ -f`).

Let me try: grep for `\.md` with regex and look at non-comment lines. Actually let me grep for `MD=` assignments.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '^[^#]*\\.md[\"') ]' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/tests/run.sh:785:\n  783: d=\"$(mktemp -d)\"\n  784: \"$TOOLS_DIR/oc-review-persist\" A \"battery edge report\" --dir \"$d\" >/dev/null 2>&1; rc=$?\n> if [ \"$rc\" -eq 0 ] && [ -s \"$d/skill-review-A-$(date -u +%Y%m%d).md\" ] && [ -s \"$d/skill-review-index.log\" ]; then\n  786:   ok \"persist + index receipt on disk\"\n  787: else\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/tests/run.sh:936:\n  934:   [ -x \"$t\" ] || continue\n  935:   tn=\"$(basename \"$t\")\"\n>   OC_TOOLS_NOLOG=1 timeout 20 \"$t\" --help >/dev/null 2>&1     && ok \"$tn --help rc=0\" || bad \"$tn --help rc!=0 (RC-CONTRACT.md violated)\"\n  937: done\n  938: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:212:\n  210:   (\n  211:     cd \"$FORK_REPO\" 2>/dev/null || exit 0\n>     grep -rloE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' src --include=*.rs 2>/dev/null \\\n  213:       | while IFS= read -r rs; do\n  214:           grep -oE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' \"$rs\" 2>/dev/null \\\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:214:\n  212:     grep -rloE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' src --include=*.rs 2>/dev/null \\\n  213:       | while IFS= read -r rs; do\n>           grep -oE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' \"$rs\" 2>/dev/null \\\n  215:             | sed -E 's/.*\"([^\"]+\\.md)\".*/\\1/' \\\n  216:             | while IFS= read -r rel; do\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:215:\n  213:       | while IFS= read -r rs; do\n  214:           grep -oE 'include_(str|bytes)!\\([[:space:]]*\"[^\"]+\\.md\"' \"$rs\" 2>/dev/null \\\n>             | sed -E 's/.*\"([^\"]+\\.md)\".*/\\1/' \\\n  216:             | while IFS= read -r rel; do\n  217:                 realpath -m --relative-to=. \"$(dirname \"$rs\")/$rel\" 2>/dev/null || true\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:260:\n  258:   while IFS= read -r p; do\n  259:     [ -n \"$p\" ] || con","s":true}] -->
<!-- reasoning -->
This is getting noisy. Let me read the spill log to see the full list of non-comment .md references. Actually, let me be smarter: grep for `_MD=` and `FILE=` etc. Let me grep for `=.*\.md` with regex on lines.

Actually, the key insight: the mission says the known defect is oc-review-persist:71. The other defects likely in tools that read law. Let me enumerate the tools that read law at runtime by grepping for the specific law filenames in non-comment lines.

Let me grep for `fleet-directives` and `review-lenses` and `SKILL.md` in non-comment lines. Pattern: `^[^#]*fleet-directives`.

Let me do that.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '^[^#]*(fleet-directives|review-lenses|editor\\.md|hq\\.md|triage\\.md|toolsmith\\.md|upstream-merge-runbook|war-stories)' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:71:\n  70:   [ -d \"$CY\" ] || die 2 \"cycle dir not found: $CY\"\n>   LENSES_MD=\"$ROOT/review-lenses.md\"; FD_MD=\"$ROOT/fleet-directives.md\"\n  72: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-drift-check:126:\n  125:   if [ \"$no_history\" = \"1\" ]; then\n>     echo \"NO-HISTORY: no last_acked recorded for $uuid — treat as DRIFT, re-read SKILL.md + editor.md IN FULL before next phase boundary\"\n  127:     oc_log_extra verdict NO-HISTORY\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-drift-check:134:\n  133:   fi\n>   echo \"DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary\"\n  135:   oc_log_extra verdict DRIFT\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws:70:\n  69: # history makes the lint unusable. Law files are the live contract.\n> DEFAULT_CORPUS=\"SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md\"\n  71: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/archive/compiler.md:3:\n  2: \n> ⛔ **ROLE RETIRED — S3 cutover 2026-08-28 (owner \"let's go to S3\", msgid 34717, consent registered).** The Compiler's duties are now automated into `oc-deploy` (ship / poll / swap-execute). This file survives as the RE-ENABLE runbook: to restore the role, follow the procedure and notify — one notify re-enables (target-process-20260827.md S3 row). Do NOT load this expecting an active role; the active surface is SKILL.md + editor.md + hq.md.\n  4: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/archive/compiler.md:333:\n  332:    train. NO improvised hand-resolutions mid-sweep: resolution is Editor work\n>    under the conflict-quality gate (`editor.md` Phase 6). The Compiler classifies,\n  334:    merges clean, aborts, logs.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/t","s":true},{"d":"Grep '^[^#]*SKILL\\.md' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:489:\n  488:   # SKILL.md must already carry the version (tool never writes it first)\n>   grep -Eq \"^version: $v\\$\" \"$SKILL_DIR/SKILL.md\" \\\n  490:     || die 6 \"sync: SKILL.md frontmatter does not say version: $v — bump the doc first\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:490:\n  489:   grep -Eq \"^version: $v\\$\" \"$SKILL_DIR/SKILL.md\" \\\n>     || die 6 \"sync: SKILL.md frontmatter does not say version: $v — bump the doc first\"\n  491:   # CHANGELOG gate (lens C8, v0.4.65): a bump ships only with its receipt —\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:622:\n  621:   local sv a b c bad=0\n>   sv=\"$(grep -m1 '^version:' \"$SKILL_DIR/SKILL.md\" | awk '{print $2}')\"\n  623:   a=\"$(jq -r '.current_skill_version // \"\"' \"$LEDGER\")\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:626:\n  625:   c=\"$(jq -r '.meta.skill_version // \"\"' \"$LEDGER\")\"\n>   for pair in \"SKILL.md:$sv:$sv\" \"current_skill_version:$a:$sv\" \"meta.current_skill_version:$b:$sv\" \"meta.skill_version:$c:$sv\"; do\n  627:     local nm got want; nm=\"${pair%%:*}\"; got=\"$(echo \"$pair\" | cut -d: -f2)\"; want=\"$(echo \"$pair\" | cut -d: -f3)\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:628:\n  627:     local nm got want; nm=\"${pair%%:*}\"; got=\"$(echo \"$pair\" | cut -d: -f2)\"; want=\"$(echo \"$pair\" | cut -d: -f3)\"\n>     if [ \"$nm\" = \"SKILL.md\" ]; then continue; fi\n  629:     if [ \"$got\" != \"$want\" ]; then echo \"MISMATCH $nm=$got (SKILL.md=$want)\"; bad=1; fi\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:629:\n  628:     if [ \"$nm\" = \"SKILL.md\" ]; then continue; fi\n>     if [ \"$got\" != \"$want\" ]; then echo \"MISMATCH $nm=$got (SKILL.md=$want)\"; bad=1; fi\n  630:   done\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:1026:\n  1025:   bash \"$ME\" sync --version banana >/dev/null 2>&1; chk \"sync-bad-shape\" 6 $?\n>   sed -i 's/version: 0.4.2/ve","s":true}] -->
<!-- reasoning -->
Now let me think about the interface/topology of the tools. The most promising: tools that read law sections that moved.

The known defect is oc-review-persist's standing-lens derivation from fleet-directives.md. Let me check if there is a SECOND, related defect in oc-review-persist: it derives reviewer letters via `sed -n 's/^ *- \*\*Reviewer \([A-Z]\) .*/\1/p' "$LENSES_MD"`. That still works.

But wait — is there another tool that also relies on `## Review lens <name>` in fleet-directives.md? Let me grep for "Review lens" across tools.

Also, the `reviews/` dir — let me check whether the reports persist properly. Not my lens.

Let me think about the split more concretely. 25 sections moved from fleet-directives.md into role/topic files. Which role/topic files received them? And which tools anchor on section headings that moved?

Let me find what moved. I could compare with the previous cycle's report or the CHANGELOG. Let me grep CHANGELOG for the split entry (2026-09-18, v0.4.20x?).

Let me read the top of CHANGELOG (newest first).

Actually more efficient: the reviews/20260918-cycle/reports/ dir may have lens reports from yesterday's cycle that quote fleet-directives.md section headings. But that's archaeology.

Better: grep the skill files for headings that tools reference. Tools reference:
- "§Attribution & Goal Hygiene A1" (oc-ship-chain) → exists.
- "fleet-directives.md Pure-docs LEG1 skip law" → heading "Docs-Only LEG1 Gate Skip" exists.
- "fleet-directives.md routing table" (oc-ledger:1007) → need to check.
- "fleet-directives.md §Work orders" (oc-ledger:2260) → need to check.
- "fleet-directives.md (L158 law)" (oc-notify-fanout:14) → L158 is a line number! Post-split, line numbers shift. Let me check what's at line 158 now: "## Autonomous Priority Authority Law (owner order 2026-09-15) [LANE]" at line 158. Hmm, the comment says "RELOAD line per fleet-directives.md (L158 law)". Is the RELOAD law at L158? Line 158 is "Autonomous Priority Authority Law". Hmm. Let me check: the post-compaction skill reload section is at line 86. So L158 anchor is stale? But this is a comment, and more importantly the fanout tool constructs the RELOAD line. Let me check whether oc-notify-fanout READS fleet-directives.md to build the RELOAD line. Probably not — it builds it from a template. Let me check.

Actually the mission says "any tool that reads law text or anchors on it may now read nothing." "anchors on it" — a line-number anchor like L158 is exactly an anchor that the split would invalidate. But is it load-bearing? Let me examine oc-notify-fanout around line 14 and where the RELOAD line is built.

Hmm, but comments aren't "reading nothing". Let me focus on runtime reads.

Let me search for tools reading law text at runtime more comprehensively. The pattern would be something like: `grep ... "$ROOT/..."`. We found:
- oc-review-persist: sed on review-lenses.md and fleet-directives.md.
- oc-lint-laws: reads corpus files (SKILL.md etc.) via `--file`/DEFAULT_CORPUS.
- oc-ledger: SKILL.md version.
- oc-drift-check: SKILL.md version.
- oc-notify-fanout: SKILL.md version.
- oc-skew-scan: SKILL.md.

Are there tools that read a specific SECTION of a law file? oc-review-persist is the only one I've found so far.

Hmm. But the mission says "find the others" (plural). So there must be more than one other defect. Could be:
1. oc-lint-laws DEFAULT_CORPUS — maybe the split created a new law file (topic file) that's missing from the corpus. Need to verify whether a new file exists. The dir listing showed no new file... but maybe the split created a file and then it's under a name I haven't recognized. Let me list ALL files in the skill dir including hidden.

Actually ls showed the root: reviews/, run/, tools/, CHANGELOG.md, README.md, SKILL.md, editor-upstream-pr.md, editor.md, fleet-directives.md, hq.md, review-lenses.md, s2-swap-journal-spec.md, toolsmith.md, triage.md, upstream-merge-runbook.md, war-stories.md. That's all. So no new topic file at root. Hmm.

Wait — maybe the split moved sections into role files AND the corpus is fine. So oc-lint-laws may not be a defect.

2. Maybe the RELOAD law moved and oc-notify-fanout's RELOAD line references a section. Let me check.

3. Maybe oc-tg-audit or oc-lint-laws reference "AGENTS.md" law that moved.

Let me reconsider: the mission is from the perspective of the split. "The split changed where law lives, so any tool that reads law text or anchors on it may now read nothing."

Let me look at what actually got moved by checking the diff. I can't run git. But maybe there's a review report from cycle 20260918 documenting the split, or the CHANGELOG.

Let me read the CHANGELOG top and grep for "split".

Also, let me check the reviews dir for the current cycle and previous cycle.

Let me also reconsider Lens E's actual scope: interface/topology of the tool surface. Merge candidates, verb moves, flag duplication, ritual halves. Plus standing extra: upstream-drift census (oc-upstream-delta patrol output) for silent drift. Hmm! The STANDING EXTRA is important: "E also reviews the upstream-drift census surface (oc-upstream-delta patrol output) for silent drift — the next merge window must never start blind."

So I should examine oc-upstream-delta and its patrol output for silent drift. That's a specific mandated check.

Let me read oc-upstream-delta (11844 bytes).

Let me plan the remaining reads:
- oc-upstream-delta (standing extra).
- oc-lint-laws full (to confirm corpus).
- oc-notify-fanout RELOAD section.
- CHANGELOG top / grep split.
- Check oc-ledger §Work orders / routing table anchors.

Let me do several reads in parallel.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-upstream-delta","o":"#!/usr/bin/env bash\n# =============================================================================\n# oc-upstream-delta — watch-cycle arithmetic for SKILL.md §Upstream relations\n# (KERNEL C6, 2026-08-29 four-lens review run-2; design:\n# /root/oc-work/oc-upstream-delta-design-20260829.md).\n#\n# Replaces the hand-derived fetch/merge-base/rev-list sequence two lanes had\n# started drifting on. READ-ONLY: fetch + plumbing only. NEVER merges, pushes,\n# or rebases. PROPOSE/WAIT judgment stays HUMAN (owner-word gates, AGENTS.md\n# upstream-relations cluster) — exit 1 is a VERDICT, not an error.\n#\n# Usage:\n#   oc-upstream-delta [--repo P] [--fork-origin R] [--upstream R] [--json] [--no-log]\n#   oc-upstream-delta --selftest      offline fixtures (local remotes only)\n#\n# Output: TSV lines on stdout —\n#   BASE <sha7> / AHEAD <n> / BEHIND <n>\n#   C <sha7> <subject>          (BEHIND list first, then AHEAD list)\n#   ABSORBED-CANDIDATE <fork-sha7> <upstream-sha7>   (patch-id match)\n# Human summary on stderr: \"clean\" or \"delta ahead=N behind=M absorbed=K\".\n#\n# Exit: 0 clean (0/0) / 1 delta present / 2 usage / 3 fetch-or-git failure\n# =============================================================================\nset -u\nset -o pipefail   # F7 (lens F, v0.4.72): pipeline failures are never masked\n_OC_LIB=\"$(cd \"$(dirname \"$0\")\" && pwd)/lib/oc-log.sh\"\nif [ -f \"$_OC_LIB\" ]; then source \"$_OC_LIB\"; oc_log_init \"oc-upstream-delta\" \"$@\"; else oc_log_finish() { :; }; fi\ntrap 'oc_log_finish $?' EXIT\n\nPROG=\"$(basename \"$0\")\"\nGIT_BIN=\"${OC_GIT:-git}\"\nREPO=\"${HOME}/opencrabs\"\nFORK_REMOTE=\"origin\"\nUP_REMOTE=\"adolfousier\"\nJSON_OUT=0\n\nusage() {\n  cat >&2 <<EOS\nUsage: $PROG [--repo P] [--fork-origin R] [--upstream R] [--json] [--no-log]\nExit: 0 clean / 1 delta (verdict) / 2 usage / 3 fetch-or-git failure\nEOS\n  exit 2\n}\n\n# ---------- selftest (offline fixture repos, real git, no network) ------------\nmkfix() { # emits fixture root on stdout: w repo with origin->fork.git, adolfousier->up.git\n  local F; F","s":true},{"d":"Grep 'split' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:135:\n  132: ## v0.4.191 (2026-09-16) — Continuous Issue Relationship Linking Mandate\n  133: \n  134: - **Continuous Issue Relationship Linking Across Lifecycle (Owner Order 2026-09-16, `SKILL.md`, `fleet-directives.md`, `editor.md`, `triage.md`):**\n>   - Expanded the native issue linking mandate from harvest/creation to the entire issue lifecycle: whenever parent subsystem relationships, blocker dependencies, or child sub-issues are established, split, or discovered at ANY point in the lifecycle (issue creation, triage intake sweeps, in-flight editor implementation, task decomposition, or upstream PR staging), the lane identifying it MUST establish native links in the same turn via `gh issue edit <issue> --parent <parent-issue>` and/or `gh issue edit <issue> --add-blocked-by <blocker-issue>`.\n  136:   - Codified into `SKILL.md §Issue-first`, `editor.md §Phase 1 step 2`, `triage.md §Duty T5 step 5`, and `fleet-directives.md §Upstream-merge cadence`.\n  137: \n  138: ## v0.4.190 (2026-09-16) — GitHub Native Harvest Protection Mandates\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:160:\n  157: - **Stalled Claim Nudge Permission (Owner Order 2026-09-16 08:54 UTC, `triage.md` & `fleet-directives.md`):**\n  158:   - Codified in `triage.md` Duty T5 and `fleet-directives.md §Zero-Ack & Dispatch Discipline` that Triage and patrol watchers MAY send a progress nudge via `session_notify` (`delivery.mode=\"turn-end\"`) to an active claim holder if expected deliverables have not arrived or progress has stalled beyond the patrol window.\n  159: - **Docs Family Codification (Cycle 20260916-c19, Findings A-6, B-3, G-1, A-9, A-10, G-4, A-2, A-11):**\n>   - **`editor-upstream-pr.md`**: Repaired text splice splitting PR lifecycle sentence.\n  161:   - **`editor.md`**: Mandated imperative `memory_search scope=\"external\"` exploration & DRY check before bugfixing in Phase 6-Fix loop; pruned manual plumbing commands.\n","s":true}] -->
<!-- reasoning -->
The CHANGELOG top entries are old (v0.4.191 at line 132). Hmm, newest entry FIRST — so the top of the file is the newest. Line 132 is v0.4.191? That seems odd given the skill is at v0.4.20x. Wait, the grep showed line 132 with "## v0.4.191". But the file is 278084 bytes. Newest first means line ~1 is the newest. Let me read the top of CHANGELOG to find the split entry (v0.4.205?).

Actually the split happened 2026-09-18, and the skill is at v0.4.20x. Let me read CHANGELOG lines 1-60.

Also, importantly: I should verify the split's effects. Let me read the CHANGELOG head.

Also note the review-lenses.md says "review-lenses.md — Full Duty-6 lens briefs (A–J)". And hq.md line: "review lenses" pointer.

Let me read CHANGELOG top.

Also let me look at oc-lint-laws fully to confirm corpus correctness, and check whether the split left a law file OUT of the corpus. Actually — key: README says fleet-directives.md split; the moved sections went to "role/topic files". Which topic files? Possibly war-stories.md? No, war-stories is history. Hmm.

Wait. Actually re-read the README: "fleet-directives.md | Binding owner directives that apply to EVERY lane — the [LANE] cross-role law + a residual of cross-cutting rulings, with a pointer table to the role/topic file that owns scoped law. Re-homed from ops AGENTS.md/MEMORY.md, 2026-09-02; split 2026-09-18".

So the split moved scoped law into role/topic files. The role files are editor.md, hq.md, triage.md, toolsmith.md. Topic files could be review-lenses.md, upstream-merge-runbook.md, editor-upstream-pr.md, s2-swap-journal-spec.md. All in corpus. So corpus fine.

Hmm OK. So where else could a tool "read nothing"?

Let me reconsider: maybe there are tools that grep a law file for a section heading. Let me grep for `## ` patterns in tools (sed -n on law files). We found oc-review-persist's sed. Are there others? Let me grep for "sed -n" with md, or for `awk` reading md.

Let me grep tools for `Review lens` and for `## ` usage.

Also oc-tg-audit reads? Let me check oc-tg-audit.

Let me grep for "§" in tools (section anchors).

Let me do a combined grep.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md","o":"# Changelog — opencrabs-dev\n\n## v0.4.205 (2026-09-18)\n\n- **Owner Push Freeze — the soak groups are held from upstream harvest; T6 released (owner order 2026-09-18 17:33Z, release 18:01Z)**: *\"freeze all these groups from pushing - I want to review them first and will release them later\"*, then *\"Telegram flow cluster T6 - release for harvesting\"*. New canonical section `fleet-directives.md §Owner Push Freeze — soaking groups held from upstream harvest` [LANE]. The frozen set is the group list the owner was reading in the delivered live-test plan (`/tmp/live-test-plan-2026-09-18.md`, board topic 30220, `msg=67358`): **18 T-groups (T1–T18) + 7 Tier-3 items**, of which **17 T-groups and all 7 Tier-3 items are frozen** and **T6 (Telegram flow cluster) is released**. Counts derived in python from the plan file, never by eye.\n  - **Release is an OWNER action, never a lane decision** — a group leaves the freeze only on an explicit owner message naming it, exactly as T6 did. Soak maturity elapsing, a green census, a lane's own confidence, or an idle editor release nothing. The released set currently holds exactly one member.\n  - **The freeze binds the machinery, not just the prose**: Triage's 4h harvest patrol (`oc-harvest-dispatch-4h`, job id `73158e43-3b04-4464-bf82-8d9065a191bb`) must not dispatch a frozen group; `oc-harvest-census` / `oc-harvest-dispatch` must read a frozen group as NOT harvest-eligible; a holder of frozen work stops short of Phase 7 (upstream PR filing).\n  - **Distinguished from the existing carrier FREEZE** (`§Remotes & sync` guard 2 — mechanical: no sync while a carrier chain sits between dispatch and swap). Same word, different concept; write **owner push freeze (harvest hold)** when you mean this one. **Scope boundary:** the freeze holds HARVEST, not development — fixes, commits, ships and smokes inside fork `main` continue normally; only the upstream push of a frozen group is withheld.\n- **Early Claim — claim at domain recognition, not at dispatch","s":true},{"d":"Grep 'Review lens|Reviewer|standing lens|LENSES' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"No matches found for pattern: 'Review lens|Reviewer|standing lens|LENSES'","s":true}] -->
<!-- reasoning -->
Wait — grep for "Review lens|Reviewer|standing lens|LENSES" returned no matches in tools/. But oc-review-persist has "reviewer letters from review-lenses.md" and LENSES=" A B C...". Oh, the grep with `|` alternation seems to not work in this tool unless regex=true. Right — earlier I noticed `|` patterns returned no matches. So I must set regex=true. Let me redo with regex=true.

Actually earlier: pattern 'fleet-directives\.md' with regex=true worked. And 'DEFAULT_CORPUS|CORPUS|corpus' without regex returned no matches. So indeed alternation needs regex=true.

Let me redo the "Review lens|Reviewer|LENSES" grep with regex=true.

Also, key CHANGELOG insight: v0.4.203 mentions "tools/oc-health queries crons by NAME, so the stale name made its liveness check a silent no-op for the harvest patrol". That's a real defect (dispatched to Toolsmith).

Hmm, that's about cron names, not the split. But it IS a "silent no-op" class defect in a tool. But is it in scope for Lens E? It's more Lens F (tool code). And it's already dispatched. Hmm.

Let me focus. The mission is about the split. Let me find the split's CHANGELOG entry. The split was 2026-09-18. v0.4.205 is the latest (2026-09-18). Hmm, but the split isn't mentioned in v0.4.205/204/203/202. Maybe it's a later version not in CHANGELOG, or it's mentioned as "25 sections". Let me grep CHANGELOG for "25 sections" or "re-homed" or "pointer table".

Actually the context note says "on 2026-09-18 fleet-directives.md was SPLIT - 25 sections moved out of it into the role/topic files." Let me grep CHANGELOG for "25".

Let me also grep for "routing table" and "Work orders" in fleet-directives.md to check oc-ledger's anchors.

And check oc-lint-laws corpus against actual law files.

Let me run these greps.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep '25 sections|sections moved|re-homed|rehom|pointer table|thematic index' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/CHANGELOG.md:1231:\n  1228: \n  1229: - CLASS 3 RITUALS: E-1 — editor.md Phase-7 harvest step re-pointed to `oc-wt add --create --from adolfousier/main` (v0.4.78 built the flag for exactly this ritual; the old raw `worktree add -b` text taught a false \"oc-wt never creates\" interface fact; raw add demoted to documented fallback).\n  1230: - DUTY-4 P1–P8 ADOPTED (all evidence-backed, 2026-09-01 incidents): P1 waiter notify payload-validation law (unfilled run-id wake = garbage evidence, CI-wait item 10); P2 oc-prchecks detaches-or-fails-fast, inline orphan false-RED lesson (item 11); P3 cross-repo `--head OWNER:BRANCH` law documented (the bare form fails \"No commits between\", adolfousier/opencrabs#1277 filing); P4 base-freshness check (step 2-fresh) before harvest gate dispatch; P5 per-run-id journal filenames (item 12); P6 rustfmt = non-fatal diagnostic pre-pass (Phase 4); P7 post-fmt scope audit before staging — flow.rs:418 lesson (Phase 4); P8 full shas from rev-parse only, never completed from a remembered prefix — incident n=1452 sha-fabrication (item 13).\n> - LENS-B MEDs: F3 REBASE-PORT re-homed from the archived compiler runbook to supervisor.md §Upstream sync (watch/port/parity, boundary note carried; \"until re-homed\" stopgap retired; archive keeps pointer); F4 fan-out GREEN/RED leg internals + journal vocabulary moved to s2-swap-journal-spec.md §Fan-out legs (§Session-notify loop keeps one line); F5 session-notify DELIVERY MODES bullets → 4-row table; F6 war-stories table disclosed to war-stories.md (SKILL.md keeps pointer; README row added); F7 Compiler archaeology dropped (frontmatter clause, role-table row compressed, archived-role bullet deleted); F9 Phase-6a ship-semantics wedge → one line; F11 Duty-3 wall → situation/action table; F12 CONSENT REGISTER compressed (oc-consent-check obituary → CHANGELOG pointer); F14 pre-v0.4.60 raw dump sequestered as labeled block at file top (newest-LAST contract restored)","s":true},{"d":"Grep 'Work orders|routing table|Routing|thematic index|Thematic' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:18:\n  16: | post-swap notify / fan-out vocabulary | `s2-swap-journal-spec.md` |\n  17: \n> **Thematic index** (lens B-17/G-F9 v0.4.90 — file is flat; jump via section name). **[LANE] tag (v0.4.95):** sections every worker MUST read in full at spawn/compaction reload (editor.md/triage.md/toolsmith.md/hq.md RELOAD LAW v0.4.95). EXCEPTION (v0.4.96, lens B-F1): HQ re-reads THIS ENTIRE FILE IN FULL — it owns and rules on the directives; the other three roles may use this thematic-index minimum for non-[LANE] sections.\n  19: \n  20: **Owner holds & gates:** **Owner Push Freeze** (soaking groups held from upstream harvest) · **Discussion links + fix-approval gate** · **Stage-entry consent** · **Guard-Flag Escalation Law** · **Full-Gate Pre-PR Testing Law** · **Docs-Only LEG1 Gate Skip** · **Owner-Dependent Smoke Legs**\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md:141:\n  139: 8. **Cross-Boundary Unit Test Requirement (No Tautological Helper Assertions, Owner Order 2026-09-17):** Unit tests asserting paths, contracts, file operations, or data formats in upstream PRs must test real cross-boundary interaction (e.g. writing through a real file writer and reading back via the target reader in a tempdir) rather than asserting helper equality against its own internal delegate function. Tautological unit tests (where a function merely tests its own internal implementation helper) provide zero regression protection across module boundaries and are strictly rejected.\n  140: \n> ## Unified Event Capture: Urgent Routing vs. Batched Evolution (v0.4.145)\n  142: \n  143: All observed runtime events, anomalies, proposals, and feature ideas MUST follow the strict taxonomy below. Urgent execution items route directly to the owning substrate without relay hops; non-urgent evolution items persist to disk/ledger to prevent context bloat and memory compaction at HQ.\n\n(2 matches)","s":true},{"d":"Grep 'Review lens|standing lens|LENSES|Reviewer' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ship-chain:1529:\n  1527:   grep -q \"$DOCS_SHA\" \"$T/prchecks.log\" && ok \"docs-skip-override-gates\" || bad \"docs-skip-override-gates\"\n  1528: \n>   # 20d. --eval-docs-skip standalone inspection verb (Defect #20 / Reviewer J-7).\n  1530:   #      rc 0 = docs-only (prints paths); rc 1 = gate-required; rc 2 = missing sha;\n  1531:   #      rc 3 = bad ref or git error.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:8:\n  6: #\n  7: # usage: oc-review-persist <lens> <text | @file | -> [--dir DIR]\n> #   lens ∈ A-J + self + named lenses (see LENSES whitelist below)\n  9: #          deletion-safety\n  10: #   @file reads the report body from a file; - reads stdin; anything else is\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:29:\n  27: #   defect class lens J exists to kill.\n  28: #   Derives the expected lens set from the CATALOG AT GATE TIME: reviewer letters\n> #   from review-lenses.md, standing lenses from the `## Review lens <name>`\n  30: #   headings in fleet-directives.md. Hardcoding A-J + brain-scrub here would be\n  31: #   the same rot class as the docs-only 21-path list -- the catalog moves, the\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-review-persist:51:\n  49: trap 'oc_log_finish $?' EXIT\n  50: \n> LENSES=\" A B C D E F G H I J self redundancy-ontology efficiency-creep cli-automation deletion-safety brain-scrub \"   # E F G added v0.4.72; H (ledger health) v0.4.114; I (meta-review) v0.4.115; J (mechanical enforcement) v0.4.161 — whitelist var itself missed in v0.4.114 (message-only edit), fixed v0.4.115. F-6 v0.4.119: single letters A–J are now ENFORCED whitelist entries — adding a letter here is the only path to accepting it (previously the case-glob short-circuit made these 9 entries dead). v0.4.161: the case-globs in the dispatch below MUST widen in the same edit — a whitelist-only change leaves J accepted (via the *) arm) while J1 stil","s":true}] -->
<!-- reasoning -->
Important finding candidate: `oc-drift-check:126` and `:134` print "re-read SKILL.md + editor.md IN FULL before next phase boundary". But per the RELOAD LAW (v0.4.95) and the split, the reload set is "SKILL.md + role file + fleet-directives.md". Hmm, and now editor.md? Actually the drift message says "re-read SKILL.md + editor.md IN FULL". For an editor lane that's the role file. Hmm. This is a message text, arguably stale (it doesn't mention fleet-directives.md or the role file generically). But is it a defect caused by the split? Not directly. Might be Lens A/B.

Hmm, let me step back and think about what the mission really wants and what evidence I can produce.

The mission: find tools that read law text or anchor on it that may now read nothing. Known: oc-review-persist:71.

Let me now systematically find all law-reading tools. From greps:
- oc-review-persist: reads review-lenses.md + fleet-directives.md.
- oc-lint-laws: reads DEFAULT_CORPUS law files.
- oc-ledger: SKILL.md version; also `check-version`.
- oc-drift-check: SKILL.md version.
- oc-notify-fanout: SKILL.md version.
- oc-skew-scan: SKILL.md.
- oc-health: SKILL_DIR, version.
- oc-ship-chain: no law read (only source-tree compiled-md derivation).

Hmm — wait. Maybe the split moved the `## Review lens brain-scrub` heading AND ALSO the reviewer letter derivation is fine. But there's another possibility: the split moved sections out of fleet-directives.md, and some tools read fleet-directives.md for a *different* purpose. Only oc-review-persist reads it.

So maybe the "others" are in a different class: tools whose doc/comment anchors point at moved law, causing a lane following the tool's output to read nothing. E.g.:
- oc-drift-check's DRIFT message tells the lane to re-read "SKILL.md + editor.md IN FULL" — post-split, the binding law for many topics now lives in fleet-directives.md and role files. Hmm, weak.
- oc-lint-laws DEFAULT_CORPUS: post-split, does the corpus still cover all law? Let me verify by listing actual .md law files vs corpus. Corpus = SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md. Actual law-ish files: those + README.md + CHANGELOG.md + war-stories.md + tools/HEALTH-CHECKS.md + tools/HEALTH-CLASSES.md. The excluded ones are deliberate. So corpus OK. Unless the split created a new file... no.

Hmm. Let me reconsider: maybe the split moved law into role files and the TOOLS that reference "§<Section>" in comments now point to a section that no longer exists in that file — e.g., oc-ledger:2260 "fleet-directives.md §Work orders" and oc-ledger:1007 "fleet-directives.md routing table". Let me check whether those exist.

fleet-directives.md headings I saw don't include "Work orders". Let me grep for "Work orders" and "routing" in the whole skill.

Also oc-ship-chain:476 "§Attribution & Goal Hygiene A1" exists.

And oc-notify-fanout:14 "RELOAD line per fleet-directives.md (L158 law)" — line 158 now = "## Autonomous Priority Authority Law". So the L158 anchor is stale. But what law is the RELOAD line? The post-compaction reload law is at fleet-directives.md §Post-compaction skill reload (line 86). Hmm, L158 was probably the reload law pre-split. Post-split the reload law moved to line 86 (or the section moved). So oc-notify-fanout's RELOAD brief is built from a template, not read from the file — so it doesn't "read nothing", but its comment anchor is stale. Is the RELOAD line content correct? It says "RELOAD: run oc-drift-check ${uuid} --ack, re-read changed files. ACK after drift-check." That's fine functionally.

Hmm, these are comment-level staleness (Lens A/B territory: stale ref names). The mission explicitly frames as "any tool that reads law text or anchors on it may now read nothing". So the intended findings are runtime-read defects.

Let me search harder for runtime law reads. Maybe a tool greps fleet-directives.md for the [LANE] tag, or reads AGENTS.md, or reads a section.

Let me grep tools for `AGENTS.md`, `MEMORY.md`, `USER.md`, `SKILL.md` reads, and for `LANE]`.

Also grep for `hq.md` reads.

Let me grep for `fleet-directives` again but check ALL occurrences (12 found earlier): oc-rebase-safety:5 (comment), oc-ship-chain:476 (comment), oc-ledger:1007 (comment), oc-ledger:2260 (comment), oc-review-persist:30 (comment), oc-review-persist:71 (code), oc-review-persist:193 (test fixture), oc-smoke-evidence:39 (comment), oc-lint-laws:70 (code), oc-notify-fanout:14 (comment), RC-CONTRACT.md (docs).

So only oc-review-persist:71 and oc-lint-laws:70 read it in code. oc-lint-laws includes fleet-directives.md in corpus — fine (file exists).

Hmm. So maybe the "others" are not about fleet-directives.md specifically. The mission says "any tool that reads law text or anchors on it may now read nothing". Perhaps the split also moved law OUT of SKILL.md or role files? The context says 25 sections moved out of fleet-directives.md into role/topic files. Hmm.

Wait — maybe the split moved the *review-lenses* brief? No, review-lenses.md was split from hq.md v0.4.78.

Alternatively, maybe the split created a NEW file (a topic file) that tools should read but don't. Hmm.

Let me check the reviews/ dir for the current cycle and yesterday's cycle reports — maybe there's a note about the split. Also, the split was 2026-09-18; let me grep the skill for "split" to find a "SPLIT" note in SKILL.md or fleet-directives.md.

Let me grep SKILL.md and fleet-directives.md for "split".

Also let me look at reviews/20260919-cycle.

Let me do these.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Grep 'split 2026-09-18|SPLIT|split \\(2026' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:20:\n  16: | `editor-upstream-pr.md` | Harvest & upstream PR filing procedure (Phase 7b/7c) |\n  17: | `hq.md` | HQ role — worker roster, duty cadence, CI-wait & waiter discipline, review lenses |\n  18: | `review-lenses.md` | Full Duty-6 lens briefs (A–J) — split from hq.md v0.4.78 |\n  19: | `war-stories.md` | Incident histories behind the hard rules (disclosed from SKILL.md, v0.4.80) |\n> | `fleet-directives.md` | Binding owner directives that apply to EVERY lane — the `[LANE]` cross-role law + a residual of cross-cutting rulings, with a pointer table to the role/topic file that owns scoped law. Re-homed from ops AGENTS.md/MEMORY.md, 2026-09-02; split 2026-09-18 |\n  21: | `upstream-merge-runbook.md` | Procedure for the REBASE sync model: gates, roles, conflict classes, migration-union rule |\n  22: | `s2-swap-journal-spec.md` | Journal vocabulary spec for the oc-deploy swap leg |\n  23: | `CHANGELOG.md` | Version history, **newest entry FIRST** |\n  24: | `tools/` | The `oc-*` tool fleet |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/war-stories.md:105:\n  101: - **Attribution guard nuance (2026-08-30, run 33312747740 / 267089af):** after a rebase-port, `gh api compare` over a fanout range reports `status=diverged, ahead_by=98` and the commit list looks like days of foreign history — that is the cherry-pick lineage, not a misfire. Verify attribution by grepping the range's commit messages for your `Session-Id:` trailer (e756b84b found on 7 commits: c6661d1a, 554bdcfc, 5135ea02, 4c9db2a3, 9c899d9e, 99b2158a, fc8b337a). Trailer-present = notify legitimate; do NOT dispute on date grounds. Also observed: fanout fired TWO overlapping legs for one run (journals fanout-33312747740-1788095871 + -1788096069, both notified=12/skipped=1) — duplicate notifies are benign but fanout.state dedup did not suppress the concurrent second leg; flagged for HQ S2 wiring.\n  102: \n  103: \n  104: \n> - **Log writers don't escape n","s":true},{"d":"ls ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews","o":"2026-09-05-A-redundancy.md\n20260907-duty46/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260907-duty46:\n  verdict-table.md\n20260907-duty46-cycle2/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260907-duty46-cycle2:\n  reports/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260907-duty46-cycle2/reports:\n    skill-review-A-20260829-run2.md\n    skill-review-A-20260829.md\n    skill-review-A-20260831.md\n    skill-review-A-20260901.md\n    skill-review-A-20260907.md\n    skill-review-A2-20260907.md\n    skill-review-B-20260829-run2.md\n    skill-review-B-20260829.md\n    skill-review-B-20260831.md\n    skill-review-B-20260901.md\n    skill-review-B-20260905.md\n    skill-review-B-20260907.md\n    skill-review-B2-20260907.md\n    skill-review-C-20260829-run2.md\n    skill-review-C-20260829.md\n    skill-review-C-20260831.md\n    skill-review-C-20260901.md\n    skill-review-C-20260905.md\n    skill-review-C-20260907.md\n    skill-review-C2-20260831.md\n    skill-review-C2-20260907.md\n    skill-review-D-20260829-run2.md\n    skill-review-D-20260829.md\n    skill-review-D-20260831.md\n    skill-review-D-20260901.md\n    skill-review-D-20260907.md\n    skill-review-D2-20260907.md\n    skill-review-E-20260901.md\n    skill-review-E-20260907.md\n    skill-review-E2-20260907.md\n    skill-review-E2b-20260907.md\n    skill-review-F-20260901.md\n    skill-review-F-20260905.md\n    skill-review-F-20260907.md\n    skill-review-F2-20260907.md\n    skill-review-G-20260901.md\n    skill-review-G-20260907.md\n    skill-review-G2-20260907.md\n    skill-review-brain-scrub-20260905.md\n  skill-review-index.log\n  verdict-table.md\n20260909-cycle/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260909-cycle:\n20260910-cycle/\n  /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260910-cycle:\n  reports/\n    /root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260910-cycle/reports:\n    skill-review-A-20260910.md\n    skill-review-B-20260910.md\n    s","s":true}] -->
<!-- reasoning -->
Let me check the current cycle's state.json and yesterday's lens-S staleness report (20260918) — it may name the split's moved sections and the tools affected.

Let me read reviews/20260919-cycle/state.json and reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md (partial), and the lens-B report.

Actually the lens-S report is about staleness archaeology — likely relevant. Let me read it.

Let me read state.json first (small) and lens-S report.
<!-- /reasoning -->


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260919-cycle/state.json","o":"{\n  \"cycle_id\": \"20260919-cycle\",\n  \"cadence\": \"15/5 FIRE (boundary n=6643)\",\n  \"started_at\": \"2026-09-19T04:09:54Z\",\n  \"status\": \"IN_PROGRESS\",\n  \"owner_order\": \"/goal run duty 6, no approval needed - run the lenses, validate and fix (2026-09-19)\",\n  \"proposals\": [],\n  \"lenses\": {\n    \"A\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"B\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"C\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"D\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"E\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"F\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"G\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"H\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"I\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"J\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    },\n    \"brain-scrub\": {\n      \"status\": \"PENDING\",\n      \"report_path\": null,\n      \"verdict\": null\n    }\n  },\n  \"codification_plan\": [],\n  \"updated_at\": \"2026-09-19T04:09:54Z\"\n}","s":true},{"d":"Grep 'tools/|oc-' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/reviews/20260918-cycle/reports/lens-S-staleness-archaeology-20260918.md:12:\n  6: \\n## Remotes &\",\"s\":true}] -->\n  7: \n  8: \n  9: \\n## Remotes &\",\"s\":true}] -->\n  10: \n  11: \n> \\n## Swap-head signature for rebase/synthesis/merge-derived binaries (owner 2026-09-03 \\\"Land 1+2 only, keep version as-is\\\")\\n\\nGate 4 (Session-Id trailer, `quick-build-linux.yml` ORDER gates) applies to every swap head. **Rebase, synthesis and merge heads cannot carry trailers**, so a bare (unsigned) head must never be dispatched to the build leg (2026-09-03: bare merge `d02f4e08` passed pr-checks GREEN, swap blocked exit 2 pre-install; fixed forward-only with empty marker `1d0dd4cc`. 2026-09-11: the atomic cutover head `12d25260` hit the same wall — `oc-order-validate: UNSIGNED`, chain rc 6 — and stranded main undeployed until marker `70b04864` was landed). **Every upstream sync produces such a head, so this recurs on every sync.** Standing law:\\n\\n1. **Marker, not waiver** — the marker-commit procedure (tree-identical empty trailer-signed commit before the build dispatch) lives in upstream-merge-runbook.md **step 9** — this file carries the RULING only: never dispatch a bare (unsigned) head, never loosen gate 4. Owner's swap ruling carries over; the marker changes no bytes.\\n2. **pr-checks mirrors gate 4 in swap mode** — `pr-checks.yml` (carrier branch `ci/quick-build-linux`, landed `464f77c4`) takes `swap=true`: runs the exact gate-4 regex on the gated ref before fmt/clippy/tests. Swap-mode GREEN ⇒ swappable — the build leg has no remaining semantic failure mode (clippy+tests subsume build success; the binary build itself stays quick-build's job, no duplicate artifact per the 2026-08-31 de-dup ruling). Input-gated: ordinary PR-lane runs unchanged.\\n3. **Version stays put on merges/swaps** — merge-derived binaries ship with the tree's standing version; `deployed.meta.json` (sha + artifact sha256) is the identity record, not the version str","s":true}] -->
<!-- reasoning -->
Let me continue the Lens E review task. I need to run the 4 cheap verification greps, then compose the report.

Let me run the verification greps now.

1. read_file fleet-directives.md start_line=1 line_count=32 → pointer table
2. grep '--wait' tools/oc-prchecks
3. grep 'harvest-watch-4h|oc-harvest-dispatch-4h|cron_jobs' tools/oc-health
4. grep 'Closure predicate' triage.md and 'bump steps' hq.md

Let me run these in parallel.
<!-- /reasoning -->

Picking up the Lens E thread. Running the four cheap verification greps before composing the report.


<!-- tools-v2: [{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"# Fleet directives — opencrabs-dev cross-role law\n\n**Owns:** the binding owner directives that apply to EVERY opencrabs-dev lane — the `[LANE]` law every worker reads in full at spawn and at compaction reload, plus a residual of cross-cutting rulings that belong to no single role. Re-homed here from ops AGENTS.md/MEMORY.md per owner order 2026-09-02.\n\n**Shape after the 2026-09-18 split.** Role- and topic-scoped law no longer lives here: 25 sections were relocated byte-exact into the file that owns them, and this file keeps a pointer only — one concept, one home. Read scoped law THERE:\n\n| Kind of law | Canonical file |\n|---|---|\n| sync model & rebase, seam resolution, harvest cadence / HARVEST LAW / NO-HOLD, PHOP, swap-head signature | `upstream-merge-runbook.md` |\n| editor phases, smoke procedure, CI-wait & CI-watcher discipline, carrier hotfix gates, swap-sha coverage, no auto-rollback, inherited-claim pillars | `editor.md` |\n| upstream PR lifecycle, deep-core heads-up gate, dependent PRs law, cross-fork PR inspection, upstream issue filings | `editor-upstream-pr.md` |\n| intake & assignment, dispatch hygiene, topic domain alignment, parked issues, Decision Rollcall, creating new editors | `triage.md` |\n| tool-problem reports, tool logging rule | `toolsmith.md` |\n| HQ duties, cadence boundary, rule-text provenance, refuse-and-reroute | `hq.md` |\n| Duty-6 lens briefs (A–J families + brain-scrub) | `review-lenses.md` |\n| post-swap notify / fan-out vocabulary | `s2-swap-journal-spec.md` |\n\n**Thematic index** (lens B-17/G-F9 v0.4.90 — file is flat; jump via section name). **[LANE] tag (v0.4.95):** sections every worker MUST read in full at spawn/compaction reload (editor.md/triage.md/toolsmith.md/hq.md RELOAD LAW v0.4.95). EXCEPTION (v0.4.96, lens B-F1): HQ re-reads THIS ENTIRE FILE IN FULL — it owns and rules on the directives; the other three roles may use this thematic-index minimum for non-[LANE] sections.\n\n**Owner holds & gates:** **Owner Push Freeze** (soaking gro","s":true},{"d":"Grep '--wait' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-prchecks","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-prchecks:24:\n  21: # dispatch+adopt and the newest run in window is always this lane's own.\n  22: #\n  23: # Usage:\n> #   oc-prchecks [<branch-or-sha> | resume <run-id> | wait <ref>] [--wait N] [--budget N] [--poll S] [--repo SLUG-or-PATH] [--carrier C] [--no-log]\n  25: #   oc-prchecks --selftest          offline, gh-shim injected (zero network)\n  26: #\n  27: # Defaults: --repo leshchenko1979/opencrabs, --carrier ci/quick-build-linux,\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-prchecks:28:\n  25: #   oc-prchecks --selftest          offline, gh-shim injected (zero network)\n  26: #\n  27: # Defaults: --repo leshchenko1979/opencrabs, --carrier ci/quick-build-linux,\n> # --wait 600 (15s poll). Env: OC_GH (gh shim), OC_PRCHECKS_POLL,\n  29: # OC_PRCHECKS_RESOLVE_WAIT, OC_PRCHECKS_RESOLVE_POLL,\n  30: # OC_PRCHECKS_DEDUP_WINDOW (pre-dispatch dedup window, seconds, default 21600=6h;\n  31: # a same-sha/ref run witness inside the window is adopted if still live —\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-prchecks:46:\n  43: #       2 usage / sha-shape / unknown ref / repo-path-no-origin\n  44: #       3 RED (run conclusion failure/timed_out/startup_failure,\n  45: #         or a FAILED step — soft-fail exposed; skipped/neutral steps pass)\n> #       5 non-terminal at verdict time (resume: oc-prchecks resume <id> --wait N)\n  47: # Verdict rule (v0.4.56, owner Go 08-31 03:05Z): the RUN conclusion is the\n  48: # verdict; per-step detail is a tiebreak ONLY for conclusion=failure steps\n  49: # (kills false GREEN on cancelled and false RED on skipped fmt — issue-lane\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-prchecks:53:\n  50: # findings 2026-08-30, runs 33316539757/33341579381 et al).\n  51: #       4 dispatch-or-api-or-lock failure (incl. yml-missing-on-carrier,\n  52: #         adoption timeout, dispatch lock busy)\n> #       5 still in flight after --wait (run id + URL on std","s":true},{"d":"Grep 'harvest-watch-4h|oc-harvest-dispatch-4h|cron_jobs' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-health","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-health:146:\n  144:   git -C \"$T/fork\" commit -qm init >/dev/null 2>&1\n  145: \n>   sqlite3 \"$T/db.sqlite\" \"CREATE TABLE cron_jobs (name TEXT, enabled INTEGER, deliver_to TEXT, prompt TEXT);\"\n  147:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('oc-roster-detached-sweep',1,'','silent; uses session_notify');\"\n  148:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('harvest-watch-4h',1,'','ok');\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-health:147:\n  145: \n  146:   sqlite3 \"$T/db.sqlite\" \"CREATE TABLE cron_jobs (name TEXT, enabled INTEGER, deliver_to TEXT, prompt TEXT);\"\n>   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('oc-roster-detached-sweep',1,'','silent; uses session_notify');\"\n  148:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('harvest-watch-4h',1,'','ok');\"\n  149:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('oc-health-hourly',1,'','ok');\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-health:148:\n  146:   sqlite3 \"$T/db.sqlite\" \"CREATE TABLE cron_jobs (name TEXT, enabled INTEGER, deliver_to TEXT, prompt TEXT);\"\n  147:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('oc-roster-detached-sweep',1,'','silent; uses session_notify');\"\n>   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('harvest-watch-4h',1,'','ok');\"\n  149:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('oc-health-hourly',1,'','ok');\"\n  150: \n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-health:149:\n  147:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('oc-roster-detached-sweep',1,'','silent; uses session_notify');\"\n  148:   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('harvest-watch-4h',1,'','ok');\"\n>   sqlite3 \"$T/db.sqlite\" \"INSERT INTO cron_jobs VALUES ('oc-health-hourly',1,'','ok');\"\n  150: \n  151:   printf '{\"ts\":\"2026-09-11T00:00:00Z\",\"tool\":\"oc-demo\",\"args\":\"\",\"exit\":0,\"secs\":0.1,\"extra\":{}}\\n' > \"","s":true},{"d":"Grep 'Closure predicate' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md","o":"[SKILL GATE] This call touches '/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md' which matches skill 'opencrabs-dev' (globs: ~/opencrabs/**, ~/oc-wt-*/**, ~/.opencrabs/profiles/*/skills/opencrabs-dev/**, ~/.opencrabs/profiles/*/opencrabs-dev/**, ~/.opencrabs/profiles/*/projects/opencrabs-dev/**), not loaded in the current session context. The full skill body follows. Read it, then re-issue the identical call.\n\n---\n\n# opencrabs-dev — OpenCrabs source procedure\n\n**Owns:** everything touching `~/opencrabs` source, its GitHub Actions runs, or the\ninstalled `opencrabs` binary. This file = shared facts + role router only. Actual\nprocedures live in FOUR role files (`editor.md` / `hq.md` / `triage.md` / `toolsmith.md`);\nload ONLY the one matching the session's role.\n\n**Binding owner directives** (sync policy, upstream PR law, carriers/builds, cargo\nprohibition, telegram surface law, tool logging, gates, editor creation, tool-problem triage (Triage lane),\ncadence) live in `fleet-directives.md` — re-homed from ops AGENTS.md/MEMORY.md per\nowner order 2026-09-02. Load it before ANY opencrabs-dev work. Executing procedure for the sync\npolicy's rebase procedure: `upstream-merge-runbook.md` (freeze gate, roles, conflict\nclasses, migration-union rule, semantic-triage defaults).\n\n## STEP ZERO — establish the role (mandatory on every load)\n\nAsk the operator which role this session employs before doing anything:\n\n> **Editor, HQ, Triage, or Toolsmith?**\n\n| Role | Owns | Procedure file |\n|------|------|----------------|\n| **EDITOR** | Commits + error fixes: claim issue → worktree → code → CI gate → sign → push → ff-merge into fork `main` → `oc-deploy ship` → smoke on notify; feature COMPLETE → upstream PR filed on smoke PASS (procedure `editor-upstream-pr.md` Phase 7) | `editor.md` |\n| **HQ** | Skill set maintenance, worker ledger, Duty 4 worker polls, Duty 6 periodic 11-lens reviews (details in `hq.md` and `review-lenses.md`) | `hq.md` |\n| **TRIAGE** | Intake & hygiene: is","s":false}] -->
<!-- reasoning -->
The skill gate fired again (as expected — the first tool call after fresh session). I need to re-issue the triage.md grep.

Key results so far:
1. **Pointer table** read — the destinations are: `upstream-merge-runbook.md`, `editor.md`, `editor-upstream-pr.md`, `triage.md`, `toolsmith.md`, `hq.md`, `review-lenses.md`, `s2-swap-journal-spec.md`. All of these ARE in DEFAULT_CORPUS. So F1's "missing destination" check: all destinations are present. But README.md is still not in corpus. Hmm — so F1 severity: the corpus includes all pointer destinations, but NOT README.md. Wait, but is README.md normative law? It's a layout table + descriptions. Does it carry `oc-*` invocations? The summary said README.md carries live invocations (`bash tools/tests/run.sh`, `oc-ledger sync`, `oc-wt add`, `oc-deploy ship`, `oc-notify-fanout`). So it's a law file with invocations not linted. That's a MED finding then, not HIGH — since all pointer destinations are covered. Actually wait — let me reconsider. The corpus enumerates 11 files; the skill root holds 13 .md files. The 11 = SKILL.md + fleet-directives.md + editor.md + editor-upstream-pr.md + hq.md + triage.md + toolsmith.md + review-lenses.md + upstream-merge-runbook.md + s2-swap-journal-spec.md + tools/RC-CONTRACT.md. That's 11. The 13 root .md files = those 11 minus RC-CONTRACT (which is in tools/) = 10 root + README.md + CHANGELOG.md + war-stories.md = 13. So root .md = SKILL, fleet-directives, editor, editor-upstream-pr, hq, triage, toolsmith, review-lenses, upstream-merge-runbook, s2-swap-journal-spec, README, CHANGELOG, war-stories = 13. Yes. So README.md is the one file neither in corpus nor in the documented exclusion list.

So F1: downgrade from HIGH to MED, since all pointer destinations ARE covered. The remaining gap is README.md — a live-invocation-carrying file outside the corpus and outside the exclusion rationale. Actually — is that a strong finding? README.md is a layout/description file. Hmm. The lint's comment says "Law files are the live contract" and corpus = "the skill's normative markdown". README.md describes layout — arguably normative. It carries `bash tools/tests/run.sh`. Hmm, that's weak-ish but still a real enumeration-rot point. Let me keep it as MED but frame it honestly: the split just added a pointer table whose destinations are all covered, BUT the corpus is still hand-enumerated and README.md (which carries live invocations) sits outside both the corpus and the exclusion list. Actually, given all destinations are covered, the strongest angle is: the enumeration is a maintenance hazard that the split already demonstrated can rot. Hmm, but "quote-or-no-finding" — I have the quote. Let me keep it but as MED.

Hmm, wait. Actually, let me reconsider whether this is really a Lens E (INTERFACE/TOPOLOGY) finding. Lens E reviews the TOOL SURFACE — pairs of tools, verbs that belong in one tool, flags duplicating another tool's job. Is "corpus under-enumerates" an interface/topology finding? It's more of a correctness/maintenance finding — could belong to lens F (tool code review) or lens A. Hmm. But the summary had it as F1 HIGH. Let me think about whether it fits lens E.

Lens E: "pairs of tools whose invocations are bound to come one after another in practice (merge candidates), verbs that belong in one tool instead of two, a flag duplicating another tool's job, a ritual two tools cover in half each."

Hmm, the corpus finding isn't really about merging interfaces. But the report is already framed. Actually — the corpus relates to `oc-lint-laws`'s job vs `oc-review-persist`'s catalog... Actually `oc-review-persist` has a NEXP catalog and `oc-lint-laws` has a corpus. Both are hand-enumerated lists of law files → they're TWO tools covering the same ritual (enumerate the law corpus) in half each, with different hardcoded lists. THAT is a genuine Lens E finding: two tools each maintain their own hand-rolled list of the normative markdown, and the split rotted at least one. That's the merge/duplication angle. Good — I can frame F1 that way: `oc-lint-laws:70` DEFAULT_CORPUS (11 names) and `oc-review-persist` NEXP catalog (the docs-only 21-path list per its own comment) are two hand-enumerated law-file lists, one per tool — a ritual two tools cover in half each.

Hmm, but oc-review-persist:71 is the known defect (do not re-report). But the *catalog* enumeration in oc-review-persist is a different thing from :71. Let me be careful. Actually the summary quotes oc-review-persist's own comment: `# the same rot class as the docs-only 21-path list -- the catalog moves, the # gate must move with it.` So oc-review-persist already acknowledges the rot class. Fine.

Let me keep F1 focused: DEFAULT_CORPUS is hand-enumerated; README.md falls outside both corpus and exclusion list. That's defensible and quoted.

2. **oc-prchecks --wait** — verified: `--wait N` IS accepted (it's an integer-valued flag controlling the wait budget, default 600). And `wait <ref>` is a subcommand (default budget 2700s, poll 30s). So they are NOT the same job! `--wait N` is a flag setting a timeout for any invocation; `wait <ref>` is a subcommand that skips the shape gate / dispatch / lock / adoption and goes straight to watch+verdict. So the law text in review-lenses.md that says "for a blocking gate, `oc-prchecks --wait`" is arguably a THIRD spelling issue: the law prescribes `oc-prchecks --wait` as if it were the blocking gate, but `--wait` alone just sets a budget (and needs an integer). The actual blocking-gate subcommand is `wait <ref>`.

Wait — so F3 changes: it's not "law prescribes a dead flag". `--wait` exists but needs an integer argument and is just the budget; the blocking-gate subcommand is `wait`. So `oc-prchecks --wait` as written in the law is malformed (missing N) OR means something different from the blocking gate. Let me re-read the review-lenses.md quote. From summary: ``(for a blocking gate, `oc-prchecks --wait`)`` and ``also flags `oc-prchecks --wait` used as a verdict waiter (double-duty)``. Hmm. So the law text uses `oc-prchecks --wait` as shorthand for the blocking-gate waiter. But `--wait` requires an integer (usage: `--wait N`), and the blocking-gate loop is the `wait <ref>` subcommand. So the law's invocation is at best ambiguous and at worst a usage error (rc 2). This IS a real interface finding: ONE job (blocking gate wait) reachable as subcommand `wait <ref>` vs flag `--wait N`, and the law names the flag form which is actually the budget knob, not the waiter.

Hmm, but I need the verbatim from review-lenses.md. I have it in the summary as: ``also flags `oc-prchecks --wait` used as a verdict waiter (double-duty)`` and ``(for a blocking gate, `oc-prchecks --wait`)``. Let me re-grep review-lenses.md to get the exact line. Actually the summary says locator review-lenses.md:184. Let me get the verbatim quote precisely — I should re-grep to be safe. Actually the RULES say quote-or-no-finding. I have a quote from the summary but let me verify it's exact by grepping.

3. **oc-health cron liveness by NAME** — VERIFIED STILL UNFIXED: `oc-health:772`: `SELECT name FROM cron_jobs WHERE enabled=0 AND name IN ('harvest-watch-4h','oc-roster-detached-sweep','oc-health-hourly');` — queries by NAME. And note `harvest-watch-4h` is the STALE name (the law renamed to `oc-harvest-dispatch-4h`). So F6 is CONFIRMED: still queries by name, so a renamed patrol silently escapes. Keep it as MED. Good — and this is an actual live instance: `harvest-watch-4h` is the old name; per the cron-namespacing law the job is now `oc-harvest-dispatch-4h`. So the query would miss it. Strong finding.

Wait — but is this a Lens E finding? It's a "liveness check by name → silent no-op". Hmm, it's about the tool surface (oc-health's cron check). It's more lens F (tool code). But it relates to E's standing extra ("the next merge window must never start blind" — census/patrol surface). Hmm, oc-health is the health census. Eh, I'll include it framed as the census/patrol surface blind spot. Actually, it might be better characterized as lens F. But the report is Lens E; I'll include it with a note it touches the patrol surface. Actually — let me reconsider. To keep the report tight and on-lens, maybe I should drop F6 or keep it. It's a strong, verified finding. Given the report allows 4-6 findings, I'll include it but frame it as the liveness/census surface.

Hmm, actually — the standing extra is specifically about `oc-upstream-delta` patrol output. F6 is oc-health. Still, the "census surface" framing covers it. Let me include it.

4. triage.md "Closure predicate" — gate fired, need to re-issue.

Let me now re-issue the triage.md grep and also grep review-lenses.md for the oc-prchecks --wait verbatim, and grep hq.md for 'bump steps', and check README.md invocations, and check oc-seal-state:180 verbatim, and oc-drift-check:126/134 verbatim, and oc-lint-laws:70 verbatim, and glob the skill root *.md count.

Let me batch these (different files, safe to parallelize).

Actually the skill gate — once the skill body is injected, subsequent calls should work. Let me re-issue.

Let me run:
- grep triage.md 'Closure predicate'
- grep review-lenses.md 'oc-prchecks --wait' with context
- grep hq.md 'bump steps'
- grep oc-seal-state 'single source of truth' (verify :180)
- grep oc-lint-laws 'DEFAULT_CORPUS'
- glob skill root *.md
- grep README.md for oc- invocations

Let me do these in one batch.
<!-- /reasoning -->

Skill gate re-fired (expected on the first call of a fresh session). Re-issuing the blocked grep plus the remaining verifications.


<!-- tools-v2: [{"d":"Grep 'Closure predicate' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/triage.md:161:\n  159: owner word (reopen + note).\n  160: \n> **Closure predicate for fork-only base-fault fixes (HQ ruling 2026-09-18,\n  162: v0.4.201).** When the candidate is a *fix* whose reconcile target may itself be\n  163: fork-only, the operative question is **NOT** \"do the fix's target FILES exist\n\n(1 matches)","s":true},{"d":"Grep 'oc-prchecks --wait' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:184:\n  181:      and flags ANY `gh run watch` / hand-rolled nohup CI poller spawn as a\n  182:      law violation (one-watcher law, editor.md) — official surfaces are\n  183:      native detached execution (`background: true`) and one-shot `gh run view`\n>      (for a blocking gate, `oc-prchecks --wait`); also flags\n  185:      `oc-prchecks --wait` used as a verdict waiter (double-duty). Each\n  186:      violation names the session id from the log row. Boundary watch vs A/B: C's dimension is\n  187:      GAPS (what should be a command), not doc wording or weight.\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/review-lenses.md:185:\n  182:      law violation (one-watcher law, editor.md) — official surfaces are\n  183:      native detached execution (`background: true`) and one-shot `gh run view`\n  184:      (for a blocking gate, `oc-prchecks --wait`); also flags\n>      `oc-prchecks --wait` used as a verdict waiter (double-duty). Each\n  186:      violation names the session id from the log row. Boundary watch vs A/B: C's dimension is\n  187:      GAPS (what should be a command), not doc wording or weight.\n  188:      BOUNDARY vs J (v0.4.161): C's object is a PROCEDURE carrying a recurring\n\n(2 matches)","s":true},{"d":"Grep 'DEFAULT_CORPUS' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws:70:\n> DEFAULT_CORPUS=\"SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md\"\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws:232:\n> for f in ${FILES:- $DEFAULT_CORPUS}; do\n\n(2 matches)","s":true},{"d":"Grep 'single source of truth' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-seal-state","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-seal-state:180:\n  179:       # F2 (lens F, v0.4.72): NO hardcoded feature default — the carrier yml is\n>       # the single source of truth (SKILL.md:53); resolve via oc-carrier-features,\n  181:       # abort loudly on read failure (same law as oc-deploy ship).\n\n(1 matches)","s":true},{"d":"Glob /root/.opencrabs/profiles/ops/skills/opencrabs-dev/*.md","o":"No files found matching pattern: /root/.opencrabs/profiles/ops/skills/opencrabs-dev/*.md","s":true},{"d":"Grep 'oc-|tools/' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:22:\n> | `s2-swap-journal-spec.md` | Journal vocabulary spec for the oc-deploy swap leg |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:24:\n> | `tools/` | The `oc-*` tool fleet |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:25:\n> | `tools/lib/` | Shared shell libs: `oc-log.sh` (journal + rc register + flood guard), `oc-embed.sh` (job-embed decoder) |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:26:\n> | `tools/RC-CONTRACT.md` | SOLE per-tool rc register: fleet conventions + verdict codes (v0.4.78) |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:27:\n> | `tools/HEALTH-CHECKS.md` | Systematic health checks registry for the tool fleet |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:28:\n> | `tools/HEALTH-CLASSES.md` | Health classification taxonomy and remediations |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:29:\n> | `tools/tests/run.sh` | Battery: full selftest suite + coverage sections. Receipt → `tools/tests/battery-last.json` |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:30:\n> | `tools/archive/compiler.md` | ARCHIVED runbook for the retired COMPILER role (re-enable = load this file) |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:36:\n> | **EDITOR** | live | Fork issues, per-task worktrees, CI gates, signed commits, `oc-deploy ship`, upstream PRs |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:39:\n> | **TOOLSMITH** | live (v0.4.87 carve-out) | Owns `tools/` CODE — makes and fixes the CLI tools every other role uses, direct recipient of tool quirks/defects (v0.4.176) |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:40:\n> | **COMPILER** | **RETIRED 2026-08-28** (S3 cutover) | duties absorbed by `tools/oc-deploy` (ship / poll / swap-execute) |\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/README.md:44:\n> Full register with rc codes lives in **`","s":true}] -->
<!-- reasoning -->
Good. Now I have:

1. **F1 corpus** — VERIFIED. `DEFAULT_CORPUS` at oc-lint-laws:70 = 11 names. README.md carries live invocations (`bash tools/tests/run.sh` :55/:62, `tools/oc-ledger sync --version X.Y.Z` :65) and is NOT in the corpus NOR in the documented exclusion list (CHANGELOG + war-stories). But — hmm, is README.md "normative law"? The lint comment says corpus = "the skill's normative markdown". README.md is a layout/description file. Hmm. The invocations in README.md (:55, :62, :65) are procedural. So it IS a live-invocation-carrying file outside the lint. That's a real gap. Keep as MED (downgrade from HIGH since all pointer destinations ARE covered).

Actually wait — let me reconsider. The pointer table destinations are: upstream-merge-runbook.md, editor.md, editor-upstream-pr.md, triage.md, toolsmith.md, hq.md, review-lenses.md, s2-swap-journal-spec.md. All 8 are in DEFAULT_CORPUS. So the split did NOT break the corpus. Good — so F1 is really just "README.md is unlinted". Hmm. That's a weaker finding. Is it worth reporting? It's a genuine interface/enumeration gap. But maybe MED is generous; LOW might be more honest. Hmm.

Actually, hold on. Let me reconsider the Lens E framing. Lens E is INTERFACE/TOPOLOGY — the TOOL SURFACE. Is the corpus a tool-surface finding? Marginally. But the report already had it as F1. Let me reframe it as a genuine E finding: **two tools each carry their own hand-enumerated law-file list** — `oc-lint-laws` DEFAULT_CORPUS (11 names, :70) and `oc-review-persist`'s NEXP catalog (its own comment: "the same rot class as the docs-only 21-path list"). That's "a ritual two tools cover in half each" — a Lens E merge candidate: one derived law-file list, consumed by both. And the concrete symptom is README.md escaping the lint. That's a solid E finding. Good.

Hmm, but I must not re-report oc-review-persist:71. Referencing the catalog enumeration as a *sibling list* is fine (different defect), but to be safe, I'll frame F1 around oc-lint-laws + README.md, and mention the two-list duplication lightly. Actually, to be clean and avoid any appearance of re-reporting :71, let me focus F1 on: DEFAULT_CORPUS is hand-enumerated and README.md (a live-invocation file) escapes both the corpus and the exclusion list → the enumeration is a documented rot class. And note the derive-don't-hardcode remedy. I'll skip the oc-review-persist cross-reference to be safe.

Hmm, but then is F1 really Lens E? It's more Lens F (tool code) / A. Hmm. Let me think about what's genuinely E in my findings:

- **F2 (oc-drift-check role-blind reload prescription)** — is this E? It's "a flag/verb that belongs in one tool instead of two"... no. It's more a correctness/staleness issue. Hmm. Actually it could be framed as: `oc-drift-check` hardcodes the reload set, duplicating what `oc-ledger roster --json` (role→uuid) already knows — "a ritual two tools cover in half each". Meh.

Hmm, honestly several of my findings are more "tool correctness/staleness" than pure "interface topology". But the lens brief also says E reviews "the TOOL SURFACE itself". The findings are about the tool surface. I think it's acceptable. Lens F is "TOOL CODE REVIEW" (shell correctness) — my findings aren't shell bugs, they're surface/law-anchor mismatches. So they fit E better than F.

Let me reconsider which findings are strongest and most on-lens:

**E1 — `oc-drift-check` hardcodes a 2-file reload that is wrong for 3 of 4 roles** (tools/oc-drift-check:126, :134). The tool that mechanically triggers the RELOAD LAW prints a role-blind prescription. Post-split the reload set is role file + fleet-directives. This is a genuine interface finding: the tool already can resolve role→uuid (oc-ledger roster), so the prescription should be derived. Solid, quoted. **HIGH.**

Hmm wait, let me double check the verbatim of :126 and :134 — I have from summary: `echo "DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary"` and `echo "NO-HISTORY: no last_acked recorded for $uuid — treat as DRIFT, re-read SKILL.md + editor.md IN FULL before next phase boundary"`. I should re-verify these with a same-turn grep since I'm citing line numbers. Let me re-grep oc-drift-check for "re-read SKILL.md".

**E2 — `oc-prchecks`: one job, two spellings — `wait <ref>` subcommand vs `--wait N` flag** (review-lenses.md:184-185 vs RC-CONTRACT.md:46 / oc-prchecks usage). VERIFIED: `--wait N` is the budget knob (integer, default 600); `wait <ref>` is the blocking-gate subcommand (default budget 2700s, poll 30s). The law text (review-lenses.md:184) prescribes "for a blocking gate, `oc-prchecks --wait`" — which, as written, is missing its integer and is the budget flag, not the waiter. So the law names the wrong surface. This is a real duplicate/ambiguous interface + a law-anchor defect. **MED.**

**E3 — three surfaces answer "which lanes are live / role R's uuid"** (RC-CONTRACT.md:38 oc-ledger roster, :49 oc-roster). The register itself records the set-equality rather than collapsing. **MED.** Hmm, need verbatim. I have from summary RC-CONTRACT.md:49 verbatim and :38 verbatim. But I should re-verify with a same-turn grep to be safe. Let me grep RC-CONTRACT.md for "set-equal".

**E4 — `oc-seal-state:180` anchors on `SKILL.md:53`** — VERIFIED verbatim: `# the single source of truth (SKILL.md:53); resolve via oc-carrier-features,`. Line-number anchor into the most volatile file. **MED/LOW.** This is a "law anchor" finding, arguably lens A/brain-scrub territory, but it's a tool-surface defect (a tool citing a line number). Hmm — the brief says E reviews the tool SURFACE; a stale line-number anchor in a tool comment is borderline F. Hmm. But lens I-4.2 (evidence discipline) forbids it. It's weak for E. Maybe LOW.

**E5 — `oc-health` cron liveness by NAME → silent no-op** — VERIFIED still unfixed: oc-health:772 `WHERE enabled=0 AND name IN ('harvest-watch-4h','oc-roster-detached-sweep','oc-health-hourly')`. And `harvest-watch-4h` is the STALE name (renamed to `oc-harvest-dispatch-4h` per the law). So the liveness check can never report the renamed patrol disabled. **MED.** This touches the census/patrol surface (E's standing extra spirit). Strong, verified.

**E6 — `oc-upstream-delta` JSON mode suppresses subjects** — LOW. This is the standing-extra object. VERIFIED from summary: both emit blocks are inside `if [ "$JSON_OUT" -eq 0 ]`. Hmm, I should re-verify. Let me re-read oc-upstream-delta (it's small, 1336 B). Actually I read it fully before; summary says: "in --json mode the BASE/AHEAD/BEHIND TSV and the C <sha7> <subject> rows are suppressed (both inside if [ "$JSON_OUT" -eq 0 ])". A JSON consumer gets counts + absorbed pairs but no subjects. Is that a defect? The JSON mode still emits absorbed pairs presumably. Hmm — if JSON carries the counts and pairs, subjects may be intentionally omitted (subjects are human-readable). Weak. Probably drop or LOW.

OK. Given ≤6000 chars and 4-6 findings, let me pick: E1 (HIGH), E2 (MED), E5 (MED), E3 (MED), E4 (LOW), and maybe E6 (LOW). That's 6. Let me aim for 5 solid ones: E1, E2, E5, E3, E4. And mention E6 briefly? Space permitting.

Actually, let me reconsider F1 (corpus). Is it better than E4 (seal-state line anchor)? The corpus finding is a real interface/enumeration defect with a clear "derive not hardcode" fix and a demonstrable escapee (README.md). E4 is a stale line anchor. Hmm. Both MED/LOW. I'll include the corpus one and maybe drop E4 or keep both as LOW.

Let me settle on:
1. **HIGH** — oc-drift-check role-blind reload prescription (E1)
2. **MED** — oc-prchecks wait/--wait two spellings + law names the flag (E2)
3. **MED** — oc-health cron liveness by NAME, stale name `harvest-watch-4h` (E5)
4. **MED** — three roster resolvers (E3)
5. **LOW** — oc-lint-laws DEFAULT_CORPUS hand-enumerated; README.md escapes (F1)
6. **LOW** — oc-seal-state SKILL.md:53 line anchor (E4)

That's 6. ≤6000 chars — need to be terse. Maybe drop to 5 by merging or dropping E4. Let me keep 5: drop E4 (weakest, most F-flavored) OR drop F1. Hmm. Let me keep 5: E1, E2, E5, E3, F1. And mention E4 in one line under Coverage? No — quote-or-no-finding, and coverage should list what was read. I'll include E4 as a 6th only if space. Let me draft and check length.

Before writing, I must re-verify the verbatim quotes I'm citing with same-turn receipts (I have most from the summary but the law says same-turn). Let me re-grep:
- oc-drift-check for "re-read SKILL.md" (get exact lines + numbers)
- RC-CONTRACT.md for "set-equal" / roster rows (get verbatim + line)
- oc-upstream-delta — read it (small) to verify the JSON suppression, in case I include it.

Also I want the exact verbatim for RC-CONTRACT.md:49 and :38. Let me grep.

Let me batch: grep oc-drift-check "re-read SKILL.md"; grep RC-CONTRACT.md "set-equal"; read oc-upstream-delta (full); grep RC-CONTRACT.md "roster \[--role".

Let me do it.
<!-- /reasoning -->

Verified: `oc-prchecks` accepts `--wait N` (budget knob) **and** a `wait <ref>` subcommand — different jobs. `oc-health:772` still queries crons by NAME with the stale `harvest-watch-4h`. Now re-acquiring the last quotes same-turn.


<!-- tools-v2: [{"d":"Grep 're-read SKILL.md' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-drift-check","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-drift-check:126:\n  125:   if [ \"$no_history\" = \"1\" ]; then\n>     echo \"NO-HISTORY: no last_acked recorded for $uuid — treat as DRIFT, re-read SKILL.md + editor.md IN FULL before next phase boundary\"\n  127:     oc_log_extra verdict NO-HISTORY\n\n/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-drift-check:134:\n  133:   fi\n>   echo \"DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary\"\n  135:   oc_log_extra verdict DRIFT\n\n(2 matches)","s":true},{"d":"Grep 'set-equal' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md:49:\n  47: | oc-rebase-safety | 0 | 2 | overlap: 0 zero-overlap (gate-skip permitted per re-gate split law n=2259) / 1 overlap-found (gate-required) / 3 git-fail. audit: 0 clean / 1 losses (DROPPED or CHANGED rows on stdout) / 3 git-fail. Read-only plumbing; exit 1 is a VERDICT (house rule, oc-upstream-delta class). **Output shape (#22, 2026-09-12 — two lanes misled in one hour):** the conservative path (no `--tree`, or a single-parent tip) cannot derive the branch-side set, so it treats the FULL main-shift set as overlapping — that list is therefore **NOT an intersection**, and it used to print bare under a heading that read as an overlap verdict. A real overlap of ZERO was read as a file collision by two lanes (6630dc9a flagged it; 462181e9 nearly filed a false collision). Now: the conservative path heads its list `MAIN-SHIFT (not an overlap — merge-changed set unknown for a single-parent HEAD)` and the verdict line says outright that the list above is NOT an intersection; the real-intersection path heads its list `OVERLAP (real intersection of main-shift and branch-side)` and prints ONLY the intersected files. The verdict logic is unchanged — only the label was the defect. Nothing parses this stdout (the one consumer, oc-deploy, calls `audit`). Selftest asserts both shapes and the cross-checks (real is not labelled MAIN-SHIFT, conservative is not labelled real). |\n  48: | oc-review-persist | 0 | 2 / 3 / 4 | 0 persisted (re-read verified) / 2 usage (bad lens/empty input) / 3 re-read sha256 mismatch (storage NOT trusted) / 4 write-fail (mkdir/write/index-append); check-cycle: 0 census complete / 2 usage / 3 catalog UNDERIVABLE (refuses to call a cycle clean off an unreadable catalog) / 5 lens(es) missing -- unreceipted (canonical name, no index line) and UNPERSISTED (report present under a non-canonical name) fail only under --strict-receipt |\n> | oc-roster | 0 | 2 | 0 ok / 3 unreadable source (","s":true},{"d":"Read ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-upstream-delta","o":"#!/usr/bin/env bash\n# =============================================================================\n# oc-upstream-delta — watch-cycle arithmetic for SKILL.md §Upstream relations\n# (KERNEL C6, 2026-08-29 four-lens review run-2; design:\n# /root/oc-work/oc-upstream-delta-design-20260829.md).\n#\n# Replaces the hand-derived fetch/merge-base/rev-list sequence two lanes had\n# started drifting on. READ-ONLY: fetch + plumbing only. NEVER merges, pushes,\n# or rebases. PROPOSE/WAIT judgment stays HUMAN (owner-word gates, AGENTS.md\n# upstream-relations cluster) — exit 1 is a VERDICT, not an error.\n#\n# Usage:\n#   oc-upstream-delta [--repo P] [--fork-origin R] [--upstream R] [--json] [--no-log]\n#   oc-upstream-delta --selftest      offline fixtures (local remotes only)\n#\n# Output: TSV lines on stdout —\n#   BASE <sha7> / AHEAD <n> / BEHIND <n>\n#   C <sha7> <subject>          (BEHIND list first, then AHEAD list)\n#   ABSORBED-CANDIDATE <fork-sha7> <upstream-sha7>   (patch-id match)\n# Human summary on stderr: \"clean\" or \"delta ahead=N behind=M absorbed=K\".\n#\n# Exit: 0 clean (0/0) / 1 delta present / 2 usage / 3 fetch-or-git failure\n# =============================================================================\nset -u\nset -o pipefail   # F7 (lens F, v0.4.72): pipeline failures are never masked\n_OC_LIB=\"$(cd \"$(dirname \"$0\")\" && pwd)/lib/oc-log.sh\"\nif [ -f \"$_OC_LIB\" ]; then source \"$_OC_LIB\"; oc_log_init \"oc-upstream-delta\" \"$@\"; else oc_log_finish() { :; }; fi\ntrap 'oc_log_finish $?' EXIT\n\nPROG=\"$(basename \"$0\")\"\nGIT_BIN=\"${OC_GIT:-git}\"\nREPO=\"${HOME}/opencrabs\"\nFORK_REMOTE=\"origin\"\nUP_REMOTE=\"adolfousier\"\nJSON_OUT=0\n\nusage() {\n  cat >&2 <<EOS\nUsage: $PROG [--repo P] [--fork-origin R] [--upstream R] [--json] [--no-log]\nExit: 0 clean / 1 delta (verdict) / 2 usage / 3 fetch-or-git failure\nEOS\n  exit 2\n}\n\n# ---------- selftest (offline fixture repos, real git, no network) ------------\nmkfix() { # emits fixture root on stdout: w repo with origin->fork.git, adolfousier->up.git\n  local F; F","s":true},{"d":"Grep 'roster \\[--role' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md","o":"No matches found for pattern: 'roster \\[--role'","s":true}] -->
<!-- reasoning -->
Now I have the oc-upstream-delta full source. Key: the `--json` mode emits base/ahead/behind/absorbed/absorbed_candidates but NOT the commit subjects (`C <sha7> <subject>` rows) — those are gated by `if [ "$JSON_OUT" -eq 0 ]`. So a JSON consumer gets counts + absorbed pairs but no commit subjects for the non-absorbed delta. Hmm — is that a defect? For the standing-extra (silent drift), the consumer needs to know WHICH commits are behind. The absorbed_candidates give pairs only for patch-id matches; unabsorbed behind commits appear as counts only. So a JSON consumer cannot list the non-absorbed upstream commits. That IS a real gap for a drift-census JSON consumer. But is it a defect or intentional? The design comment says "Output: TSV lines on stdout". The JSON mode is a later addition. Since the absorbed pairs are included in JSON, the asymmetry (subjects omitted) is arguably a defect: JSON should carry the same information as TSV. This is a genuine E finding (a flag mode that suppresses part of the surface). LOW/MED. Actually it's decent: "the `--json` flag is a second output surface that carries less than the default — a JSON consumer cannot enumerate the behind/ahead commits."

Hmm, but note also: `emit_commits` takes `$2=tag` but never uses it. Minor.

Also the header comment says "Human summary on stderr" — fine.

Now, the RC-CONTRACT.md:49 oc-roster row verbatim (I have it): 
`| oc-roster | 0 | 2 | 0 ok / 3 unreadable source (session DB, ledger, or \`oc-wt\`) · DERIVED in-progress roster (2026-09-11, plan step 1 fork-rebase gate): joins ledger \`events[kind=claim]\` (INTENT) + \`oc-wt list\` dirty (EVIDENCE) + session-DB liveness (LIVENESS) + forum bindings (SCOPE) into one classified table. Verbs \`live [--detail]\` (liveness only — set-equal to the \`oc-notify-fanout\` v0.4.129 query), \`forum [--detail]\`, \`claims\`, \`work\`, \`classify [--json]\` (TSV uuid/role/signals/class; classes ACTIVE/IDLE/ORPHAN/UNKNOWN — UNKNOWN is ESCALATED to the owner, never guessed). A claim author the session DB has never seen is a PHANTOM: reported on stderr, EXCLUDED from every class (a hand-assembled frankenstein uuid can never enter a freeze list — n=2221 class). Stores nothing; \`--selftest\` runs 44 offline fixture checks |`

And I need the oc-ledger roster row verbatim. The summary says RC-CONTRACT.md:38. My grep for `roster \[--role` returned no matches — because of the `[` bracket in the pattern (literal mode, `[--role` is a char class). Let me re-grep with a safer pattern: `roster .--role` or just `roster`. Let me grep RC-CONTRACT.md for "role → FULL uuid" or "role.*uuid".

Actually the summary quote for :38 was: `` `roster [--role <substr>] [--live] [--include-retired] [--json]`: role → FULL uuid resolution; TSV uuid/role/topic/feature/ack, `--live` keeps only live sessions ``. Let me verify with a grep on "FULL uuid".

Let me also verify the oc-lint-laws comment lines 66-69 verbatim (the corpus rationale). Let me grep.

And the fleet-directives "Work orders" — my earlier grep for fleet-directives showed the pointer table and thematic index but the "Work orders" heading check: I found the thematic index lists sections; `## Work orders` — the oc-ledger:2260 comment cites "fleet-directives.md §Work orders". Is there a `§Work orders` section? The thematic index has "**Smoke & dispatch:** Out-of-Feature-Set Issues · Dispatch Eligibility · Attribution & Goal Hygiene ...". No "Work orders". Hmm. But maybe it's a `### Work orders` subsection under some heading. Let me grep fleet-directives.md for "Work order".

Let me batch the remaining verifications:
- grep RC-CONTRACT.md "FULL uuid"
- grep oc-lint-laws "The LAW corpus" with context
- grep fleet-directives.md "Work order"
- grep hq.md "bump steps"

Let me run.
<!-- /reasoning -->

`oc-upstream-delta --json` confirmed: the `C <sha7> <subject>` rows sit inside `if [ "$JSON_OUT" -eq 0 ]`, so JSON consumers get counts + absorbed pairs but no commit subjects. Last batch of quote verification.


<!-- tools-v2: [{"d":"Grep 'FULL uuid' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/RC-CONTRACT.md:38:\n> | oc-ledger | 0 | 2 | 0 ok / 1 verdict (cadence FIRE / version mismatch / `roster` or `events` NO-MATCH) / 3 ledger / 4 write / 5 battery-gate / 6 version-sync-gate · `--verbs`: lists registered subcommands; unrecognized verbs emit vocabulary hints on stderr; rc 0 · `claims <N>`: open claim-refs by issue, empty output + rc 0 = clean/unclaimed; rc 2 usage, rc 3 ledger; **c6b1a539 residual (2026-09-12): 30 of 130 live claim rows were invisible and/or unclosable — two independent mechanisms, measured live (21 carried no `#N` in `what`, 20 the `(unattributed…` sentinel as `by`, overlap 11). (a) Refs match by TOKEN, never substring: `claims 76` no longer matches a claim on `#760` — the old `*\"#${n}\"*` glob was a false POSITIVE as well as a false CLEAN. Accepted ref forms: `#N`, `issue N`, `issue=N`, `issue#N`. (b) A claim whose `by` is the sentinel is closed by ANY later closer referencing the same #N — the actor test is DROPPED for it, because an unattributed claim has no actor to discriminate on; an ATTRIBUTED claim still requires its own actor, so this cannot over-close. (c) `_latest_claim_issue` (and therefore `claim-ref`, and `confirm`, which delegates there) uses the same token extractor: the old first-`#<digits>`-anywhere grep both missed the no-hash forms AND derived the WRONG issue from a passing mention (live n=1585: `issue 94` + a `#93` mention derived 93). Measured over 130 rows: 109 old-resolved — 108 same, 1 corrected, 0 lost; 6 newly resolve** · `sweep-closed-claims [--dry-run]`: inspects open claims against closed issues on GitHub/fork and reports or marks stale claims closed; **Defect #272 (2026-09-17, Toolsmith): replaced naive `re.search(r\"#?(\\d+)\", what)` with `issue_ref_tokens(what)` to prevent false-negative token extraction on date prefixes (`2026-09-15`), repo owner handles (`leshchenko1979`), or hex UUID prefixes, and added multi-ref support (`#38, #80`) so claims refer","s":true},{"d":"Grep 'LAW corpus' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-lint-laws:66:\n  64: SKILL_DIR=\"$(dirname \"$TOOLS_DIR\")\"\n  65: \n> # The LAW corpus: the skill's normative markdown. Two exclusions, both\n  67: # deliberate — CHANGELOG.md and war-stories.md quote historical invocations that\n  68: # were correct when written and may legitimately name a retired flag; failing on\n\n(1 matches)","s":true},{"d":"Grep 'Work order' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md","o":"No matches found for pattern: 'Work order'","s":true},{"d":"Grep 'Work orders' in ~/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger","o":"/root/.opencrabs/profiles/ops/skills/opencrabs-dev/tools/oc-ledger:2260:\n>   # triage.md, fleet-directives.md §Work orders) as THE dynamic way to resolve\n\n(1 matches)","s":true}] -->
<!-- reasoning -->
Now I have all the quotes. Let me confirm:
- `oc-ledger:2260`: `# triage.md, fleet-directives.md §Work orders) as THE dynamic way to resolve` — and grep for "Work order" in fleet-directives.md → **No matches found**. So `§Work orders` does NOT exist in fleet-directives.md. This is a real stale anchor (LOW). Thematic index doesn't list it either. Confirmed.

Hmm wait — the fleet-directives grep for "Work order" returned no matches. Good — so the section `§Work orders` genuinely does not exist. That's a confirmed stale anchor. But it's LOW and arguably lens A. Include as LOW maybe.

Now let me decide the final findings. I have strong verified quotes for:

**F1 (HIGH) — oc-drift-check hardcodes a role-blind reload prescription.**
Locator: `tools/oc-drift-check:126` and `:134`.
Verbatim: `echo "DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary"` (and the NO-HISTORY twin at :126).
Why: the tool mechanically triggers the RELOAD LAW; it names `editor.md` — the EDITOR role file — for EVERY role. A Triage/Toolsmith/HQ lane gets told to re-read the wrong role file, and no lane is told to re-read fleet-directives.md, where post-split the cross-role `[LANE]` law now lives. Also `oc-drift-check:78` already delegates to `oc-ledger roster` (role→uuid), so the role is knowable at the point the message is printed.
Fix: derive the prescription from the lane's role; single-command shape `oc-drift-check <uuid> --ack` prints the role-correct file list.

**F2 (MED) — oc-prchecks: one job, two interfaces; the law names the wrong one.**
Locator: `review-lenses.md:184` vs `tools/RC-CONTRACT.md:46` / `tools/oc-prchecks:24,200`.
Verbatim (review-lenses.md:184): `(for a blocking gate, \`oc-prchecks --wait\`); also flags` and (:185) `` `oc-prchecks --wait` used as a verdict waiter (double-duty). ``
Verbatim (oc-prchecks:24): `#   oc-prchecks [<branch-or-sha> | resume <run-id> | wait <ref>] [--wait N] [--budget N] [--poll S] ...`
Verbatim (oc-prchecks:200): `wait <ref>       single-invocation wait/watch loop with budget (default 2700s, poll 30s) — Cycle 5 C-1`
Why: `--wait N` is the poll-budget knob (integer; usage diagnostic "--wait needs an integer", :334); the blocking-gate waiter is the SUBCOMMAND `wait <ref>` with its own default budget. The law prescribes `oc-prchecks --wait` — bare, no N — which is not a runnable blocking gate (it needs an integer) and denotes the budget flag, not the waiter. One job, two spellings, and the law file lanes copy from names the wrong one.
Fix: make one spelling canonical (the `wait <ref>` subcommand), alias the other with a warning, align review-lenses.md:184–185 + RC-CONTRACT.md:46 in the same edit.

**F3 (MED) — oc-health cron-liveness queries by NAME → a renamed patrol silently escapes.**
Locator: `tools/oc-health:772`.
Verbatim: `cron_bad="$(sqlite3 "$DB" "SELECT name FROM cron_jobs WHERE enabled=0 AND name IN ('harvest-watch-4h','oc-roster-detached-sweep','oc-health-hourly');" 2>/dev/null)"`
Why: the health census's cron-liveness check matches on NAME, and it carries the STALE name `harvest-watch-4h` — the harvest patrol the law renamed (id `73158e43-…`). A patrol renamed or disabled under a new name matches zero rows, so the check reads "clean" and the census goes blind — the exact "never start blind" class. CHANGELOG v0.4.203 already records this as a fixed same-class defect in the harvest patrol's own surface; this row is the oc-health instance, unfixed.
Fix: resolve patrol crons by job ID; a name matching zero rows must be a FINDING, never clean.
Note: also line 146-149 selftest fixtures still create `harvest-watch-4h`.

Hmm wait — is this "unfixed"? CHANGELOG v0.4.203 says "Same-class fix dispatched to Toolsmith (tools/oc-health:772 + HEALTH-CLASSES.md:91)." So a fix was DISPATCHED. But the live file at :772 still queries by NAME with the stale name. So it's unfixed in the file. That's a real finding — "dispatched but not landed". Good, and verified live. Keep MED.

**F4 (MED) — three surfaces answer "which lanes are live / role R's uuid".**
Locators: `tools/RC-CONTRACT.md:38` (oc-ledger `roster`) and `:49` (oc-roster).
Verbatim (:38): `` `roster [--role <substr>] [--live] [--include-retired] [--json]`: role → FULL uuid resolution; TSV uuid/role/topic/feature/ack, `--live` keeps only live sessions ``
Verbatim (:49): `Verbs `live [--detail]` (liveness only — set-equal to the `oc-notify-fanout` v0.4.129 query), `forum [--detail]`, `claims`, `work`, `classify [--json]` …`
Why: `oc-ledger roster` (role→uuid; the schema owner of `last_acked`), `oc-roster` (its own derived `live`/`claims`/`work`/`classify`), and `oc-notify-fanout`'s internal target query (whose v0.4.129 result `oc-roster live` claims set-equality with) all answer overlapping questions. The register RECORDS the equivalence instead of collapsing it — so a lane must know which of three to call and can get different answers. `oc-roster claims` additionally collides by name with `oc-ledger claims <N>` (open claim-refs by issue) while meaning something else. `oc-drift-check`'s D-5 omit-arg mode already binds to `oc-ledger roster --json` as "the schema owner" — the duplication is load-bearing and undocumented as such.
Fix: one roster verb (the schema-owning one) with sub-selectors (`--live`, `--forum`, `--claims`, `--classify`); have `oc-roster`/`oc-notify-fanout` delegate to it. Single-command shape: `oc-ledger roster --live --json`.

**F5 (LOW) — oc-lint-laws corpus is a hand-enumerated list; README.md escapes it.**
Locator: `tools/oc-lint-laws:70`.
Verbatim: `DEFAULT_CORPUS="SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md"`
Supporting verbatim (:66-68): `# The LAW corpus: the skill's normative markdown. Two exclusions, both` / `# deliberate — CHANGELOG.md and war-stories.md quote historical invocations that` / `# were correct when written and may legitimately name a retired flag; failing on`
Why: the corpus claims to be "the skill's normative markdown" with exactly two documented exclusions, but `README.md` is neither in the corpus nor in the exclusion list, and it carries live invocations (`bash tools/tests/run.sh` at :55/:62; `tools/oc-ledger sync --version X.Y.Z --why "..."` at :65). The lint exists so "a law that names a verb the tool refuses is a dead channel" is caught mechanically; a law file outside the enumeration is a blind spot. (All 8 pointer-table destinations ARE covered, so the split did not break the corpus — the hazard is the enumeration itself.)
Fix: derive the corpus at gate time (glob the skill root's normative `*.md` minus an explicit non-law exclusion list) instead of hardcoding 11 names.

**F6 (LOW) — oc-seal-state anchors on SKILL.md by line number.** Or **oc-upstream-delta --json drops subjects.** Hmm. Space. Let me pick one. Actually I think F6 should be the `oc-ledger:2260` stale `§Work orders` anchor, since it's a confirmed non-existent section (grep "Work order" in fleet-directives → 0). Hmm, but that's lens A/anchors.

Hmm, actually — let me reconsider. The report should be Lens E (interface/topology). Which of my findings are genuinely interface/topology?
- F2 (oc-prchecks wait vs --wait) — YES, classic "one job two interfaces / a flag duplicating a verb".
- F4 (three roster resolvers) — YES, classic "a ritual two tools cover in half each" / duplicate surfaces.
- F1 (drift-check role-blind prescription) — partially; it's about a tool's output prescribing an action; the interface angle is "the tool already knows the role (via oc-ledger roster) but hardcodes".
- F3 (oc-health by name) — a census-surface blind spot; more correctness than interface.
- F5 (corpus enumeration) — more correctness.
- F6 (seal-state line anchor / ledger §Work orders) — anchor staleness, lens A/I.

Given the brief says E reviews the TOOL SURFACE and includes the upstream-drift census (standing extra), I think F1–F5 are fine, and I'll include the oc-upstream-delta JSON one as part of the standing-extra coverage (F6, LOW), since that's explicitly in E's remit. Actually the standing extra is specifically the oc-upstream-delta patrol OUTPUT — so an oc-upstream-delta finding is squarely in-remit. Let me include it.

But ≤6000 chars is tight with 6 findings. Let me estimate: header ~60, verdict ~80, each finding ~450-600, coverage ~700. 6 findings × 500 = 3000 + 800 = ~3900. OK, fits. Let me include 6: F1 HIGH, F2 MED, F3 MED, F4 MED, F5 LOW, F6 LOW (upstream-delta). And mention seal-state:180 + oc-ledger:2260 briefly? No — quote-or-no-finding; I have quotes for those too but space. I'll drop them or put a one-line "also observed" — no, that violates quote-or-no-finding. Drop them. Actually I could include oc-seal-state as a 7th LOW but that risks length. Let me keep 6 and drop seal-state/ledger-2260. Hmm, or swap F5 (corpus) for seal-state? The corpus finding is weaker on-lens but has a concrete escapee. I'll keep the corpus one and drop seal-state.

Hmm, actually let me reconsider F3's on-lens-ness once more. oc-health's cron check is the health census surface. E's standing extra is about the upstream-drift census. Close enough — I'll frame F3 as "the census/patrol surface". Keep.

Now let me write the report, ≤6000 chars, exact shape.

Let me be careful with the mandated shape:
`# Lens E - cycle 20260919-cycle`
`## Verdict: <one line>`
`## Findings`
For each: `**`[HIGH|MED|LOW] <title>**` . locator `<file>:<line>` . VERBATIM QUOTE (mandatory) . why it is a defect . suggested fix
`## Coverage` ...

Let me draft concisely. I'll use the format: `**[HIGH] Title** — locator ...` then quote then why then fix.

Let me write it.

Draft:

# Lens E - cycle 20260919-cycle

## Verdict: 6 evidenced tool-surface defects — 1 HIGH (a mechanical reload trigger that prescribes the wrong law for 3 of 4 roles), 3 MED (a two-spelling interface the law gets wrong; a census check blind to renames; three roster resolvers), 2 LOW. No blocker; F1 is the one worth landing before the next reload cycle.

## Findings

**[HIGH] `oc-drift-check` hardcodes a role-blind reload prescription — the tool that triggers the RELOAD LAW tells 3 of 4 roles to re-read the wrong file.**
locator `tools/oc-drift-check:134` (twin at `:126`)
VERBATIM: `echo "DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary"`
`:126`: `echo "NO-HISTORY: no last_acked recorded for $uuid — treat as DRIFT, re-read SKILL.md + editor.md IN FULL before next phase boundary"`
why: `editor.md` is the EDITOR role file. A Triage / Toolsmith / HQ lane hitting DRIFT is ordered to re-read a file it does not own and is never told to re-read `fleet-directives.md`, where the cross-role `[LANE]` law now lives (post-2026-09-18 split). The lane looks compliant while having read none of its own reload set. The role IS knowable at that point — the tool already delegates to `oc-ledger roster` (`:78`).
fix: derive the prescription from the lane's role (`oc-ledger roster --json` → role → uuid) and print `re-read SKILL.md + <role>.md + fleet-directives.md IN FULL`; shape: `oc-drift-check <uuid> --ack` prints the role-correct list.

**[MED] `oc-prchecks`: one job under two interfaces — the law names the flag, the runnable waiter is the subcommand.**
locator `review-lenses.md:184` vs `tools/oc-prchecks:24` + `:200`
VERBATIM (law): `(for a blocking gate, `oc-prchecks --wait`); also flags`
VERBATIM (`:185`): `` `oc-prchecks --wait` used as a verdict waiter (double-duty). ``
VERBATIM (`:24`): `#   oc-prchecks [<branch-or-sha> | resume <run-id> | wait <ref>] [--wait N] [--budget N] [--poll S] [--repo SLUG-or-PATH] [--carrier C] [--no-log]`
VERBATIM (`:200`): `wait <ref>       single-invocation wait/watch loop with budget (default 2700s, poll 30s) — Cycle 5 C-1`
why: `--wait N` is the poll-budget knob and demands an integer (usage diagnostic `--wait needs an integer`, `:334`); the blocking-gate waiter is the SUBCOMMAND `wait <ref>` with its own 2700s default. The law lanes copy from prescribes `oc-prchecks --wait` — bare, no N — which is not the runnable gate and denotes the budget flag, not the waiter. One job, two spellings, and the law picks the wrong one.
fix: make `wait <ref>` canonical, alias `--wait`-as-verb with a warning, align `review-lenses.md:184–185` + `RC-CONTRACT.md:46` in one edit.

**[MED] `oc-health` cron-liveness queries by NAME and carries a stale name — a renamed patrol reads as clean.**
locator `tools/oc-health:772`
VERBATIM: `cron_bad="$(sqlite3 "$DB" "SELECT name FROM cron_jobs WHERE enabled=0 AND name IN ('harvest-watch-4h','oc-roster-detached-sweep','oc-health-hourly');" 2>/dev/null)"`
why: `harvest-watch-4h` is the patrol's OLD name (renamed per the cron-namespacing law; id `73158e43-…` survives the rename). A patrol renamed or disabled under a new name matches zero rows, so the census reports "crons: law-carrying enabled, zero DM leaks" and can never report it disabled — the "never start blind" class. CHANGELOG v0.4.203 records this exact defect as *dispatched* to Toolsmith; the live file is unfixed.
fix: resolve patrol crons by job ID, not name; a name matching zero rows must be a FINDING, never clean.

**[MED] Three surfaces answer "which lanes are live / role R's uuid".**
locators `tools/RC-CONTRACT.md:38` (oc-ledger) and `:49` (oc-roster)
VERBATIM (`:38`): `` `roster [--role <substr>] [--live] [--include-retired] [--json]`: role → FULL uuid resolution; TSV uuid/role/topic/feature/ack, `--live` keeps only live sessions ``
VERBATIM (`:49`): `Verbs `live [--detail]` (liveness only — set-equal to the `oc-notify-fanout` v0.4.129 query), `forum [--detail]`, `claims`, `work`, `classify [--json]` …`
why: `oc-ledger roster` (role→uuid, schema owner of `last_acked`), `oc-roster` (its own derived `live`/`claims`/`work`/`classify`), and `oc-notify-fanout`'s internal target query all answer overlapping questions; the register RECORDS the set-equality instead of collapsing it. A lane must know which of three to call and can get different answers. `oc-roster claims` also collides by name with `oc-ledger claims <N>` (open claim-refs by issue) while meaning something else. `oc-drift-check`'s D-5 mode already binds `oc-ledger roster --json` as "the schema owner" — the duplication is load-bearing and undocumented as such.
fix: one roster verb (the schema-owning one) with `--live/--forum/--claims/--classify` selectors; `oc-roster` and `oc-notify-fanout` delegate. Shape: `oc-ledger roster --live --json`.

**[LOW] `oc-lint-laws` corpus is a hand-enumerated list; `README.md` sits outside it and outside the exclusion list.**
locator `tools/oc-lint-laws:70`
VERBATIM: `DEFAULT_CORPUS="SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md"`
VERBATIM (`:66`): `# The LAW corpus: the skill's normative markdown. Two exclusions, both`
why: the corpus claims to be the skill's normative markdown with exactly two documented exclusions (CHANGELOG, war-stories), but `README.md` is in neither and carries live invocations (`bash tools/tests/run.sh`, `:55/:62`; `tools/oc-ledger sync --version X.Y.Z --why "..."`, `:65`). The lint exists so a law naming a verb the tool refuses is caught mechanically; a law file outside the enumeration is a blind spot. All 8 pointer-table destinations ARE covered — the hazard is the enumeration, not the split.
fix: derive the corpus at gate time (glob the root's normative `*.md` minus an explicit non-law list) instead of hardcoding 11 names.

**[LOW] `oc-upstream-delta --json` suppresses the commit list — a JSON drift consumer gets counts but no subjects.**
locator `tools/oc-upstream-delta` (the `emit_commits` guard)
VERBATIM: `if [ "$JSON_OUT" -eq 0 ]; then` / `  emit_commits "$FORK_REF..$UP_REF" behind   # what upstream gained, first`
why: the `C <sha7> <subject>` rows are emitted only when `JSON_OUT=0`. The `--json` payload carries `base/ahead/behind/absorbed/absorbed_candidates` but no subjects, and `absorbed_candidates` covers only patch-id twins — so a JSON consumer cannot enumerate the non-absorbed commits that are BEHIND. For the standing-extra (the drift census must never start blind) the machine-readable mode is the one a monitor would use.
fix: include a `behind_commits`/`ahead_commits` array (sha7+subject) in the JSON payload, mirroring the TSV.

## Coverage

Read: `tools/` + `tools/lib/` listings; `review-lenses.md` (E brief 194–206 + C/D/F/I/brain-scrub); `README.md`; `fleet-directives.md` (head + pointer table + thematic index); `RC-CONTRACT.md` (rows for oc-commit, oc-deploy, oc-drift-check, oc-harvest-census, oc-harvest-dispatch, oc-health, oc-issue-dispatch, oc-ledger, oc-lint-laws, oc-notify-fanout, oc-prchecks, oc-review-persist, oc-roster, oc-ship-chain, oc-skew-scan, oc-start, oc-smoke, oc-smoke-evidence); `oc-review-persist` (0–130); `oc-upstream-delta` (full); `oc-lint-laws` (partial); grep extracts of `oc-drift-check` / `oc-ledger` / `oc-ship-chain` / `oc-notify-fanout`; `CHANGELOG.md` (v0.4.202–205); `reviews/` listing + `20260919-cycle/state.json`.

NOT read: `tools/tests/run.sh`, `tools/lib/*.sh`, `HEALTH-CHECKS.md`, `HEALTH-CLASSES.md`, `tools/archive/*`; bodies of `oc-deploy` / `oc-ship-chain` / `oc-ledger` / `oc-notify-fanout` / `oc-health` / `oc-harvest-*` (grep extracts only); `SKILL.md`, `editor.md`, `hq.md`, `triage.md`, `toolsmith.md`, `upstream-merge-runbook.md`, `s2-swap-journal-spec.md`, `war-stories.md`. `oc-review-persist:71` deliberately NOT re-reported (owned by Toolsmith).

Let me count characters roughly. This is likely ~5500-6000. Let me trim to be safe. I'll tighten some.

Actually let me count more carefully. The draft is long. Let me estimate: it's maybe 6200-6800 chars. Need to trim to ≤6000. Let me cut:
- Shorten the verdict.
- Trim F4 and F5 prose.
- Trim coverage (list RC-CONTRACT rows more compactly).

Let me write a tightened version and count. I'll aim for ~5600.

Let me carefully compose and count in my head by lines... hard. Let me just write tightly.

Tightened:

# Lens E - cycle 20260919-cycle

## Verdict: 6 evidenced tool-surface defects — 1 HIGH (a mechanical reload trigger that prescribes the wrong law for 3 of 4 roles), 3 MED, 2 LOW. Nothing blocking; F1 is the one to land before the next reload cycle.

## Findings

**[HIGH] `oc-drift-check` hardcodes a role-blind reload — the tool that triggers the RELOAD LAW names the wrong file for 3 of 4 roles.**
locator `tools/oc-drift-check:134` (twin `:126`)
VERBATIM: `echo "DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary"`
VERBATIM (`:126`): `echo "NO-HISTORY: no last_acked recorded for $uuid — treat as DRIFT, re-read SKILL.md + editor.md IN FULL before next phase boundary"`
why: `editor.md` is the EDITOR role file. A Triage/Toolsmith/HQ lane hitting DRIFT is ordered to re-read a file it does not own and is never told to re-read `fleet-directives.md`, where the cross-role `[LANE]` law lives post-split. It looks compliant having read none of its own reload set. The role IS knowable there — the tool already delegates to `oc-ledger roster` (`:78`).
fix: derive the prescription from the lane's role (`oc-ledger roster --json`) and print `re-read SKILL.md + <role>.md + fleet-directives.md IN FULL`; shape `oc-drift-check <uuid> --ack` prints the role-correct list.

**[MED] `oc-prchecks`: one job, two interfaces — the law names the flag; the runnable waiter is the subcommand.**
locator `review-lenses.md:184` vs `tools/oc-prchecks:24` + `:200`
VERBATIM (law): `(for a blocking gate, `oc-prchecks --wait`); also flags` / (`:185`) `` `oc-prchecks --wait` used as a verdict waiter (double-duty). ``
VERBATIM (`:24`): `#   oc-prchecks [<branch-or-sha> | resume <run-id> | wait <ref>] [--wait N] [--budget N] [--poll S] …`
VERBATIM (`:200`): `wait <ref>       single-invocation wait/watch loop with budget (default 2700s, poll 30s) — Cycle 5 C-1`
why: `--wait N` is the poll-budget knob and demands an integer (usage diagnostic `--wait needs an integer`, `:334`); the blocking-gate waiter is the SUBCOMMAND `wait <ref>` (own 2700s default). The law lanes copy from prescribes `oc-prchecks --wait` — bare, no N — not a runnable gate, and denoting the budget flag rather than the waiter. One job, two spellings, wrong one documented.
fix: make `wait <ref>` canonical; alias the other with a warning; align `review-lenses.md:184–185` + `RC-CONTRACT.md:46` in one edit.

**[MED] `oc-health` cron-liveness queries by NAME and carries a stale name — a renamed patrol reads as clean.**
locator `tools/oc-health:772`
VERBATIM: `cron_bad="$(sqlite3 "$DB" "SELECT name FROM cron_jobs WHERE enabled=0 AND name IN ('harvest-watch-4h','oc-roster-detached-sweep','oc-health-hourly');" 2>/dev/null)"`
why: `harvest-watch-4h` is the patrol's OLD name (renamed per the cron-namespacing law; its id `73158e43-…` survives the rename). A patrol renamed or disabled under a new name matches zero rows, so the census prints `crons: law-carrying enabled, zero DM leaks` and can never report it disabled — the "never start blind" class. CHANGELOG v0.4.203 records this exact row as *dispatched* to Toolsmith; the live file is unfixed.
fix: resolve patrol crons by job ID, not name; a name matching zero rows must be a FINDING, never clean.

**[MED] Three surfaces answer "which lanes are live / role R's uuid".**
locators `tools/RC-CONTRACT.md:38` (oc-ledger) and `:49` (oc-roster)
VERBATIM (`:38`): `` `roster [--role <substr>] [--live] [--include-retired] [--json]`: role → FULL uuid resolution; TSV uuid/role/topic/feature/ack, `--live` keeps only live sessions ``
VERBATIM (`:49`): `Verbs `live [--detail]` (liveness only — set-equal to the `oc-notify-fanout` v0.4.129 query), `forum [--detail]`, `claims`, `work`, `classify [--json]` …`
why: `oc-ledger roster` (role→uuid; schema owner of `last_acked`), `oc-roster` (its own derived `live`/`claims`/`work`/`classify`), and `oc-notify-fanout`'s internal target query all answer overlapping questions; the register RECORDS the set-equality instead of collapsing it. A lane must know which of three to call and can get different answers. `oc-roster claims` also collides by name with `oc-ledger claims <N>` while meaning something else. `oc-drift-check`'s D-5 mode already binds `oc-ledger roster --json` as "the schema owner" — the duplication is load-bearing and undocumented.
fix: one roster verb (the schema-owning one) with `--live/--forum/--claims/--classify` selectors; `oc-roster` and `oc-notify-fanout` delegate. Shape: `oc-ledger roster --live --json`.

**[LOW] `oc-lint-laws` corpus is hand-enumerated; `README.md` sits outside it and outside the exclusion list.**
locator `tools/oc-lint-laws:70`
VERBATIM: `DEFAULT_CORPUS="SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md"`
VERBATIM (`:66`): `# The LAW corpus: the skill's normative markdown. Two exclusions, both`
why: the corpus claims to be the skill's normative markdown with exactly two documented exclusions (CHANGELOG, war-stories), but `README.md` is in neither, and it carries live invocations (`bash tools/tests/run.sh`, `:55`/`:62`; `tools/oc-ledger sync --version X.Y.Z --why "..."`, `:65`). A law file outside the enumeration is a blind spot in the dead-channel lint. All 8 pointer-table destinations ARE covered — the hazard is the enumeration, not the split.
fix: derive the corpus at gate time (glob the root's normative `*.md` minus an explicit non-law list) instead of hardcoding 11 names.

**[LOW] `oc-upstream-delta --json` suppresses the commit list — a JSON drift consumer gets counts but no subjects.**
locator `tools/oc-upstream-delta` (`emit_commits` guard)
VERBATIM: `if [ "$JSON_OUT" -eq 0 ]; then` / `  emit_commits "$FORK_REF..$UP_REF" behind   # what upstream gained, first`
why: the `C <sha7> <subject>` rows emit only when `JSON_OUT=0`. The `--json` payload carries `base/ahead/behind/absorbed/absorbed_candidates` but no subjects, and `absorbed_candidates` covers only patch-id twins — so a JSON consumer cannot enumerate the non-absorbed BEHIND commits. For the standing-extra (the drift census must never start blind) the machine-readable mode is the one a monitor uses.
fix: add `behind_commits`/`ahead_commits` arrays (sha7+subject) to the JSON payload, mirroring the TSV.

## Coverage

Read: `tools/` + `tools/lib/` listings; `review-lenses.md` (E brief 194–206 + C/D/F/I/brain-scrub); `README.md`; `fleet-directives.md` (head + pointer table + thematic index); `RC-CONTRACT.md` rows for oc-commit, oc-deploy, oc-drift-check, oc-harvest-census, oc-harvest-dispatch, oc-health, oc-issue-dispatch, oc-ledger, oc-lint-laws, oc-notify-fanout, oc-prchecks, oc-review-persist, oc-roster, oc-ship-chain, oc-skew-scan, oc-start, oc-smoke, oc-smoke-evidence; `oc-review-persist` (0–130); `oc-upstream-delta` (full); `oc-lint-laws` (partial); grep extracts of `oc-drift-check`/`oc-ledger`/`oc-ship-chain`/`oc-notify-fanout`; `CHANGELOG.md` (v0.4.202–205); `reviews/` listing + `20260919-cycle/state.json`.

NOT read: `tools/tests/run.sh`, `tools/lib/*.sh`, `HEALTH-CHECKS.md`, `HEALTH-CLASSES.md`, `tools/archive/*`; bodies of `oc-deploy`/`oc-ship-chain`/`oc-ledger`/`oc-notify-fanout`/`oc-health`/`oc-harvest-*` (grep extracts only); `SKILL.md`, `editor.md`, `hq.md`, `triage.md`, `toolsmith.md`, `upstream-merge-runbook.md`, `s2-swap-journal-spec.md`, `war-stories.md`. `oc-review-persist:71` deliberately NOT re-reported (Toolsmith owns it).

OK this is my report. Let me estimate length. It's roughly... let me count lines/paragraphs. I think it's around 6300-6800 chars. Risky. Let me trim the coverage section and a few "why" lines.

Actually, I'll just trust it's close and trim aggressively where possible. Let me cut the "Read:" list's RC-CONTRACT rows to fewer, and shorten the NOT-read list.

Hmm — but the coverage section is mandated to name what I didn't read. I'll keep it but compress.

Let me finalize with some trims. I'll aim for under 6000.

Trims:
- Verdict: shorten.
- F2: drop the `:185` twin quote (keep one verbatim). Actually quote-or-no-finding needs at least one verbatim per finding; I can keep both but they're short. Keep.
- F5: drop the second VERBATIM (:66) to save space? It's short. Keep one to be safe... I'll keep just the DEFAULT_CORPUS quote and mention the exclusion comment inline. Saves ~90 chars.
- Coverage: compress.

Let me write the final. I'll count approximate by segments.

Actually, given the constraint, let me just present it and trust ~5800. Let me trim the coverage Read list.

Final coverage Read: "tools/ + tools/lib/ listings; review-lenses.md (E brief 194–206 + C/D/F/I/brain-scrub); README.md; fleet-directives.md (head + pointer table + thematic index); RC-CONTRACT.md (18 tool rows incl. oc-ledger, oc-roster, oc-prchecks, oc-lint-laws, oc-drift-check); oc-review-persist (0–130); oc-upstream-delta (full); oc-lint-laws (partial); grep extracts of oc-drift-check/oc-ledger/oc-ship-chain/oc-notify-fanout; CHANGELOG.md (v0.4.202–205); reviews/ listing + 20260919-cycle/state.json."

That's shorter. Good.

NOT read: "tools/tests/run.sh, tools/lib/*.sh, HEALTH-CHECKS.md, HEALTH-CLASSES.md, tools/archive/*; bodies of oc-deploy/oc-ship-chain/oc-ledger/oc-notify-fanout/oc-health/oc-harvest-* (grep extracts only); SKILL.md, editor.md, hq.md, triage.md, toolsmith.md, upstream-merge-runbook.md, s2-swap-journal-spec.md, war-stories.md. oc-review-persist:71 NOT re-reported (Toolsmith owns it)."

OK. Writing final now.

This is the final message — no more tool calls. Good, task complete.
<!-- /reasoning -->

# Lens E - cycle 20260919-cycle

## Verdict: 6 evidenced tool-surface defects — 1 HIGH (a mechanical reload trigger that prescribes the wrong law for 3 of 4 roles), 3 MED, 2 LOW. Nothing blocking; F1 is the one to land before the next reload cycle.

## Findings

**[HIGH] `oc-drift-check` hardcodes a role-blind reload — the tool that triggers the RELOAD LAW names the wrong file for 3 of 4 roles.**
locator `tools/oc-drift-check:134` (twin `:126`)
VERBATIM: `echo "DRIFT: claimed $claimed_bare != live $cur — re-read SKILL.md + editor.md IN FULL before next phase boundary"`
VERBATIM (`:126`): `echo "NO-HISTORY: no last_acked recorded for $uuid — treat as DRIFT, re-read SKILL.md + editor.md IN FULL before next phase boundary"`
why: `editor.md` is the EDITOR role file. A Triage/Toolsmith/HQ lane hitting DRIFT is ordered to re-read a file it does not own and is never told to re-read `fleet-directives.md`, where the cross-role `[LANE]` law lives post-split — so it looks compliant having read none of its own reload set. The role IS knowable at that point: the tool already delegates to `oc-ledger roster` (`:78`).
fix: derive the prescription from the lane's role (`oc-ledger roster --json`) and print `re-read SKILL.md + <role>.md + fleet-directives.md IN FULL`; shape `oc-drift-check <uuid> --ack` prints the role-correct list.

**[MED] `oc-prchecks`: one job, two interfaces — the law names the flag; the runnable waiter is the subcommand.**
locator `review-lenses.md:184` vs `tools/oc-prchecks:24` + `:200`
VERBATIM (law): `(for a blocking gate, `oc-prchecks --wait`); also flags` / (`:185`) `` `oc-prchecks --wait` used as a verdict waiter (double-duty). ``
VERBATIM (`:24`): `#   oc-prchecks [<branch-or-sha> | resume <run-id> | wait <ref>] [--wait N] [--budget N] [--poll S] …`
VERBATIM (`:200`): `wait <ref>       single-invocation wait/watch loop with budget (default 2700s, poll 30s) — Cycle 5 C-1`
why: `--wait N` is the poll-budget knob and demands an integer (usage diagnostic `--wait needs an integer`, `:334`); the blocking-gate waiter is the SUBCOMMAND `wait <ref>` (own 2700s default). The law lanes copy from prescribes `oc-prchecks --wait` — bare, no N — which is not a runnable gate and denotes the budget flag, not the waiter. One job, two spellings, wrong one documented.
fix: make `wait <ref>` canonical; alias the other with a warning; align `review-lenses.md:184–185` + `RC-CONTRACT.md:46` in one edit.

**[MED] `oc-health` cron-liveness queries by NAME and carries a stale name — a renamed patrol reads as clean.**
locator `tools/oc-health:772`
VERBATIM: `cron_bad="$(sqlite3 "$DB" "SELECT name FROM cron_jobs WHERE enabled=0 AND name IN ('harvest-watch-4h','oc-roster-detached-sweep','oc-health-hourly');" 2>/dev/null)"`
why: `harvest-watch-4h` is the patrol's OLD name (renamed per the cron-namespacing law; its id `73158e43-…` survives the rename). A patrol renamed or disabled under a new name matches zero rows, so the census prints `crons: law-carrying enabled, zero DM leaks` and can never report it disabled — the "never start blind" class. CHANGELOG v0.4.203 records this exact row as *dispatched* to Toolsmith; the live file is unfixed.
fix: resolve patrol crons by job ID, not name; a name matching zero rows must be a FINDING, never clean.

**[MED] Three surfaces answer "which lanes are live / role R's uuid".**
locators `tools/RC-CONTRACT.md:38` (oc-ledger) and `:49` (oc-roster)
VERBATIM (`:38`): `` `roster [--role <substr>] [--live] [--include-retired] [--json]`: role → FULL uuid resolution; TSV uuid/role/topic/feature/ack, `--live` keeps only live sessions ``
VERBATIM (`:49`): `Verbs `live [--detail]` (liveness only — set-equal to the `oc-notify-fanout` v0.4.129 query), `forum [--detail]`, `claims`, `work`, `classify [--json]` …`
why: `oc-ledger roster` (role→uuid; schema owner of `last_acked`), `oc-roster` (its own derived `live`/`claims`/`work`/`classify`), and `oc-notify-fanout`'s internal target query all answer overlapping questions; the register RECORDS the set-equality instead of collapsing it. A lane must know which of three to call and can get different answers. `oc-roster claims` also collides by name with `oc-ledger claims <N>` while meaning something else. `oc-drift-check`'s D-5 mode already binds `oc-ledger roster --json` as "the schema owner" — the duplication is load-bearing and undocumented.
fix: one roster verb (the schema-owning one) with `--live/--forum/--claims/--classify` selectors; `oc-roster` and `oc-notify-fanout` delegate. Shape: `oc-ledger roster --live --json`.

**[LOW] `oc-lint-laws` corpus is hand-enumerated; `README.md` sits outside it and outside the exclusion list.**
locator `tools/oc-lint-laws:70`
VERBATIM: `DEFAULT_CORPUS="SKILL.md fleet-directives.md editor.md editor-upstream-pr.md hq.md triage.md toolsmith.md review-lenses.md upstream-merge-runbook.md s2-swap-journal-spec.md tools/RC-CONTRACT.md"`
why: the corpus claims (its own `:66` comment: `# The LAW corpus: the skill's normative markdown. Two exclusions, both`) to be the skill's normative markdown with exactly two documented exclusions (CHANGELOG, war-stories), but `README.md` is in neither and carries live invocations (`bash tools/tests/run.sh`, `:55`/`:62`; `tools/oc-ledger sync --version X.Y.Z --why "..."`, `:65`). A law file outside the enumeration is a blind spot in the dead-channel lint. All 8 pointer-table destinations ARE covered — the hazard is the enumeration, not the split.
fix: derive the corpus at gate time (glob the root's normative `*.md` minus an explicit non-law list) instead of hardcoding 11 names.

**[LOW] `oc-upstream-delta --json` suppresses the commit list — a JSON drift consumer gets counts but no subjects.**
locator `tools/oc-upstream-delta` (`emit_commits` guard)
VERBATIM: `if [ "$JSON_OUT" -eq 0 ]; then` / `  emit_commits "$FORK_REF..$UP_REF" behind   # what upstream gained, first`
why: the `C <sha7> <subject>` rows emit only when `JSON_OUT=0`. The `--json` payload carries `base/ahead/behind/absorbed/absorbed_candidates` but no subjects, and `absorbed_candidates` covers only patch-id twins — so a JSON consumer cannot enumerate the non-absorbed BEHIND commits. For the standing-extra (the drift census must never start blind) the machine-readable mode is the one a monitor would use.
fix: add `behind_commits`/`ahead_commits` arrays (sha7+subject) to the JSON payload, mirroring the TSV.

## Coverage

Read: `tools/` + `tools/lib/` listings; `review-lenses.md` (E brief 194–206 + C/D/F/I/brain-scrub); `README.md`; `fleet-directives.md` (head + pointer table + thematic index); `RC-CONTRACT.md` (rows for oc-commit, oc-deploy, oc-drift-check, oc-harvest-census, oc-harvest-dispatch, oc-health, oc-issue-dispatch, oc-ledger, oc-lint-laws, oc-notify-fanout, oc-prchecks, oc-review-persist, oc-roster, oc-ship-chain, oc-skew-scan, oc-start, oc-smoke, oc-smoke-evidence); `oc-review-persist` (0–130); `oc-upstream-delta` (full); `oc-lint-laws` (partial); grep extracts of `oc-drift-check`/`oc-ledger`/`oc-ship-chain`/`oc-notify-fanout`; `CHANGELOG.md` (v0.4.202–205); `reviews/` listing + `20260919-cycle/state.json`.

NOT read: `tools/tests/run.sh`, `tools/lib/*.sh`, `HEALTH-CHECKS.md`, `HEALTH-CLASSES.md`, `tools/archive/*`; bodies of `oc-deploy`/`oc-ship-chain`/`oc-ledger`/`oc-notify-fanout`/`oc-health`/`oc-harvest-*` (grep extracts only); `SKILL.md`, `editor.md`, `hq.md`, `triage.md`, `toolsmith.md`, `upstream-merge-runbook.md`, `s2-swap-journal-spec.md`, `war-stories.md`. `oc-review-persist:71` deliberately NOT re-reported (Toolsmith owns it).

