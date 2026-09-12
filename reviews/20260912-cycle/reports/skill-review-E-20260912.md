All citations are in hand. Emitting the complete report as the final message.

---

# Duty-6 Skill Review — Reviewer E (TOOLS family, INTERFACE/TOPOLOGY lens)

**Cycle:** 20260912 · **Date:** 2026-09-12 · **Lens:** E (duplicate / chainable interfaces) · **Mode:** READ-ONLY (nothing written, created, or deleted)

**Delivery note (persist-on-receipt).** This reviewer's tool registry has **no file-write capability** — the report cannot be written to `/tmp/duty6/lens-E.md`. Per `hq.md` Duty 6 step 3 fallback ("a read-only reviewer cannot write files — HQ's persist-on-receipt (`oc-review-persist`, byte-count + sha256 verified) counts as delivery"), the report arrives as this push and is persisted verbatim by HQ. No disk copy exists by design.

**Line-count method substitution (stated for HQ's poll triple-check).** `wc -l` is unavailable in this sub-agent's read-restricted registry (capability note #1173: no shell, no file writes). Every line count below was obtained from the **file-length field of a deliberate out-of-range `read_file` call** (`start_line=999999` → `Start line 999999 exceeds file length N`, where N is the true line count). Counts are **exact, not estimated**; the method is the substitute for `wc -l`, not an estimate of it.

---

## Scope actually covered

**Corpus root:** `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/`

| File | Lines |
|---|---|
| `SKILL.md` | 555 |
| `fleet-directives.md` | 651 |
| `editor.md` | 633 |
| `hq.md` | 317 |
| `triage.md` | 245 |
| `toolsmith.md` | 105 |
| `editor-upstream-pr.md` | 227 |
| `review-lenses.md` | 264 |
| `tools/RC-CONTRACT.md` | 113 |

**`tools/` surface read (full):** `oc-wt` (296) · `oc-upstream-delta` (271) · `oc-roster` (325) · `oc-roster-selftest` (187) · `oc-index-worktree` (66) · `oc-shadow-rotate` (45) · `oc-attrib` (196) · `oc-harvest-sweep` (107) · `oc-seal-state` (238) · `oc-drift-check` (155) · `oc-skew-scan` (107) · `oc-smoke-evidence` (184) · `oc-harvest-census` (512) · `hq.md`.

**`tools/` surface read (usage/register only):** the whole `oc-*` set via the RC-CONTRACT register + a wide usage-header grep (which **truncated at 50 KB** — see scope limits). `oc-deploy` (2991 lines) was surveyed only at its dispatch/usage surface, never read in full.

No behavioral probe was executed (read-only role) — **every finding below is a static-text claim.**

---

## Findings

### E-1 · MED · `oc-wt`'s retired index chain is still advertised on the highest-traffic surfaces (header, `--help`, SKILL.md, RC register)

**Law/interface sites (verbatim):**
- `tools/oc-wt:3` — `# oc-wt — worktree add/remove with the UN-SKIPPABLE index chain (KERNEL C7,`
- `tools/oc-wt:7` — `#         -> worktree add -> CHAINED oc-index-worktree (the forgettable step`
- `tools/oc-wt:15` — `# names the branch, oc-wt only executes creation + the un-skippable index`
- `tools/oc-wt:27` — `#       4 index failed (tree KEPT, warning verbatim) / 5 repo/branch not found`
- `tools/oc-wt:50` — `Exit: 0 ok / 2 usage / 3 path-exists-or-dirty / 4 index-failed / 5 repo-or-branch-missing / 6 behind-base`
- `SKILL.md:115` — `| `./tools/oc-wt add\|remove\|--force` | editor worktree manager (index step UN-SKIPPABLE; `--force` journals before removal) |`
- `tools/RC-CONTRACT.md:35` — `| oc-index-worktree | 0 | 5 | 0 OK / 4 index-failed |`
- `tools/RC-CONTRACT.md:14` — ``  `oc-job-verify` 1, `oc-order-validate` 1, `oc-index-worktree` 5, ``

**Counter-evidence — the chain was RETIRED on purpose:**
- `CHANGELOG.md:170` — `- **Worktree Indexing Retirement (`tools/oc-wt`, `editor.md`, `fleet-directives.md`)**: Removed chained `oc-index-worktree` execution from `tools/oc-wt add`. Code structure exploration routes to centralized daemon `memory_search(scope="external")`. Cleaned 69 redundant `.codegraph` directories (~5.8 GB reclaimed).` (entry under **v0.4.143 (2026-09-11)**)
- `fleet-directives.md:646` — `- **Per-worktree `.codegraph` indexing is RETIRED**: Worktrees do NOT run `oc-index-worktree` or maintain separate `.codegraph.db` SQLite instances.`

**Absence proof (query + scope, per D-brief discipline):** `grep -n 'index' tools/oc-wt` (regex, case-insensitive, scope = that one file) → **19 matches, every one a comment or a selftest env assignment** (`:3,:7,:15,:27,:50,:57,:78,:80` comments; `:81,:89,:95,:98,:103,:149,:152,:162,:165,:171,:177` all `env OC_INDEX_WORKTREE="$D/idx-ok"` shim invocations). The operational `add` path contains **no `oc-index-worktree` call**, and `OC_INDEX_WORKTREE` is **set by the selftest but never read** by the tool. Corroborating absence: `grep 'oc-index-worktree' SKILL.md` → **0 matches** — SKILL.md's tool-table row was removed by the retirement, but SKILL.md:**115**'s `oc-wt` description still says "index step UN-SKIPPABLE".

**State/artifact:** the `oc-wt` `--help` output (what a lane reads before every worktree creation) and the SKILL.md tool table — which `editor.md` Phase 1 step 0 re-reads **in full** on every claim.

**Cost:** `unpriced` (no incident or ledger row located for the stale doc; the retirement itself is v0.4.143).

**Remedy (single-command shape, corrected from the 20260911 cycle):** the chain is retired by design, so the fix is **to delete the stale claims, not re-wire them** — strip the index chain from `oc-wt:3/:7/:15/:27/:50` (header + `--help`), drop "index step UN-SKIPPABLE" from `SKILL.md:115`, and either delete the `oc-index-worktree` rows (`RC-CONTRACT.md:14/:35`) or mark the tool ARCHIVED/INTERNAL-retired the way `oc-post-receipts` is marked in SKILL.md. Drop the now-dead `OC_INDEX_WORKTREE` selftest scaffolding (`oc-wt:78-81` + the `env` shims).
**Self-correction (disclosed):** the **20260911 E cycle filed this same surface as a wiring gap** (`reviews/20260911-cycle/reports/skill-review-E-20260911.md:44`, "the operational path never calls the indexer"), with the remedy "invoke `oc-index-worktree` in the add path". That remedy is now **wrong** — v0.4.143 retired the chain deliberately. The residue today is documentation, not a wiring gap. F-adjacent: the dead env var / unreachable rc-4 is tool-code (Reviewer F territory); E frames it as the declared-vs-real interface.

---

### E-2 · MED · `oc-roster-selftest` is a second top-level executable that exists only to serve `oc-roster` — and its register count contradicts the other register

**Law/interface sites (verbatim):**
- `SKILL.md:111` — `| ./tools/oc-roster-selftest | hermetic test runner for roster generation and classification |`
- `tools/RC-CONTRACT.md:49` — `| oc-roster-selftest | 0 | 1 | 0 PASS / 1 FAIL / 2 usage · hermetic fixture-based runner for oc-roster validation |`
- `tools/oc-roster:321` — `  --selftest|selftest) "$SELF_DIR/oc-roster-selftest" ;;`
- `tools/oc-roster:36` — `#   oc-roster --selftest          offline fixtures (no network, no live DB)`

**Contradiction found (two registers disagree on the same interface):**
- `tools/RC-CONTRACT.md:48` (oc-roster row) — `… `--selftest` runs 31 offline fixture checks`
- `SKILL.md:125` (oc-roster row) — `… `--selftest` = 44 checks.`

Two registers, two counts (31 vs 44) for one `--selftest`. Not adjudicated here (would need a live run); reported as an interface-register inconsistency.

**State/artifact:** the `tools/` census (any law-lint/census pass counts 39 `oc-*` files, this one included) and the RC-CONTRACT register.

**Cost:** `unpriced`.

**Remedy:** fold the fixture body into `oc-roster` as `cmd_selftest` — the in-file pattern used by `oc-drift-check`, `oc-skew-scan`, `oc-upstream-delta`, `oc-wt`, `oc-harvest-census` (all keep their selftest in-file) — and delete the separate file + its RC-CONTRACT row. If kept for size, relabel the `RC-CONTRACT.md:49` row **"internal helper of oc-roster — not a tool"** so census passes stop counting it, and reconcile the 31/44 count against one source.

---

### E-3 · LOW · three interfaces answer the version-state question (re-filed with the prior ruling named)

**Law/interface sites (verbatim):**
- `tools/oc-ledger:56` — `#   check-version                          SKILL.md vs 3 ledger fields (RO)`
- `tools/oc-skew-scan:3` — `# oc-skew-scan — C4: worker version skew vs the current skill version.`
- `tools/oc-skew-scan:10` — `#   oc-skew-scan [--ledger <canonical path>] [--current <v>] | --selftest`
- `tools/oc-drift-check:6` — `# Usage: oc-drift-check <uuid> <claimed-version> [--ack] [--skill-dir <path>]`
- `SKILL.md:95` — `| `./tools/oc-skew-scan [--ledger f] [--current v]` | ledger worker-version skew vs current skill version (HQ roster review) |`
- `tools/RC-CONTRACT.md:54` — `| oc-skew-scan | 0 | 2 | 0 clean / 1 skew / 3 parse-fail |`

**Prior ruling on this exact question (must be surfaced, not presented as open):** `reviews/20260907-duty46-cycle2/reports/skill-review-E-20260901.md:33` — verbatim: `6. Considered and rejected (no finding): oc-drift-check vs oc-skew-scan vs oc-ledger check-version (distinct sources);`. The prior E cycle closed this as "distinct sources".

**What is new:** all three read the **same** `workers-ledger.json` — `oc-skew-scan` is a pure read-only projection of it with an rc-1 verdict (RC-CONTRACT.md:54), `oc-ledger check-version` reads SKILL.md + the ledger's own version fields, `oc-drift-check` takes the claimed version as an argument and only **writes** on `--ack` (`oc-drift-check:78` delegates to `oc-ledger ack`). The "distinct sources" reasoning is thin for `oc-skew-scan` specifically.

**State/artifact:** `SKILL.md` frontmatter `version:` + `workers-ledger.json` `.workers[].last_acked.version` / `.last_notified.version` / `.meta.skill_version`.

**Cost:** `unpriced`.

**Remedy:** give `oc-skew-scan` a verb home — `oc-ledger skew [--current <v>] [--ledger <f>]` (rc 0 clean / 1 skew / 3 parse-fail, matching the `oc-ledger claims` NO-MATCH convention) — and leave `oc-skew-scan` a 3-line shim or repoint its call sites. `oc-drift-check` stays standalone (it writes). **HQ note:** if HQ holds the 20260901 "distinct sources" rejection, this is closed — re-opened here only because the ledger-source overlap was not in that reasoning.

---

### E-4 · MED · STANDING EXTRA — `oc-upstream-delta --json` silently drops the per-commit census rows the TSV mode carries

**Law/interface sites (verbatim):**
- `tools/oc-upstream-delta:16` — `# Output: TSV lines on stdout —`
- `tools/oc-upstream-delta:204` — `if [ "$JSON_OUT" -eq 0 ]; then` (guards the C-row emission below)
- `tools/oc-upstream-delta:210` — `emit_commits() { # $1=range $2=tag — C rows, sha7 + subject`
- `tools/oc-upstream-delta:216` — `  emit_commits "$FORK_REF..$UP_REF" behind   # what upstream gained, first`
- `tools/oc-upstream-delta:217` — `  emit_commits "$UP_REF..$FORK_REF" ahead    # our fork-only delta`
- `tools/oc-upstream-delta:246` — `if [ "$JSON_OUT" -eq 1 ]; then` → the `python3 -c` dict at `:251-258`, whose keys are exactly `base, ahead (int), behind (int), absorbed (int), absorbed_candidates [{fork_sha, upstream_sha}]` — **no commit identities for ahead/behind**.
- `tools/RC-CONTRACT.md:57` — `| oc-upstream-delta | 0 | 2 | 0 clean / 1 delta (verdict) / 3 fetch-git-fail · `--json` outputs JSON object with base, ahead, behind, absorbed, and absorbed_candidates list |`

**State/artifact:** the upstream-drift census consumed by the merge-window decision (`hq.md §Upstream sync — Watch`). The STANDING EXTRA (owner ruling 2026-09-09 18:55Z) names exactly this risk: *"the next merge window must never start blind."*

**Cost:** `unpriced`.

**Remedy:** add `"behind_commits": [{"sha":…,"subject":…}]` and `"ahead_commits":[…]` to the JSON dict (`oc-upstream-delta:251-258`) so a JSON consumer can name the commits, and register the added fields at `RC-CONTRACT.md:57`; **or** state plainly in the row that `--json` is counts-only and a merge window needing identities must use the TSV mode.

---

### E-5 · LOW · `oc-upstream-delta`'s `emit_commits` carries a dead `$2=tag` parameter (F-adjacent)

**Site (verbatim):** `tools/oc-upstream-delta:210` — `emit_commits() { # $1=range $2=tag — C rows, sha7 + subject`. The body (`:211-213`) references **only `$1`**; callers at `:216`/`:217` pass `behind`/`ahead`, so `$2` is accepted and never used.

**State/artifact:** the TSV `C` rows (which the header implies are tagged ahead/behind but are not).
**Cost:** `unpriced`.
**Remedy:** drop the parameter, or use it to tag `C` rows so ahead/behind rows are distinguishable in the TSV — which `oc-upstream-delta:16` implies but the output does not deliver.

---

## What I checked and found CLEAN

- **`lib/oc-notify.sh`** — single owner of the wake logic (no duplicate in the tool bodies read).
- **`oc-seal-state` + `oc-harvest-sweep`** — both delegate Session-Id extraction to `oc-attrib --trailers-only`: delegation, not duplication.
- **`oc-commit`** — delegates its post-commit comment to `oc-issue-log` (no second comment path).
- **`oc-deploy contributors`** — RETIRED into `oc-attrib --contributors` (SKILL.md row confirms the retirement + the pointer).
- **`oc-shadow-rotate`** — chained as the tail step of `oc-ledger sync` (SKILL.md row: "INTERNAL tail step of `oc-ledger sync`").
- **`oc-drift-check`** — correctly delegates its write to `oc-ledger ack` (`:78`); it is the editor-ritual wrapper (`--ack`), not a duplicate of `oc-ledger check-version`.
- **Harvest trio (`oc-harvest-census` → `oc-harvest-dispatch` → `oc-harvest-sweep`)** — explicitly **not** a merge candidate: the PR-shipment owner approval gate sits between the steps, and E's brief excludes anything with an approval gate between steps (a gate is human judgment).
- **`oc-roster` `--role` rejection** — correctly cross-referenced to `oc-ledger roster --live --role` in `SKILL.md:125`; the interface tells the caller where the verb actually lives.

---

## What I did NOT check (scope limits)

- **`oc-deploy` (2991 lines)** — surveyed only at its dispatch/usage surface; not read in full. Any interface finding inside its ship/poll/swap chain is unreviewed.
- **`oc-ledger` (1822)**, **`oc-ship-chain` (1469)**, **`oc-health` (884)**, **`oc-notify-fanout` (806)**, **`oc-prchecks` (807)**, **`oc-harvest-dispatch` (671)**, **`oc-harvest-census` (512)** — usage/register surface only; their internal verb sets were not enumerated against each other.
- **The wide usage-header grep truncated** (`[Output truncated: 75976 → 50000 bytes]`); tools alphabetically after `oc-carrier-features` were not swept by that pass (they were covered via the RC-CONTRACT register + targeted reads, not exhaustively).
- **No live invocation of any tool** — no `--help`, no selftest, no probe. All findings are static-text claims; the 31-vs-44 selftest-count contradiction in E-2 is reported, not adjudicated.
- **`tools/tests/run.sh`** was read only through grep hits (the battery's `run_selftest` roster), never in full.
- **`archive/`** and **`lib/`** were not reviewed.

---

*End of Reviewer E report — cycle 20260912, 2026-09-12. Read-only; nothing written, created, or deleted. Five findings (2 MED interface, 1 MED STANDING-EXTRA, 2 LOW), all carrying a verbatim `file:LINE` quote.*
