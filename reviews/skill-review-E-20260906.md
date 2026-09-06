# Duty-6 Review E (re-dispatch) — INTERFACE/TOPOLOGY (re-persisted 2026-09-06; original persist claim was phantom, recovered verbatim via wait_agent id 78d244e0)

Scope: tools/ + lib/ — CLI arg shapes, output contracts, exit-code semantics, env-var interfaces. Oc-waiter and shadow-rotate/seal-state locking excluded (lenses F/D).

## E-1 — HIGH — patch-id multi-commit computation bug
oc-harvest-sweep:72: `BRANCH_PIDS="$(git -C "$REPO" log "$BASE..$BRANCH" -p --format= | git patch-id --stable | cut -d' ' -f1)"` — `git patch-id` starts a new id at each `commit <sha>` separator; `--format=` strips them, so a multi-commit branch hashes as ONE garbage id → every --port-of sha falls to NO-MATCH (line 78), rc 1, burned gate round on correctly ported work. Selftest (lines 35-49) never exercises leg P with >1 commit. Expansion: oc-upstream-delta:208-219 does it CORRECTLY (per-commit rev-list loop); oc-branch-sweep:64 delegates to git cherry (also per-commit). Resolution: per-commit loop factored into `lib/oc-patchid.sh`, sourced by all three.

## E-2 — HIGH — OC_GIT semantic collision
oc-upstream-delta:31 `GIT_BIN="${OC_GIT:-git}"` (git BINARY) vs oc-seal-state:44 `GIT="${OC_GIT:-/root/opencrabs}"` (clone PATH). Exporting either value breaks the other tool with misleading diagnostics. Resolution: rename seal-state's to OC_CLONE + battery row asserting single meaning.

## E-3 — MED — fork/upstream identity fragmented across 5 shapes
oc-ci-parity:22-23 (OC_FORK_REPO/OC_UPSTREAM_REPO env), oc-pr-atomicity:36 (OC_REPO=upstream slug), oc-issue-sweep:26 (hardcoded, flags only), oc-upstream-delta:33-34 (hardcoded remote names), oc-harvest-sweep:26 (hardcoded base ref). Fork re-host = 5-file hunt; partial overrides mislead. Resolution: canonical OC_FORK_REPO/OC_UPSTREAM_REPO in lib/oc-embed.sh, sourced by all five; flags still override.

## E-4 — MED — working-clone default triplicated
REPO=$HOME/opencrabs (harvest-sweep:26, upstream-delta:32) vs GIT=${OC_GIT:-/root/opencrabs} (seal-state:44, riding the E-2 collision). Resolution: one OC_CLONE (env + --repo everywhere).

## E-5 — LOW — harvest-sweep --help prints usage to stderr
RC-CONTRACT: "--help → 0 (usage text on stdout)". oc-harvest-sweep:64 exits 0 but usage() at :23 echoes >&2 — `--help | grep usage` captures nothing (branch-sweep:37 and upstream-delta print to stdout). Resolution: stream parameter + battery asserts non-empty stdout.

Verdict: 2 HIGH (E-1 silent gate-verdict inversion — the exact incident class that motivated oc-harvest-sweep; E-2 mutually booby-trapped env vars), 2 MED (E-3/E-4 one consolidation commit), 1 LOW (E-5 two-line fix rides E-1's harvest-sweep touch). Otherwise contract-clean: 31 tools have rc-register rows, legacy usage registers match, --help rc=0 battery live (run.sh:569-571).

Evidence index: oc-harvest-sweep:72,:78,:14,:82,:26,:64,:23 · oc-upstream-delta:31,:32,:33-34,:208-219 · oc-branch-sweep:64,:37 · oc-seal-state:44,:116 · oc-ci-parity:22-23 · oc-pr-atomicity:36 · oc-issue-sweep:26 · RC-CONTRACT conventions block · tools/tests/run.sh:569-571.
