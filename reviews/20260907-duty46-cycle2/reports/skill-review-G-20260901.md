# Reviewer G — STRUCTURE/NAVIGATION report
Duty-6 skill review, 2026-09-01 · base skill v0.4.78 (HEAD 63977f14). Read-only. Lens: heading hierarchy, cross-ref integrity, orphaned sections, loader-order sanity.

1 · editor.md:182 (§Phase 0) · bullet truncated mid-sentence at "or in a fresh" — second verification venue cut off, rule half-readable · complete: "…or in a fresh worktree cut from `origin/main`" · MED
2 · review-lenses.md:50 (Lens G brief, DOCS family) · review-lenses.md itself (v0.4.78 split product) is in NO lens's scope — catalog file unreviewed by default · add review-lenses.md to Lens G's file list · MED
3 · SKILL.md:115 (STEP ZERO, SUPERVISOR row) · second site of same stale enumeration: "Reviewer G role-file structure — editor.md + supervisor.md + SKILL.md" omits the new catalog · add review-lenses.md, batch with finding 2 · MED
4 · SKILL.md:462 (§Hard rules) · edit-guard list (SKILL.md/editor.md/tools/archive/compiler.md/supervisor.md) omits review-lenses.md — protected set stale after split · add review-lenses.md · MED
5 · supervisor.md:6 (Scope header) · owned skill-set enumeration omits review-lenses.md (third site of the same stale list) · add it · LOW
6 · SKILL.md:48 (§Canonical tooling, oc-ci-parity row) · "(live: editor Phase 7 parity)" points to a nonexistent locus — editor.md has zero oc-ci-parity mentions; Phase 7 never merges upstream · re-point to "(live: SKILL.md §Upstream relations item 6)" · MED
7 · supervisor.md:211 (§CI-wait & waiter discipline intro) · "the editor keeps items 1–3" is stale — editor.md §CI-wait now runs items 1–9 (4–9 added v0.4.71/v0.4.77); mirrored count re-rots on every editor-side addition · stop mirroring the count: "the editor keeps its own numbered items (editor.md §CI-wait discipline & actor attribution)" · MED
8 · SKILL.md:400-405 (§Upstream relations item 2) · REBASE-PORT procedure lives only as a summary in the shared-facts file, violating SKILL.md's own charter ("procedures live in TWO role files"); supervisor.md doesn't own it (B8 claims only items 1+7); un-homed since compiler retirement · re-home as explicit supervisor.md duty beside "Upstream-relations ownership (B8)", leave SKILL.md item 2 as facts + pointer (regroup, not split) · MED
9 · SKILL.md:563-565 (§Shared war stories) · blank line after the "Two-file ledger drift" row splits the table; the four following rows form a headerless block that doesn't render as a table · remove the blank line · LOW
10 · SKILL.md:105 (§STEP ZERO placement) · "mandatory on every load" router sits after the ~70-line Canonical tooling register + Unified tools log — loader pays through the whole reference before reaching the role decision · move STEP ZERO directly below the "Owns" paragraph (regroup only) · LOW
11 · SKILL.md:50 (§Canonical tooling, oc-deploy row) · pointer "editor.md §Ship — oc-deploy (S3 path)" matches no heading — actual heading is "## Phase 6a — Ship — oc-deploy (S3 path)"; resolves only by substring luck · cite "§Phase 6a — Ship — oc-deploy (S3 path)" · LOW

## COUNTS
HIGH: 0 · MED: 7 (findings 1,2,3,4,6,7,8) · LOW: 4 (findings 5,9,10,11)

## EMPTY CHECKS (explicitly verified clean)
1. supervisor.md Duty 6 restructure — no dangling refs, no orphaned briefs; review-lenses.md carries all SEVEN briefs; family map identical in all three sites; pointers resolve both ways; Duty 6 numbering 1–7 contiguous.
2. editor.md Phase 7 B11/B12 restructure — steps run 0,1,2,2-pre,2c,3,4,5,6; no 2a/2b blocks remain; only "step-2b" mention is SKILL.md §Hard rules explicitly marked RETIRED; PR-BASE-PRE-OPEN + PR-GATE-STANDING rules exist; per-commit-law pointers resolve.
3. editor-phase7-rules.md exists (2129 B), contains the 4-leg HARVEST VERIFICATION SWEEP checklist (a–d) + QUALIFIED FORK REFS incident/rationale exactly as the two pointers promise.
4. All file-path cross-refs verified on disk: editor-phase7-rules.md · CHANGELOG.md · tools/RC-CONTRACT.md · tools/archive/compiler.md · tools/archive/oc-post-receipts · tools/tests/run.sh · tools/lib/oc-log.sh · tools/lib/oc-embed.sh · all 29 tools in the Canonical tooling table · writing-great-skills SKILL.md · ~/oc-work/oc-ledger-design-20260829.md.
5. All §-name cross-refs resolve (SKILL.md/editor.md/supervisor.md headings incl. W1–W6).
6. Checkable-completion-criterion sweep — zero failures; every step in editor.md and supervisor.md terminates in a mechanically checkable state.
7. No split verdicts issued; every finding fixable by cheaper ladder moves. Deliberately not reported as G's: tool-table size (lens B), letter-birth-order + loop-lesson duplication (lens A).
