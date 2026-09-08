# Upstream merge runbook — fork main ← adolfousier/main

Procedure for the merge-on-arrival sync policy (owner 2026-09-02 "Land it";
directive text lives in `fleet-directives.md`, the `~/opencrabs remotes`
paragraph — this file is the how, that file is the law). Executed by HQ.
Owner gates are marked **[GATE]**.

First application: the 2026-09-02 backlog-clearing merge (67 upstream-only
commits, 133 fork-only, 68 overlapping files, merge-base `4776bee2`).

## Gates (fail closed)

1. **FREEZE check** — query the ledger for any carrier chain between dispatch
   and swap. Chain mid-flight → NO merge; report and wait. (Checkout-ref
   hazard class.)
2. **Merged ≠ deployed** — the merge landing on fork main never touches prod.
   The binary swap stays its own explicit owner act.
3. **Semantic overrides** — any feature pair where OUR version should beat
   upstream's is **[GATE]**: owner decides per pair. Default is upstream-wins.

## Roles

| Actor | Job |
|---|---|
| **HQ** | freeze check, run the merge, arbitrate textual conflicts, ledger stamps, consolidated report with the per-feature decisions table |
| **Review lens** (one spawn) | audits each semantic pair — diff fork behavior vs upstream's, flag anything upstream's version *loses* |
| **Editor lane** (hosting editor; TOOLSMITH builds no trees per toolsmith.md law) | runs `oc-deploy ship` on the marker commit via the `oc-deploy` lane, runs the battery — HQ never hand-builds |
| **Harvest lane** | unaffected for open PRs, but **pauses new branch creation** off fork main until the merge lands (stale bases). **v0.4.93:** filed upstream PRs stay FROZEN during the merge window — the merge does NOT trigger re-ports; conflicts on filed PRs are maintainer-side at merge time (editor.md Phase 7 PR-freeze law) |
| **Owner** | semantic-pair overrides + the final prod swap |

## Process

1. Freeze check (ledger) → branch `merge/upstream-YYYYMMDD` off `origin/main`.
2. `git merge adolfousier/main` — merge, never rebase/reset (deployed-sha
   containment survives).
3. Textual conflicts: resolve per the **merge-resolution shape, canonical in
   fleet-directives.md** (upstream wins WHOLESALE; verify
   `git diff adolfousier/main` over conflicted files is empty). Shared TEST
   files union both sides' cases — expect the worst overlap in tests, not
   source.
4. **Database migrations — dedicated pass, never drive-by.** Both sides may sit
   at the SAME `MIGRATION_COUNT` with DIFFERENT sets (2026-09-02: fork #37
   `20260828_pending_requests_origin` vs upstream #37
   `20260902_add_pending_followups`). Union to the next free version, keep
   prod's `user_version` as the reference point, and provide a healing path
   for the already-migrated prod DB. Two migrations claiming one version is a
   hard defect.
5. **Semantic triage** — every double-implementation pair gets a recorded
   decision: adopt upstream (default), keep fork, or reconcile. Auto-keep with
   no decision: commits adolfo merged from our own harvest PRs. **[GATE]** for
   any keep-ours.
6. Fork CI (`pr-checks`) GREEN on the merged tree — the only CODE-TESTS locus
   (box law; no local cargo per build-lane directive) → FF-push `origin/main`,
   consolidated report
   with the decisions table.
8. **Swap stamp — merge-derived heads.** A merge commit cannot carry the
   `Session-Id` trailer, so the build leg's ORDER gate 4 refuses it
   (2026-09-03 finding: bare merge `d02f4e08` passed this lane GREEN, swap
   blocked exit 2 pre-install). Before dispatching the build leg, HQ lands
   an **empty trailer-signed marker commit** on the merge head
   (`git commit --allow-empty` with a `Session-Id: <uuid>` trailer) —
   tree-identical to the merge (verify `git diff <merge> <marker>` is
   empty), forward-only, never force-push. The owner's swap ruling carries
   over unchanged: the marker changes no bytes. Pre-verified in the PR lane
   by `pr-checks.yml` swap mode (`swap=true`, gate-4 mirror — same
   commit as this rule).
9. Ledger stamps; prod swap stays owner-explicit.

## Risk register

- Prod behavior shifts in every adopted-upstream feature area even under
  upstream-wins; the lens pass catches functional losses, not cosmetic
  differences.
- Shared test files are the biggest overlap — the suite, not the source, is
  where the merge actually gets welded.
- Rollback shape: the merge commit lives on a branch; main untouched until CI
  is GREEN; prod never saw any of it. Merge preserves ancestry, so deployed
  shas stay valid rollback points.

## First application — backlog merge 2026-09-02

Upstream-only 67 (incl. the #1255 compaction-stall fix, follow-ups hardening
our own merged PRs — `aee19325`, `b6a4ce49`, `bbba209e` — and the 12-commit
drag-drop feature), fork-only 133, overlapping files 68, merge-base
`4776bee2`. Known semantic pairs (fork issues adolfo implemented his way):
#14 chunk_hash heal, #15 receipt cards (11 commits), #17
refuse-delivery-to-new-owner, #19 redirect-on-claim, #23 `session notify`
CLI, #31 trailer reclaim — plus both sides' independent #1226
compaction/followup patches. Auto-keep: adolfo's merges of harvest PRs
#1258/#1266/#1268/#1269/#1274/#1275.

## Port — REBASE-PORT model (RETIRED for fork main 2026-09-02; PR-branch chains only)

1. BACKUP REF FIRST, always: `git -C ~/opencrabs branch backup/pre-port-<date> origin/main`
2. Classify EVERY fork-only commit over `adolfousier/main..origin/main`:

   | Verdict | Test | Action |
   |---|---|---|
   | absorbed | patch-id match OR title-twin inside upstream's new commits | DROP |
   | superseded | upstream reimplemented it better (read his commits) | DROP |
   | survivor | neither test hits | PORT |

3. Temp worktree off `adolfousier/main` → cherry-pick survivors in CHRONOLOGICAL
   order. Conflict on a pick → triage: collides with maintainer's redesign =
   DROP permanently and log why; genuinely additive = resolve keep-both, then
   VERIFY THE SEAM COMPILES (brace-level check — the 2026-08-26 TaskScope seam
   bug shipped a broken concat) before continuing.
4. Port-seam evidence = pr-checks GREEN with zero errors in ported lines
   (modum RETIRED 2026-08-28). Warnings in files no ported commit touches =
   upstream noise; note them, don't chase. Fixup commits carry the EXECUTING
   lane's Session-Id trailer.
5. Force-push WITH LEASE:
   `git push --force-with-lease=main:<old-tip> origin main`
6. Verify carrier dispatch still works and proof-dispatch the ported tip
   before reporting done.
7. Notify each dropped feature's owning editor: SHIPPED UPSTREAM — fork duty
   ended (their Phase 6b item 6). Record verdicts next to `baseline.json`.

Boundary: port-seam conflict fixups only — keep-both resolutions on
genuinely-additive picks + the SEAM-COMPILES brace-level verification; never
feature logic, never new behavior (ex-ROLE_EXCEPTION, bounded the same way).
Anything beyond a port seam → editor work.
