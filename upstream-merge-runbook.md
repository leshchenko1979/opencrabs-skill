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
| **Carrier tools lane** | builds the merged tree via the `oc-deploy` lane, runs the battery — HQ never hand-builds |
| **Harvest lane** | unaffected for open PRs, but **pauses new branch creation** off fork main until the merge lands (stale bases) |
| **Owner** | semantic-pair overrides + the final prod swap |

## Process

1. Freeze check (ledger) → branch `merge/upstream-YYYYMMDD` off `origin/main`.
2. `git merge adolfousier/main` — merge, never rebase/reset (deployed-sha
   containment survives).
3. Textual conflicts: upstream wins on bug-fixes to shared code, fork wins on
   fork-only features; shared TEST files union both sides' cases. Expect the
   worst overlap in tests, not source.
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
6. `cargo clippy --all-features` + full test suite on the merged tree (carrier
   lane builds, battery runs — no local cargo per build-lane directive).
7. Fork CI (`pr-checks`) GREEN → FF-push `origin/main`, consolidated report
   with the decisions table.
8. Ledger stamps; prod swap stays owner-explicit.

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
