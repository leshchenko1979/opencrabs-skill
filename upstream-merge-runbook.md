# Upstream sync runbook — fork main ← adolfousier/main

Procedure for the **REBASE sync model** (owner-approved transition 2026-09-11,
plan "Fork Rebase Transition and Sync Workflow"; directive text lives in
`fleet-directives.md`, the `~/opencrabs remotes` paragraph — this file is the
how, that file is the law). Delegated to Triage (owner order 2026-09-11 "You
should not do these merges - delegate to triage"; HQ does NOT execute).
Owner gates are marked **[GATE]**.

**Model:** fork main is a small set of topical commits sitting directly on
`adolfousier/main`. Each sync REPLAYS our still-pending commits onto upstream
and **DROPS the ones upstream has accepted**, so the ahead counter reflects
true pending delta and shrinks as PRs land. The pre-2026-09-11 merge-on-arrival
model is RETIRED — it produced 31 merge commits and a 333-commit phantom ahead
count, and its conflicts were resolved wholesale at merge time instead of
per-commit at replay time.

## Step 0 — ROSTER GATE (blocking; nothing else starts first)

**The freeze list IS the roster.** Derive it with a tool; never assemble it by
hand from a stale registry.

- `tools/oc-roster live` — the DERIVED in-progress roster, joining four
  independent signals: ledger `events[kind=claim]` (intent), `oc-wt list` dirty
  state (evidence), the session DB live roster (liveness), forum bindings
  (scope). It stores nothing.
- `tools/oc-roster classify` — ACTIVE / IDLE / ORPHAN / UNKNOWN per row.
- A claim author whose uuid the session DB has never seen is reported as a
  **PHANTOM** and excluded from the roster — a hand-assembled id can never
  enter a freeze list.
- Any **ACTIVE** lane whose work is in flight is paused and its branch migrated
  (Process step 7), or the sync is a roster defect and returns here.
- **Role resolution is NOT `oc-roster`.** Use
  `oc-ledger roster --live --role <role>`. `oc-roster`'s `--role` flag is
  accepted and silently ignored (rc 0, no stderr, unfiltered output) — pointing
  role resolution at it breaks dispatch fleet-wide.

## Gates (fail closed)

1. **FREEZE check** — query the ledger for any carrier chain between dispatch
   and swap. Chain mid-flight → NO sync; report and wait. (Checkout-ref
   hazard class.)
2. **Synced ≠ deployed** — the sync landing on fork main never touches prod.
   The binary swap stays its own explicit act.
3. **Semantic overrides** — any feature pair where OUR version should beat
   upstream's is **[GATE]**: owner decides per pair. Default is upstream-wins.

## Roles

| Actor | Job |
|---|---|
| **Triage** | step-0 roster gate, run the rebase, arbitrate replay conflicts, ledger stamps, seam adaptation dispatch, consolidated report with the per-feature decisions table (delegated owner 2026-09-11) |
| **HQ** | oversight, process/skill updates, review of owner-gated semantic overrides — HQ does NOT execute the sync |
| **Review lens** (one spawn) | audits each semantic pair — diff fork behavior vs upstream's, flag anything upstream's version *loses* |
| **Editor lane** (hosting editor; TOOLSMITH builds no trees per toolsmith.md law) | runs `oc-deploy ship` on the marker commit via the `oc-deploy` lane, runs the battery — HQ never hand-builds |
| **Harvest lane** | unaffected for open PRs, but **pauses new branch creation** off fork main until the sync lands (stale bases). **v0.4.93:** filed upstream PRs stay FROZEN during the window — the sync does NOT trigger re-ports; conflicts on filed PRs are maintainer-side (editor.md Phase 7 PR-freeze law) |
| **Owner** | semantic-pair overrides + the final prod swap |

## Process

1. **Step 0 roster gate** (above) — blocking. Record the pre-sync sha in the
   ledger BEFORE any force-push; it is the rollback point.
2. Branch `sync/upstream-YYYYMMDD` off `origin/main`.
3. `git rebase adolfousier/main` — **rebase, not merge.** Commits upstream has
   already accepted drop out of the replay automatically; that is the point of
   the model. Do not hand-drop them.
4. **Replay conflicts: resolve per the Seam-resolution shape, canonical in
   `fleet-directives.md`** (upstream's code ships byte-exact; our delta adapts
   on top — never overwrite his code). Conflicts arise only while replaying OUR
   still-pending commits, so resolution is per-commit. Shared TEST files union
   both sides' cases — expect the worst overlap in tests, not source.
5. **Database migrations — dedicated pass, never drive-by.** Both sides may sit
   at the SAME `MIGRATION_COUNT` with DIFFERENT sets (2026-09-02: fork #37
   `20260828_pending_requests_origin` vs upstream #37
   `20260902_add_pending_followups`). Union to the next free version, keep
   prod's `user_version` as the reference point, and provide a healing path
   for the already-migrated prod DB. Two migrations claiming one version is a
   hard defect.
6. **Semantic triage** — every double-implementation pair gets a recorded
   decision: adopt upstream (default), keep fork, or reconcile. Auto-keep with
   no decision: commits adolfo merged from our own harvest PRs. **[GATE]** for
   any keep-ours.
7. **Migrate lane branches onto the new base** — for each roster entry:
   `git rebase --onto origin/main <old-fork-main-sha> <lane-branch>`. Lane-local
   conflicts are isolated to that lane; anything else is a roster defect and
   returns to step 1. Unpause lanes via `session_notify` with the new base sha.
8. Fork CI (`pr-checks`) GREEN on the rebased tree — the only CODE-TESTS locus
   (box law; no local cargo per build-lane directive) → force-push
   `--force-with-lease` to `origin/main`, consolidated report with the
   decisions table.
9. **Swap stamp — REBASE heads are UNSIGNED BY CONSTRUCTION.**
   A rebase (like a synthesis or merge) cannot carry a `Session-Id` trailer, so
   the build leg's ORDER gate 4 refuses the head: `oc-order-validate: UNSIGNED
   … attribution mandatory`, and the chain exits **rc 6** (2026-09-03 finding:
   bare merge `d02f4e08` passed this lane GREEN, swap blocked exit 2
   pre-install; 2026-09-11: the atomic cutover head `12d25260` hit exactly
   this and stranded main undeployed). **This is a STANDING artifact of the
   sync sequence, not a one-off fix — it recurs on EVERY sync.**
   Before dispatching the build leg, land an **empty trailer-signed marker
   commit** on the sync head:
   ```bash
   git commit --allow-empty -m "release: swap marker for <synced-sha> tree"
   ```
   carrying a `Session-Id: <uuid>` trailer. Required properties, all four
   verified before use:
   - **tree-identical** to the sync head (`git diff <head> <marker>` empty)
   - **parent = the sync head** (forward-only child, never a rewrite)
   - **trailer present** (`git log -1 --format='%B' <marker> | git interpret-trailers --parse`)
   - **fast-forwardable** onto `origin/main` (no force-push)
   The owner's swap ruling carries over unchanged: the marker changes no bytes.
   Pre-verified in the PR lane by `pr-checks.yml` swap mode (`swap=true`,
   gate-4 mirror — same commit as this rule).
10. **DEPLOY the synced main.** The sync is NOT complete when CI goes green —
    a cutover that stops at the force-push leaves main stranded undeployed
    while the live binary runs an older sha. Dispatch the build leg on the
    marker commit and let the swap complete (or record explicitly why it is
    deferred, with the reason). Verify with `deployed.sha` vs `origin/main`
    after the swap. **No sync step is "done" with main stranded.**
11. Ledger stamps; prod swap stays owner-explicit.

## Risk register

- Prod behavior shifts in every adopted-upstream feature area even under
  upstream-wins; the lens pass catches functional losses, not cosmetic
  differences.
- Shared test files are the biggest overlap — the suite, not the source, is
  where the seam actually gets welded.
- **Force-push risk** — the rebase rewrites fork main. Mitigations:
  `--force-with-lease` (never bare `--force`), pre-sync sha recorded in the
  ledger first, and lane branches migrated in step 7 rather than abandoned.
  Rollback = `--force-with-lease` back to the recorded pre-sync sha.
- Ancestry no longer proves a lane's work survived a sync (a rebase replaces
  shas). Verify survival by CONTENT: `git show origin/main:<path> | grep -n
  <symbol>`, or ancestry of the HARVEST commit — never of a pre-rebase sha.

## Historical — the MERGE model (RETIRED 2026-09-11)

Kept as precedent, not procedure. The 2026-09-02 backlog-clearing merge
(67 upstream-only commits, 133 fork-only, 68 overlapping files, merge-base
`4776bee2`) was the first and largest application; its conflicts were resolved
upstream-verbatim (32/32 files, 0-byte fidelity check) and the superseded
resolution is preserved at ref `merge/upstream-20260902-forkwin`. Known
semantic pairs from that pass (fork issues adolfo implemented his way): #14
chunk_hash heal, #15 receipt cards (11 commits), #17
refuse-delivery-to-new-owner, #19 redirect-on-claim, #23 `session notify` CLI,
#31 trailer reclaim — plus both sides' independent #1226
compaction/followup patches. Auto-keep: adolfo's merges of harvest PRs
#1258/#1266/#1268/#1269/#1274/#1275.

The byte-exact principle from that pass survives into the rebase model; only
the mechanism changed.

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
