*Bwoop!* And there it is — my own "TOOLS.md is CLEAN" claim was a **literal-match trap**: my first grep ran without `regex=true`, so the pattern `opencrabs-dev|fleet-directives|…` was matched as one literal string and returned "no matches" on a file that carries ten dev-process sites. That is exactly the law at `AGENTS.md:43`. Retracted and re-filed below. Writing the report.

---

# Skill-Review Report — Lens `brain-scrub`

**Lens:** `brain-scrub`
**Cycle:** 20260912
**Date:** 2026-09-12
**Reviewer role:** read-only sub-agent (no bash, no write tools)

---

## Scope actually covered

**Method note on line counts.** This registry has **no shell tool** — `tool_search("run shell command execute bash wc -l")` returned only `session_search`, `tasks_list`, `cowork_connect`, `parse_document`, `browser_navigate`. `wc -l` is therefore unavailable. Every line count below was obtained from the reader's own out-of-range error: `read_file(path, start_line=999999)` returns `Invalid input: Start line 999999 exceeds file length N`, where **N is the true line count**. Counts are real, not estimated.

**Files read IN FULL (first-hand, this session):**

| File | Lines | Bytes |
|---|---|---|
| `skills/opencrabs-dev/fleet-directives.md` | 651 | 99,870 |
| `skills/opencrabs-dev/SKILL.md` | 555 | 43,334 |
| `AGENTS.md` | 336 | 60,670 |
| `MEMORY.md` | 620 | 102,353 |
| `CODE.md` | 51 | 7,646 |
| `SOUL.md` | 12 | 1,237 |
| `USER.md` | 45 | 3,013 |
| `BOOT.md` | 157 | 10,560 |
| `HEARTBEAT.md` | 4 | 167 |

`SKILL.md` entered context via the **SKILL GATE** — a `grep` against `fleet-directives.md` was intercepted (*"This call touches '…/fleet-directives.md' which matches skill 'opencrabs-dev' … not loaded … The full skill body follows."*) and injected the entire 555-line body. That counts as read.

**Files read by TARGETED GREP only (not in full):** `TOOLS.md` (655), `SECURITY.md` (287).

**Files NOT opened:** `editor.md` (633), `hq.md` (317), `triage.md` (245), `review-lenses.md` (264), `editor-upstream-pr.md` (227), `upstream-merge-runbook.md` (220), `war-stories.md` (112), `toolsmith.md` (105), `CHANGELOG.md` (887, grepped only), `README.md` (99), `s2-swap-journal-spec.md` (76), `editor-phase7-rules.md` (33).

---

## Findings

### FINDING 1 — **HIGH** — `AGENTS.md:242` prescribes a SECOND ack row, the exact family the v0.4.159 law was written to kill

**(b) Law site + verbatim quote** — `AGENTS.md:242`:
> **Skill-change lane notify (owner order 2026-09-09 09:06Z; reload clause 09:3xZ):** every skill version bump / law change in the opencrabs-dev skill → **quiet-notify all active lanes** (`session_notify` delivery.mode="quiet") with a one-line summary of what changed (version, the laws/tools touched, any behavior change for them) **AND an explicit reload instruction** — the brief MUST tell the lane to re-read the skill per the RELOAD law (editor.md §Mid-cycle skill drift: `oc-drift-check <uuid> <new-ver> --ack`, then re-read changed role files + fleet-directives.md and **stamp `oc-ledger ack`**). …

Canonical, `fleet-directives.md:410` (verbatim):
> **`--ack` IS the ack — never prescribe a second `oc-ledger ack` after it (v0.4.159):** `oc-drift-check --ack` delegates to `oc-ledger ack` (`tools/oc-drift-check:78`), so the former wording "…then STAMP oc-ledger ack" prescribed a SECOND row for ONE adoption — the fleet-wide duplicate-ack family (lane `1a63f103` n=3717/3718 two seconds apart; `d18ce16a` n=3713/3714; `61161247` and `462181e9` ×3; `127429e6` ×2). Stamp `oc-ledger ack <uuid> <new-version>` **ONLY when drift-check ran WITHOUT `--ack`**.

**(c) State/artifact it concerns:** the live `AGENTS.md` brain file — always-loaded, so every session and factory on the box reads this line on every cold start. It is a *prescribing* site: a lane that follows it literally writes a duplicate ledger row. The very same fix already landed in `TOOLS.md:655` (*"Fixed in v0.4.159 (`0ee60738`) — '`--ack` IS the ack; never prescribe a second `oc-ledger ack` after it'"*) — so the correction exists in one brain file and is absent from the always-loaded one.

**(d) Cost already paid:** priced — n=3717/3718, n=3713/3714, plus ×3 (`61161247`, `462181e9`) and ×2 (`127429e6`); the ledger records ≈26 duplicate `(uuid, version)` pairs in a single 150-row ack window (measured, `TOOLS.md:655`). The v0.4.159 amendment (`0ee60738`) was itself the price of the wording.

**(e) Proposed remedy:** in `AGENTS.md:242`, delete the trailing `and stamp \`oc-ledger ack\`` clause, leaving the reload instruction as `oc-drift-check <uuid> <new-ver> --ack` + re-read. It is a **shrink-to-canonical** edit: canonical already lives at `fleet-directives.md:410`, so brief rule 3 (verify canonical present first) is satisfied — but brain files are append-only, so this needs explicit owner approval + `cleanup_intent`.

---

### FINDING 2 — **HIGH** — `TOOLS.md:487` teaches the RETIRED `modum check` (repeat offender: BS-H4, 2026-09-11)

**(b) Law site + verbatim quote** — `TOOLS.md:487`:
> `cargo`/`rustc`/`clippy` are FORBIDDEN on this box in ANY form (ruling 2026-06-16, hardened 2026-08-28: compile binaries moved to `/root/toolchain-disabled-20260828/` — PATH-prepend tricks and direct paths included in the ban; a working invocation is still a violation). **Lint with `modum check` (naming-policy linter, `/usr/local/bin/modum`)**; fmt via the `/usr/local/bin/rustfmt` wrapper only …

Contradicted by `MEMORY.md:42`:
> Sanctioned local tools: `/usr/local/bin/rustfmt` wrapper (fmt only) — **`modum` RETIRED (brain-scrub 2026-09-06; lint = CI dispatch)**.

And by the skill's own tombstone, `SKILL.md:388`:
> artifacts you introduced yourself**; modum RETIRED 2026-08-28; lint evidence =

**(c) State/artifact it concerns:** `TOOLS.md` — the usage-notes brain file. The line instructs a reader to run a retired binary; following it "blesses a dead binary" (the 2026-09-06 brain-scrub's own words, `reviews/skill-review-brain-scrub-20260906.md:12`).

**(d) Cost already paid:** unpriced as a defect, but **this is the third cycle it has been reported and it is still live.** It was flagged by the 2026-09-11 brain-scrub as **BS-H4 (MEDIUM)** with the line at `TOOLS.md:477` (`reviews/20260911-cycle/reports/skill-review-brain-scrub-20260911.md:34,79-82`), whose own remedy line read *"confirm the 09-06 `modum` retirement premise with HQ/owner, then sync TOOLS.md:477 to MEMORY.md:42"* (ibid. :172). The line has since **moved 477 → 487** and the sync was never done. A repeat, un-remediated finding.

**(e) Proposed remedy:** replace ``Lint with `modum check` (naming-policy linter, `/usr/local/bin/modum`)`` with `Lint/static-analysis evidence = GREEN pr-checks.yml run (modum RETIRED 2026-08-28)`. One-line substitution; canonical already present at `SKILL.md:388` + `MEMORY.md:42`, so rule 3 is satisfied — owner approval + `cleanup_intent` still required.

---

### FINDING 3 — **MEDIUM** — `TOOLS.md` carries opencrabs-dev **process law**, not just tool mechanics; the `modum` line is the sharpest instance of a broader pattern

**(b) Law sites + verbatim quotes** (all `TOOLS.md`, all dev-process content in a brain file):
- `TOOLS.md:535` — > `workers-ledger.json` `consents[]` (and any shared registry under `skills/opencrabs-dev/`) has MULTIPLE writers: HQ, Compiler, editors — often simultaneously. … Before appending:
- `TOOLS.md:544` — > `## opencrabs-dev tools — CWD rule (learned 2026-08-30)`
- `TOOLS.md:602` — > The cargo prohibition is absolute: `/usr/local/bin/cargo` is a 109-byte BLOCKED stub (exit 1). Builds and tests happen ONLY via the oc-prchecks carrier.

**(c) State/artifact it concerns:** `TOOLS.md` — the file whose own mandate (`AGENTS.md` §Dynamic tool tails) is *usage notes for dynamic tools*, while the canonical homes of these laws are `editor.md §Box law` + `SKILL.md §Shared environment facts` (box law) and `fleet-directives.md` (the write protocol / CWD rule).

**(d) Cost:** unpriced. Note the box-law restatement at `:602` is a near-duplicate of the SKILL.md/editor.md §Box law text that the 2026-08-29 lens-B review already flagged as duplicated across required reading (`reviews/20260907-duty46-cycle2/reports/skill-review-B-20260829.md:11`) — the duplication survived that cleanup and grew a `TOOLS.md` copy.

**(e) Proposed remedy:** decide per line whether it is *tool mechanics* (legitimately TOOLS.md — e.g. `TOOLS.md:647-655` `oc-ledger events --actor` trap, `TOOLS.md:632-637` rename-is-interface-change law) or *dev-process law* (`:487`, `:535-541`, `:544-546`, `:602-607`) → the latter collapse to a pointer at the canonical skill site. Owner-gated shrink.

**Self-caught correction — my earlier "TOOLS.md is CLEAN" claim was a FALSE NEGATIVE.** My first sweep used `grep(pattern="opencrabs-dev|fleet-directives|oc-ship-chain|oc-deploy|pr-checks", file_pattern="TOOLS.md")` **without `regex=true`** → the pattern matched as one LITERAL string → *"No matches found"* on a file that carries the ten dev-process sites above. Re-run with `regex=true` returned 18 hits. This is the exact trap codified at `AGENTS.md:43` (*"the built-in `grep` matches LITERALLY unless `regex=true` is passed, so a regex pattern handed to it returns 'no matches' on text that is present"*). I nearly filed a clean bill of health on it. Logging it here because a wrong-invocation silence is not a verdict.

---

### FINDING 4 — **MEDIUM** — `AGENTS.md:35,37,43` duplicate near-verbatim law whose canonical home is `fleet-directives.md §Verification-discipline additions`; `AGENTS.md:35` has DRIFTED from canonical

**(b) Law sites + verbatim quotes** — `AGENTS.md:35`:
> **Shell verdicts are read first-hand, never through a pipe (learned 2026-09-11, second occurrence in one lane).** The bash tool's shell is `/bin/sh` → **dash**, not bash: `${PIPESTATUS[0]}`, `[[ ]]` and arrays die with `sh: 1: Bad substitution` (rc=2), and `cmd | head; echo $?` reports *head's* rc, not the command's. … prefer `grep -E` over bash-isms.

Canonical, `fleet-directives.md:587`:
> **Shell verdicts are read FIRST-HAND, never through a pipe.** The bash tool's shell is `/bin/sh` → **dash**: `${PIPESTATUS[0]}`, `[[ ]]`, arrays and **`${var:0:110}`** die with `Bad substitution` (rc 2) …

**DEVIATION:** canonical lists **four** bash-isms including `${var:0:110}`; `AGENTS.md:35` lists **three** and omits `${var:0:110}`. The AGENTS.md copy is now an *incomplete* restatement of a safety rule.

`AGENTS.md:37` is verbatim-identical to canonical `fleet-directives.md:586` (payload-path example and all). `AGENTS.md:43` is a superset of canonical `fleet-directives.md:588` (it carries additional log-forensics + delegating-wrapper material).

**(c) State/artifact:** `AGENTS.md`, always-loaded — three near-full copies of a law whose canonical home is the skill, one of them drifting.

**(d) Cost:** unpriced. The 2026-09-11 brain-scrub flagged three of these as *"a pure shrink job, no land-first needed"* (`reviews/20260911-cycle/reports/skill-review-brain-scrub-20260911.md:19`); still on disk 2026-09-12.

**(e) Proposed remedy:** collapse `AGENTS.md:35/37/43` to one-line pointers at `fleet-directives.md §Verification-discipline additions`, after first syncing `${var:0:110}` into the canonical copy if the AGENTS.md form is the newer one (it is not — canonical is the richer/safer text). Owner-gated.

---

### FINDING 5 — **MEDIUM** — `MEMORY.md` carries discipline laws (brief rule 2), each already canonical in the skill

**(b) Law sites + verbatim quotes:**
- `MEMORY.md:185` — > `## Lesson — multi-profile box: NEVER reap "old-binary" daemons (2026-08-28, ledger 1273)`. Canonical: `fleet-directives.md:518` — > `## Daemon no-reap — ruling 1273 (landed in skill 2026-09-06, brain-scrub F5; law previously only in MEMORY.md)`.
- `MEMORY.md:190` — three-pillar re-verification of INHERITED claims. Canonical: `fleet-directives.md:524` — > `## Inherited-claim three-pillar verification (landed in skill 2026-09-06, brain-scrub F6; previously only in MEMORY.md)`.
- `MEMORY.md:222` — > `## Session targeting (owner correction 2026-09-01)` — a NEVER-rule in passive memory.
- `MEMORY.md:393` — > `## Hand-rolled detached poller = skill violation (owner correction 2026-09-09, "See the skill")` — binding dev-process law. Canonical: `fleet-directives.md` §CI-wait discipline (W1).

**(c) State/artifact:** `MEMORY.md`, the passive brain file — never auto-loaded, so a directive there **does not bind on a cold session** (shipped-template law, quoted at `AGENTS.md:142`).

**(d) Cost:** unpriced, and *deliberately so* — the two `fleet-directives.md` headings themselves record **"brain-scrub F5" / "brain-scrub F6"**, i.e. prior cycles landed the canonical copy and flagged the MEMORY.md copy but did not remove it, correctly (rule 3: shrinks need owner approval). This is an open, re-reported debt, not a new discovery.

**(e) Proposed remedy:** owner-approved scrub of `MEMORY.md:185/190/222/393` (and `MEMORY.md:40-42`) once the canonical presence is re-verified — which this pass did verify (`fleet-directives.md:518,524`). Note `MEMORY.md:42` is the *counterpart* of Finding 2 and must be **kept** (it is the correct, current statement) — the fix is to sync `TOOLS.md:487` to it, not to remove it.

---

### FINDING 6 — **LOW/MEDIUM** — `BOOT.md` points at an `AGENTS.md` section that does not exist

**(b) Law site + verbatim quote** — `BOOT.md:4`:
> **Owns:** startup + runtime self-maintenance — … **Memory-save triggers live in AGENTS.md, which is always-loaded (#1003).**

and `BOOT.md:34`:
> → **AGENTS.md → When to write to memory** owns the trigger list.

**Receipt that the target is absent:** `grep(pattern="When to write to memory|Memory-save triggers|Auto-Save Important Memories|memory", regex=true, AGENTS.md)` returned 8 hits — lines 21, 37, 53, 142, 145, 192, 217, 238 — **none of which contains "When to write to memory" or "Memory-save triggers"**. AGENTS.md's nearest section is *"Memory — new-rules routing law"* (`AGENTS.md:~140`), which routes new rules but is **not** a "when to write to memory" trigger list. `BOOT.md:38` repeats the pointer (*"→ **AGENTS.md → When to write to memory** owns the trigger list."*).

**(c) State/artifact:** `BOOT.md` (a brain file that *is* loaded on startup) advertises a section that `AGENTS.md` does not carry — so the memory-save trigger list is homeless.

**(d) Cost:** unpriced. This is the same failure class the 2026-08-29 lens-B review hit with a `compiler.md` pointer into a retired runbook (`reviews/…/skill-review-B-20260829.md:19,126`).

**(e) Proposed remedy:** either (i) add the trigger list to `AGENTS.md` under the existing memory section, or (ii) repoint `BOOT.md:4/34/38` at wherever the triggers actually live. First **confirm** the triggers are not in a file I did not open (`BOOT.md` was read in full; the section is not in AGENTS.md; it may live in the shipped template). Do not delete the pointer on this pass alone — it is a dangling reference, and the fix is a move-with-verification.

---

## What I checked and found CLEAN

- **`AGENTS.md` §"OpenCrabs dev — rules live in the skill"** is correctly **pointer-shaped** — *"All opencrabs-dev owner rulings … live in `~/.opencrabs/profiles/ops/skills/opencrabs-dev/fleet-directives.md`"* + the POST-COMPACTION LAW anchor. Exactly the permitted shape (brief rule 1).
- **`AGENTS.md:242`'s *policy* clause** (notify every lane with an explicit reload instruction) is correct and matches canonical — **only** the trailing *"and stamp `oc-ledger ack`"* is the defect (Finding 1).
- **`MEMORY.md:1-4`** carries the correct pointer + scrub provenance: *"opencrabs-dev records live in the skill: `skills/opencrabs-dev/fleet-directives.md` (owner directives) + `war-stories.md` (lessons). Scrubbed 2026-09-02."* — clean.
- **`fleet-directives.md:477-485`** (the brain-scrub brief itself) is correctly placed: CHANGELOG I-7.2 ruled it KERNEL, since moving it would duplicate a brief across two files. Clean.
- **`CODE.md`** (51 lines, read in full) — owns coding standards and correctly declares *"(engineering precedent; process law belongs to the project skill)"*. Its content is code-level engineering lessons, not dev-process law. Clean.
- **`SOUL.md`** (12) / **`USER.md`** (45) / **`HEARTBEAT.md`** (4) — read in full; identity/preference/runtime content only, **no** opencrabs-dev process law. Clean.
- **`SECURITY.md`** (287) — grepped for `opencrabs-dev|fleet-directives|oc-deploy|oc-ship-chain|pr-checks|swap` → **No matches found** (this grep ran with `regex=true`; unlike my TOOLS.md false negative, the invocation was correct). Clean on dev-process law.
- **`fleet-directives.md:518,524`** — canonical copies of the daemon-no-reap and inherited-claim laws **verified present** (rule 3 precondition for Finding 5's remedy). Clean.

---

## What I did NOT check (scope limits)

1. **Role files were not opened in full:** `editor.md` (633), `hq.md` (317), `triage.md` (245), `toolsmith.md` (105), `review-lenses.md` (264), `editor-upstream-pr.md` (227), `upstream-merge-runbook.md` (220), `war-stories.md` (112), `editor-phase7-rules.md` (33), `s2-swap-journal-spec.md` (76), `README.md` (99). Any brain-file law whose canonical home is *inside* one of these was therefore not cross-checked for presence — Findings 3 and 5 remedies depend on canonical homes I verified in `fleet-directives.md`/`SKILL.md`, not in the role files.
2. **`CHANGELOG.md` (887)** — grepped only; no line-by-line provenance audit.
3. **`TOOLS.md` (655)** — targeted greps only, not a full read; there may be further dev-process sites beyond the 18 hits, and further stale-tool references beyond `modum`.
4. **`SECURITY.md` (287)** — one grep only.
5. **No filesystem write verification** — I did not (and could not) check `.bak` provenance, git history, or whether any of these lines were already queued for removal by another lane.
6. **No ledger forensics** — costs cited (n=3717/3718 etc.) are quoted from the canonical law text and `TOOLS.md:655`, **not** re-derived from `workers-ledger.json` this session.

---

## Persistence note

The brief (`fleet-directives.md:485`) states: *"Reports persist via `oc-review-persist brain-scrub <text|@file>`."* **I cannot run it.** This sub-agent's registry contains no shell/bash tool (verified — `tool_search` for a shell returned none), so `oc-review-persist` is unreachable from here, and my role is read-only in any case. **The calling HQ lane must persist this report verbatim** via `oc-review-persist brain-scrub @<file>` (or inline text). The report above is complete and self-contained for that purpose.

---

## Verdict summary

| # | Severity | Site | Class |
|---|---|---|---|
| 1 | **HIGH** | `AGENTS.md:242` | Duplicate-ack law re-prescribed in always-loaded file; canonical `fleet-directives.md:410` |
| 2 | **HIGH** | `TOOLS.md:487` | Retired tool (`modum`) taught as live — **repeat of BS-H4, 3rd cycle** |
| 3 | MEDIUM | `TOOLS.md:535/544/602` (+`487`) | Dev-process law in a tool-notes brain file |
| 4 | MEDIUM | `AGENTS.md:35/37/43` | Near-verbatim law duplication; `:35` drifted (missing `${var:0:110}`) |
| 5 | MEDIUM | `MEMORY.md:185/190/222/393` | Discipline laws in passive memory (canonical verified present) |
| 6 | LOW/MED | `BOOT.md:4/34/38` | Dangling pointer to a non-existent AGENTS.md section |

**Clean:** `AGENTS.md` dev-rules section (pointer-shaped) · `MEMORY.md:1-4` pointer · `CODE.md` · `SOUL.md` · `USER.md` · `HEARTBEAT.md` · `SECURITY.md` (dev-law) · the brain-scrub brief's own placement.

**Self-caught error, logged:** my first `TOOLS.md` sweep reported "CLEAN" off a literal-match grep (no `regex=true`) — a wrong-invocation silence, the exact trap at `AGENTS.md:43`. Retracted; re-run returned 18 hits and became Finding 3.
