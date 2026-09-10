# Editor upstream PR procedure — Phase 7 + 7b (split from editor.md, v0.4.131)

> Single home for the upstream-PR phases. Loaded ON DEMAND when a feature
> reaches COMPLETE (Phase 7 trigger) or an owned PR needs lifecycle action
> (Phase 7b) — NOT part of the every-reload editor.md.

## Phase 7 — Feature complete → upstream PR

Trigger: the feature is COMPLETE — merged into fork `main`, shipped inside a
green swapped build, smoke test PASS (v0.4.104 four-leg rubric). With tests green
and smoke confirmed, Editor prepares the harvested PR branch, posts the smoke
evidence, and files the upstream PR. Development-time contact stays issues-only;
this PR is the ONE sanctioned exception (completed features only).

```bash
# 0. FILING NOTICE: post the smoke-test EVIDENCE + the filing report in
#    YOUR forum topic (what you drove, what you saw, run id + built sha + PR URL).

# 1. list fork-only commits, pick THIS feature's (trailers + touched files)
#    — mechanized: `tools/oc-attrib --range <old>..<new> --contributors` (3-col TSV:
#    session-uuid / issue_refs / sha7s) or `tools/oc-attrib --range` for
#    roster-resolved roles; the raw form:
git -C ~/opencrabs fetch adolfousier
git -C ~/opencrabs log --format='%H%x09%s%x09%(trailers:key=Session-Id,valueonly)' \
  adolfousier/main..origin/main

# 2. harvest onto a branch off UPSTREAM main — NEW worktree, usual hygiene
#    (E1, v0.4.80: `oc-wt add --create` IS the sanctioned creation path — the
#     UN-SKIPPABLE index chain runs INSIDE it. The old "oc-wt never creates"
#     raw `worktree add -b` ritual taught a false interface fact; raw add +
#     standalone oc-index-worktree stays the fallback only when --create is
#     unavailable.)
tools/oc-wt add up-<feature> leshchenko1979/<feature> --create --from adolfousier/main --repo ~/opencrabs
git -C ~/oc-wt-up-<feature> cherry-pick <sha1> <sha2> ...
# 2-fresh. BASE FRESHNESS before the gate dispatch (Duty-4 P4, v0.4.80;
#         AMENDED v0.4.93 — scope NARROWED to pre-filing only, owner "go all"
#         2026-09-07 on the Adolfo-protocol amendment):
git -C ~/opencrabs fetch adolfousier
git -C ~/opencrabs rev-parse adolfousier/main   # must equal the sha the port was cut from
#    upstream moved since the port? RE-PORT onto the new base — BEFORE filing.
#    SCOPE (v0.4.93): applies ONLY while the work is fork-internal (branch,
#    gate, pre-filing). Once the upstream PR is FILED, the PR-freeze law
#    (below) takes over: NO re-port, NO force-push, NO head/body changes —
#    a filed PR is frozen regardless of upstream main movement. Conflict
#    resolution after filing is the MAINTAINER's side of the wall (merge
#    locally, fix on top, push, comment). Post-merge, upstream main carries
#    the fix; fork-side sync stays owner-gated (upstream-merge-runbook.md).

# Phase 5 gate: pr-checks GREEN on the PR branch — zero errors in ported lines

# 2-pre. ATOMICITY + BASE check BEFORE the PR opens — standing rule
#     PR-BASE-PRE-OPEN in the Rules list below.

# 2c. CI gate (upstream triad) (v0.4.22 — encodes adolfousier/opencrabs
#     CONTRIBUTING.md: "You MUST pass all three before
#     submitting a PR"). v0.4.28: the triad runs in CI via pr-checks.yml (cargo is
#     FORBIDDEN on this box — box law); a green run URL IS the citation now.
#     FIRST push the head branch (step 3's command — the workflow checks the
#     branch out from the fork), then dispatch:
gh workflow run pr-checks.yml --repo leshchenko1979/opencrabs \
  --ref ci/quick-build-linux -f ref=leshchenko1979/<feature>
#   (v0.4.46: one command does all of it — tools/oc-prchecks leshchenko1979/<feature>;
#    prints the GREEN/RED verdict + run URL for the PR-body citation below)
#   Standing rules PR-GATE-STANDING in the Rules list below (flags verbatim
#   from pr-checks.yml; ANY red = fix cycle + re-dispatch, never a filed PR;
#   cite the green run URL in the PR body prep next to the smoke/run
#   evidence).

# 3. push the head branch to the FORK (PR heads live there)
git -C ~/oc-wt-up-<feature> push -u origin leshchenko1979/<feature>

# 4. open the upstream PR — detailed description; body rules are canonical in
#    the Rules bullet below (fork-issue link at END, `Closes #N` FORBIDDEN).
#    PR TITLE TYPE PREFIX: every upstream
#    AND fork PR title starts with fix: / fix(scope): (bug fix), feat: /
#    feat(scope): (new capability), or chore: (tooling/CI/docs/deps — zero
#    user-visible change). The head-branch slug mirrors the type:
#    leshchenko1979/fix/<slug> | feat/<slug> | chore/<slug> (existing branches
#    untouched).
#    CROSS-REPO --HEAD LAW (Duty-4 P3, v0.4.80): --head is OWNER:BRANCH —
#    `leshchenko1979:<branch>`, literal branch name kept whole. The bare
#    `--head leshchenko1979/<branch>` form fails cross-repo with
#    "No commits between" (2026-09-01, adolfousier/opencrabs#1277 filing).
gh pr create -R adolfousier/opencrabs --base main --head leshchenko1979:leshchenko1979/<feature> \
  --title "<fix:|feat:|chore:> <concise feature title>" \
  --body "<detailed what/why, implementation notes, green run link, smoke-test evidence. Original issue: https://github.com/leshchenko1979/opencrabs/issues/N (exactly one)>"

# 5. close the tracked FORK issue with a pointer comment
gh issue close <issue-n> -R leshchenko1979/opencrabs -c "Implemented in upstream PR adolfousier/opencrabs#<pr-number>"

# 6. remove the worktree — done (dirty-tree gate + journal via oc-wt)
tools/oc-wt remove up-<feature>
```

Rules:
- **PR-FREEZE LAW (v0.4.93, owner "go all" on the Adolfo-protocol amendment
  2026-09-07):** an upstream PR is FROZEN the moment it is filed with CI green
  at push. NO re-port, NO force-push, NO head changes, NO body updates — even
  if upstream main moves or conflicts appear. *"Once you push it, you already
  did your job"* (Adolfo, 2026-09-07). Rationale: force-pushing a filed PR
  changes the head under the maintainer — if he already merged locally, the
  merge sha no longer matches and auto-close breaks (2026-09-07:
  #1426/#1427 rebased at 15:56, merged locally by maintainer at 17:22, heads
  mismatched, manual close required). Base-freshness (2-fresh) applies
  PRE-filing only. The ONLY valid re-engagement: maintainer explicitly asks
  for a change.
- **MAINTAINER-SIDE MERGES (v0.4.93):** conflict resolution, rebase, and
  fixes-on-top AFTER filing are the MAINTAINER's responsibility, done at
  merge time on his side. Contributor = push final work once.
  *"Whenever you're the maintainer approving changes: merge locally, fix
  conflicts on top, push, comment what you did."*
- **FINAL-PR STANDARD (v0.4.93):** file a PR only when it is genuinely final —
  tests green at push, no known gaps, no planned follow-ups. Force-pushes on
  filed PRs are the rare exception (~1-in-10), never procedure. All iteration
  happens fork-side BEFORE filing (fork = workspace, upstream PR = one-way
  handoff).
- Fork-only commits means EXACTLY that: no adolfousier sync merges, no other
  feature's commits, no bare CI-config churn unless it IS the feature.
- Cherry-pick conflicts → resolve, re-run the Phase 5 gate (pr-checks), continue. NEVER merge fork
  `main` into the PR branch — upstream gets clean commits only.
- **HARVEST VERIFICATION SWEEP (Duty-4, v0.4.71):** after conflict resolution
  on a harvested branch, BEFORE the first gate dispatch — 4-leg sweep: symbol
  callers in the UPSTREAM tree, fork-side attribute port, foreign-hunk drop,
  `git patch-id` verify of rebase-ported commits. Full checklist:
  `editor-phase7-rules.md` (same dir).
- **BASE-FRESHNESS AT FILING TIME (Triage lesson n=2083, v0.4.111):** the
  sweep and every gate run are valid against a NAMED upstream base — record
  the `adolfousier/main` sha the verification was tested against; a census/
  gate CLEAN result that does not name its base sha is not a CLEAN receipt
  (stale-base CLEANs masked #1451's CONFLICTING for hours).
- The PR body MUST reference THE issue as a FULL FORK URL at the END of the
  description (`Original issue: https://github.com/leshchenko1979/opencrabs/issues/N`
  — EXACTLY one, atomicity rule). `Closes #N` is FORBIDDEN on upstream PR bodies:
  it resolves against adolfousier's issue space, not ours (issues live on the
  fork). WE close the fork issue (step 5) right
  after the PR is up — do not wait for the maintainer merge.
- **QUALIFIED FORK REFS (fork [#54](https://github.com/leshchenko1979/opencrabs/issues/54)):**
  no bare `#N` with FORK issue numbers on any upstream surface (PR body,
  PR title, issue body, comment) OUTSIDE a code span — write
  `leshchenko1979/opencrabs#N` or the full URL (GitHub autolinks bare `#N`
  against adolfo's issue space). Code spans exempt. Bare `#N` stays reserved
  for UPSTREAM-local references. Incident + rationale:
  `editor-phase7-rules.md`.
- One feature = one PR; never bundle two features to save a PR.
- **ATOMICITY:** issues, PRs and commits are atomic —
  one problem per issue, one logical change per commit, one issue per PR. Every
  harvested commit carries an `Issue-Ref: #N` trailer matching EXACTLY the single
  issue the PR claims; no commit without one, no PR claiming more than one. A PR
  whose diff mixes fixed and unfixed concerns forces a binary status on a mixed bag
  and mislabels both. Gate with `./tools/oc-pr-atomicity <pr>` (trailer scan + body
  claim cross-check) BEFORE closing the issue. PR LIFECYCLE: one PR = one atomic change; a bug found in review is fixed
  FORWARD on the same PR or the PR is closed — no draft limbo. A MERGED PR is
  closed forever: follow-up work = new branch + new PR, NEVER extend a merged
  branch.
- **BUILD TRIGGERS = exactly TWO, no exceptions** (full rule + rationale +
  yml-location law = SKILL.md §Hard rules BUILD TRIGGERS — canonical, do not
  restate here): checkable consequence for the editor — no direct quick-build
  PR-head dispatch; ORDER gate 3 (CONTAINMENT) rejects any PR-head sha;
  compile+lint evidence = step 2c's pr-checks dispatch.
- **PR-BASE-PRE-OPEN (v0.4.71, Duty-4 P6):** an upstream PR head is a harvest
  branch off `adolfousier/main` — NEVER a fork-main-based branch; base +
  atomicity check runs BEFORE the PR opens (a post-open atomicity FALSE
  (fork-divergence commits) means the base was wrong before the PR existed).
- **PR-GATE-STANDING (step 2c):** triad flags VERBATIM from pr-checks.yml
  (fmt soft-fail mirrors upstream; clippy --locked --lib --bins --tests
  --all-features -D warnings; cargo test --locked --profile ci
  --all-features) — green here predicts green on adolfo's full gate. Iterate
  by EDITING CODE and re-dispatching pr-checks — NEVER run cargo locally
  (box law); test-placement policy → §Phase 4.
- Pre-flight gate (step 2c) is MANDATORY (v0.4.0): read the fmt STEP outcome,
  not just the run conclusion — soft-fail hides failures from the run.
- `leshchenko1979/<slug>` is the RESERVED PR-head namespace (`leshchenko1979/…`
  branch names stand out in the upstream branch list): branches with that
  prefix are created ONLY in this phase, never developed on, never merged into
  fork `main` — and NOT deleted while their PR is still open (GitHub needs the
  head alive).

## Phase 7b — PR lifecycle (monitor & unblock, v0.4.0)

Every OPEN upstream PR has an owning editor: the Session-Id trailers of its
harvested commits. When a PR is not mergeable, route by BLOCKER CLASS:

| Blocker | Who acts | Action |
|---|---|---|
| fmt/clippy/test failure in THIS feature's files | Owning editor (notified with log evidence via the mechanical post-swap fan-out — `oc-deploy fanout`) | **PR-freeze check first (v0.4.93):** fixes on a FILED PR only when CI failure exists at push time or maintainer asks. Otherwise frozen. If valid: fresh worktree off the PR head → fix → Phase 5 gate (pr-checks) + conflict-quality gate → signed push to the head |
| Merge conflicts with new upstream `main` | **Maintainer (v0.4.93)** | **DO NOT rebase/force-push the filed PR** — PR-freeze law. Conflict resolution on a filed PR is the maintainer's side (he merges locally, fixes on top, pushes, comments). Editor action: NONE beyond a factual comment ONLY if the maintainer asks; pre-filing, 2-fresh governs |
| PRE-EXISTING upstream red (base fails in files we never touched) | ❌ NO editor pings — our code is innocent | housekeeping-PR candidate: issue filed + ledger-registered first (v0.3.8), Alexey decides |
| Maintainer rejects/closes the PR | Owning editor | REOPEN the linked issues with a pointer comment; record the outcome |

Hard rules: verify the failing log names files THIS PR actually touches BEFORE
pinging anyone (identical clippy walls on every PR can live on the upstream base). Soft-fail fmt diffs are
cosmetic — NEVER ping for fmt alone. Absorption ends the lifecycle: if the
maintainer merges/reimplements the feature, the PR story closes with a SHIPPED
UPSTREAM notice (Phase 6b item 6), not more fork-side work.
Two same-turn checks (v0.4.5): (1) BEFORE any push to a gated/frozen head branch,
RE-READ live gate state — latest issue comments + supervisor notifies — session-start
knowledge structurally cannot know what changed mid-turn. (2) Before preparing ANY follow-up
commit targeting an open PR, check its state via API (`gh pr view <n> --json
state,mergedAt`) — it may have been maintainer-merged under you. **The state gate ALSO spans every port /
cherry-pick round toward a PR head (v0.4.14, proposal P4)**: before investing a
round, fresh `gh pr view <n> --json state` — if MERGED/CLOSED, STOP and report,
do not invest the round.
