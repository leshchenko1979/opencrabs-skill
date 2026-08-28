# opencrabs-dev — skill for OpenCrabs source operations

A multi-role agent skill that governs the OpenCrabs agent's own development
loop: upstream issue claiming, per-task git worktrees, signed commits, the
ORDER → quick-build → binary-swap → smoke-test pipeline, and upstream PR
lifecycle.

## Roles

| Role | Owns | File |
|---|---|---|
| **EDITOR** | claim issue → worktree → code → modum gate → signed commit → push → ff-merge into fork `main` → ORDER build → smoke-test on notify; upstream PR at completion | `editor.md` |
| **COMPILER** | turning ORDERs into the running binary: validate order → single-flight dispatch → watch → artifact verify → swap → health → go-signals; red-build protocol, attribution | `compiler.md` |
| **SUPERVISOR** | owning the skill itself: apply owner directives + validated editor proposals, worker-version ledger, push updates to idle workers, poll workers for input | `supervisor.md` |

`SKILL.md` is the shared core: role router (STEP ZERO), session-notify loop,
test ontology (SMOKE / CODE TESTS / FEATURE-PRESENCE — never conflated),
red-run triage heuristics, shared environment facts, upstream relations, hard
rules, and war stories.

Roles do not intersect: the Editor never swaps binaries, the Compiler never
writes feature code (two bounded sanctioned touches only), the Supervisor
never dispatches builds.

## CLI tools (`tools/`)

Deterministic rituals the roles once hand-ran, now single commands —
exit-coded, self-checking (`--selftest`), owned by the Supervisor
(PROCESS-TOOL ownership).

| Tool | Slot | Exit codes |
|---|---|---|
| `oc-order-validate <sha>` | ORDER intake (compiler Step 1) | 0 ok / 2 UNMERGED / 4 UNSIGNED |
| `oc-job-verify <run-id> <source-ref> [--features]` | run identity via job-name embed | 0 VERIFIED / 2 IN-FLIGHT / 3 FAILED / 4 REF-MISMATCH / 5 NOT-FOUND |
| `oc-artifact-verify <run-id> <bin> <marker>` | sandbox sanity + feature presence pre-swap | 0 ok / 3 marker-missing (no swap) / 4 fail |
| `oc-seal-state <sha> [...]` | baseline/orders seal before restart | 0 sealed / 4 invariant / 5 missing-input |
| `oc-post-receipts ...` | Phase A/B receipt posting | 0 ok / 1 no-token / 2 send-failed / 3 bad-args |
| `oc-index-worktree <path>` | per-worktree codegraph index | 0 ok / 4 index-failed / 5 bad-input |
| `oc-pr-atomicity <pr>` | atomicity gate: trailers vs single claimed issue | 0 ATOMIC / 1 usage / 2 NON-ATOMIC / 4 not-found |
| `oc-ci-parity` | workflows parity fork↔upstream post-merge | 0 identical / 4 DRIFT / 5 usage / 6 api |

### Tests

`tools/tests/run.sh` — one command, exit 0 only if every check passes
(selftests + the `oc-seal-state` IFS-join regression guard). Must stay green
before any version bump; tools are never edited without re-running it.

## Ledgers are local state

Operational ledgers (`workers-ledger.json`, `orders.json`, `baseline.json`)
track live worker identity / version stamps and the order + baseline journal.
They are **gitignored** — never committed. Their schemas are documented by
redacted examples:

- `workers-ledger.example.json` — worker registry: uuid, role, topic, feature,
  last_notified / last_acked version stamps. No volatile status fields —
  liveness is discovered at query time.
- `orders.example.json` — the ORDER ledger (single-flight invariant, drain on
  green, hold after red).
- `baseline.example.json` — the build baseline: sha, run id, contributors,
  feature-presence evidence.

Topic IDs and session UUIDs in these files are placeholders.

## Versioning

Frontmatter `version:` in `SKILL.md` is bumped one notch per shipped batch
(e.g. 0.4.15). Workers are notified of new versions under the Supervisor's
Duty-3 gate (idle OR >3 versions behind) with a reload-from-disk directive.