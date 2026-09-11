*Bip-bwoop.* The census surface has a broken thermometer. Report follows — every line number re-read from disk this turn, cron evidence quoted from the live jobs table.

---

# Reviewer E — INTERFACE/TOPOLOGY · Duty 6 / Cycle 5

**Scope:** `tools/` surface + the upstream-drift census surface (STANDING EXTRA, owner ruling 2026-09-09 18:55Z — the next merge window must never start blind).
**Checks:** (1) tool pairs whose invocations are bound to come one after another — merge/chain candidates; (2) flags duplicating another tool's job; (3) a ritual two tools cover in half each; (4) STANDING EXTRA: patrol/census wiring (cron → `oc-upstream-delta` → census) for silent drift.
**Excluded:** anything with an approval gate between steps; wording-level duplication (lens A).
**Citation rule:** `file:line` + verbatim quote; live-cron rows quoted by name/expr/prompt (volatile store — cited by content, not line).
**Resolution status of prior-E (2026-09-06) findings:** E-1 patch-id bug FIXED inline (see E-6) · E-2 OC_GIT collision UNRESOLVED (see E-5) · E-3 identity consolidation PARTIALLY landed (`lib/oc-embed.sh` exists, sourced by oc-job-verify/oc-deploy/oc-artifact-verify — not by the three offenders) · E-5 help-stream FIXED (`tools/oc-harvest-sweep:58` `-h|--help) (usage); exit 0`).

Verdicts: **2 HIGH · 2 MED · 2 LOW** — both HIGHs are on the standing-extra surface.

---

## HIGH

### E-1 — The patrol's primary command does not exist: live cron runs `oc-upstream-delta --audit-only`, no such flag, rc 2 every run

Live cron `harvest-watch-4h` (id `1938d1ef-8e9d-4b1f-bdb2-00baa7ea7a97`, expr `15 3,7,11,15,19,23 * * *`), prompt step 2 — verbatim: `` 2. `tools/oc-upstream-delta --audit-only` (or check upstream delta) ``.

The tool does not implement `--audit-only`:

- `tools/oc-upstream-delta:163-170` — parse loop consumes only `--repo` / `--fork-origin` / `--upstream` / `--no-log` / `-h|--help`; **`:170` ` *)             usage ;;`** — an unrecognized flag falls through to `usage` → exit 2.
- `grep -rn "audit-only"` across the skill repo and the state dir: **0 hits** — the flag lives nowhere but the cron prompt. Nothing ever validated it because the prompt is outside the repo.

**Why HIGH:** the census heartbeat's own instrument call errors out on every single run. The `(or check upstream delta)` parenthetical is an escape hatch that keeps the patrol alive by hand — which is exactly the silent-drift class the standing extra exists to kill: breakage that posts no census and trips no alarm. Fix shape (single command): either add `--audit-only` to `oc-upstream-delta`'s parse loop as an alias for the existing read-only run (exit 1 = delta verdict), or correct the cron prompt to the flag that exists — then add a battery row asserting the flag answers rc 0/1, never 2.

### E-2 — Topology drift: docs promise two patrol crons posting a daily census to board topic 30220; live has one merged cron whose only delivery is a runtime-resolved session_notify with `deliver_to` EMPTY

Docs side — `fleet-directives.md:11` (verbatim): `detection = cron `upstream-shift-watch` (`ls-remote adolfousier main` every 4h, reports shifts to the owner DM; detect+report only, sync is owner-gated)` — and `fleet-directives.md:19` (HARVEST LAW, verbatim): `cron `harvest-patrol-daily` (03:00Z) runs `oc-upstream-delta`, posts the tiered backlog census (Tier-1/2/3 + counter line: fork-only commit count + open upstream PR count) to board topic 30220; the counter line is also appended to every `upstream-shift-watch` report. Zero-change days still post a one-line census (heartbeat = patrol alive).` Same two names in `CHANGELOG.md:490,496,499`.

Live side — cron_jobs table: **no** `harvest-patrol-daily`, **no** `upstream-shift-watch`. One job: `harvest-watch-4h`, `deliver_to` = **empty**, prompt opens (verbatim): `You are the merged upstream-shift watch + harvest patrol for the opencrabs fork` — and its step 3 delivers via `session_notify` to a Triage session `dynamically resolved via `oc-ledger roster --live --role triage | cut -f1``. Runtime evidence (`cron_job_runs`): 2 of the last 6 runs **errored** (`Database error: Failed to list messages for session` at 2026-09-10T23:15Z and 2026-09-11T03:15Z) — those cycles produced no patrol output at all.

The skill's own halves disagree: `triage.md:138-142` (Cron liveness patrol) knows the live name — verbatim `(e.g. harvest-watch-4h — via the cron tool, fresh receipt)` — while the law file and CHANGELOG still promise the two-name topology and the board-topic 30220 daily census, which no live job delivers (the merged job posts nowhere by cron config; a session_notify to a runtime-resolved session is delivery only if that session resolves and wakes).

**Why HIGH:** three failure modes stack: (a) `harvest-patrol-daily` in the law file names a job that does not exist — a lane or patrol checking the promise finds nothing; (b) no cron-guaranteed census lands on board topic 30220 — the advertised "heartbeat = patrol alive" one-liner is gone; (c) the merged job itself has skipped beats (2/6 runs errored). The next merge window can start blind — standing-extra wording, verbatim. Fix shape: (1) update `fleet-directives.md:11/19` + `CHANGELOG.md:490/496/499` to the live single-job topology (see E-4 for the census command), (2) give `harvest-watch-4h` a real `deliver_to` (board topic or owner DM) so a census is cron-guaranteed, (3) the liveness patrol pivot: keep `triage.md:138-142` but have it verify a census ROW landed, not merely that the job's last-run exists — a run that errors on its message queue (like 03:15Z) is a silent dead patrol.

---

## MEDIUM

### E-3 — Declared "UN-SKIPPABLE" oc-wt → oc-index-worktree chain is a phantom: the operational path never calls the indexer

- `tools/oc-wt:3` — verbatim: `oc-wt — worktree add/remove with the UN-SKIPPABLE index chain (KERNEL C7, …)` · `:7` — `-> worktree add -> CHAINED oc-index-worktree (the forgettable step` / `:8` — `that silently breaks codegraph becomes impossible to skip).`
- `SKILL.md:118` — verbatim: `editor worktree manager (index step UN-SKIPPABLE; `--force` journals before removal)`.
- Implementation: `OC_INDEX_WORKTRED`… `OC_INDEX_WORKTREE` appears **only** inside the selftest (`oc-wt:81-177`, every occurrence an `env OC_INDEX_WORKTREE="$D/idx-ok"` shim invocation); the operational add/remove bodies (`oc-wt:186-330`) contain **no** `oc-index-worktree` call and no index function — `awk 'NR>=178 && NR<=330' oc-wt | grep index|idx` → rc 1, zero matches.

**Why MED:** the interface contract between `oc-wt` and `oc-index-worktree` is declared, documented in SKILL.md as UN-SKIPPABLE, selftested against a shim — and not wired. Every real `oc-wt add` skips the "forgettable step", and the header's own promise (`silently breaks codegraph`) is precisely what is being shipped. Fix shape: in the add path, after the worktree checkout, invoke `"$(dirname "$0")/oc-index-worktree" add "$WT"` (honor `OC_WT_SKIP_INDEX=1` for the selftest instead of the env-shim), and let the remove path decide whether removal needs an index refresh; battery row asserting the call fires.

### E-4 — The law's census line has no instrument; two census surfaces exist and neither feeds the other

- Law: `triage.md:110-113` — verbatim: `run `./tools/oc-upstream-delta` and post the tiered backlog census (Tier-1/2/3 /candidates + counter line: fork-only commit count + open upstream PR count)`.
- `oc-upstream-delta` output (header `tools/oc-upstream-delta:15-19`): `BASE <sha7> / AHEAD <n> / BEHIND <n>` + `C <sha7> <subject>` + `ABSORBED-CANDIDATE` — raw counts, **no Tier-1/2/3 class, no open-PR count**. The classing and the counter line exist only as human judgment in the patrol prompt (steps 2-4: delta + `gh pr list` + classify).
- Meanwhile `oc-harvest-census` (`SKILL.md:110`, `tools/oc-harvest-census:206-209` ELIGIBLE/ELIGIBLE_REWORK lifecycle classes, registry verbs scan/check/record/sync) classifies the same population — but is wired only to the editor Phase-7 pre-flight (`editor-upstream-pr.md:172` `oc-harvest-census check <issue>`), **never consumed by the patrol**.

**Why MED:** the fruit of the harvest tooling is a hand-built census nobody's tool emits; two lifecycles (backlog tiers vs harvest eligibility) track the same upstream delta and can drift apart silently — which is the standing extra's premise. Fix shape (single command): `oc-upstream-delta --census` emitting the law's counter line (AHEAD count + open `adolfousier/opencrabs` PR count via the token the crate already uses), fed to the patrol; optionally have the patrol consume `oc-harvest-census scan` output so backlog tiers and harvest eligibility come from one registry.

---

## LOW

### E-5 — OC_GIT semantic collision — recurrence, UNRESOLVED since 2026-09-06 E-2

`tools/oc-seal-state:45` — verbatim: `GIT="${OC_GIT:-/root/opencrabs}"` (clone PATH) vs `tools/oc-upstream-delta:31` — verbatim: `GIT_BIN="${OC_GIT:-git}"` (git BINARY). Same two lines, same collision, five days after the resolution was proposed (rename seal-state's to `OC_CLONE` + battery row). Neither was touched. Exporting one value still breaks the other tool with misleading diagnostics.

### E-6 — E-1 fix landed inline; the shared extraction did not — per-commit patch-id now exists twice

`tools/oc-harvest-sweep:88-99` — per-commit loop landed (comment `:88` verbatim: `Per-commit patch-ids (lesson n=1543, template tools/oc-upstream-delta` … `:94` `BRANCH_PIDS="$(git -C "$REPO" rev-list "$BASE..$BRANCH" | while read -r c; do`). The bug (multi-commit single garbage patch-id) is FIXED — but the 2026-09-06 resolution (`lib/oc-patchid.sh`, one sourced copy) did not land: `tools/lib/` holds oc-embed.sh/oc-log.sh/oc-notify.sh/oc-snap.sh, no oc-patchid.sh, and `oc-upstream-delta:209-215` carries a second, differently-idiomed copy (`rev-list | while read` vs loop-over-rev-list, `--format=` vs bare `show`). Next patch-id change drifts two implementations. Fix shape: extract the loop into `lib/oc-patchid.sh` with a battery row.

---

## What I could not verify (stated plainly)

I did not execute the cron job or run `oc-upstream-delta --audit-only` against a live clone this turn (read-only review, no state writes); the rc-2 claim rests on the `*) usage` branch at `oc-upstream-delta:170` read this turn, plus the flag absence confirmed by parse-loop extraction. A live invocation would settle it — but the branch is unambiguous.

Evidence index: cron_jobs row `1938d1ef` (name/expr/deliver_to/prompt) · cron_job_runs rows 2026-09-10T23:15Z & 2026-09-11T03:15Z (error) · oc-upstream-delta:163-170,:31-34,:15-19,:209-215 · oc-harvest-sweep:26,:58,:88-99 · oc-wt:3,:7-8,:58,:81-177,:184,:186-330 · SKILL.md:118,:110 · triage.md:110-113,:138-142 · editor-upstream-pr.md:172 · fleet-directives.md:11,:19 · CHANGELOG.md:490,:496,:499 · oc-seal-state:45 · oc-harvest-census:206-209 · tools/lib/ (dir listing).
