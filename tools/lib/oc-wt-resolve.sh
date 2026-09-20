#!/usr/bin/env bash
# =============================================================================
# lib/oc-wt-resolve.sh — ONE owner of "task name -> worktree path".
#
# Sourced by BOTH worktree carriers: oc-wt (add / remove / list) and oc-start
# (the STARTED report). It exists because the two carried private copies of the
# SAME guess and the guess was wrong (fork #429, lane 4b4463d5): every verb built
# the path as "$WT_BASE/$TASK", while `oc-wt list` prints the task with a
# directory prefix STRIPPED. Measured live 2026-09-20, 143 of the 193 rows `list`
# emits have oc-wt-<task> directory names — so the tool's own listing was not
# round-trippable into its own removal verb, for the COMMON case:
#   $ oc-wt list | grep skill-glob
#   skill-glob-gate  /root/opencrabs-wt/oc-wt-skill-glob-gate  feat/...  0
#   $ oc-wt remove skill-glob-gate        -> rc 5 "no worktree at …"
#   $ oc-wt remove oc-wt-skill-glob-gate  -> rc 0 (undocumented working form)
#
# THE SHAPES, measured live 2026-09-20 (`oc-wt list`, 193 rows, ONE instant — the
# population moves as lanes add and remove worktrees):
#     143  $WT_BASE/oc-wt-<task>       canonical base, prefixed  -> candidate 2
#      48  $WT_BASE/<task>             canonical base, bare      -> candidate 1
#       1  $HOME/oc-wt-<task>          legacy home-level         -> candidate 3
#       1  $HOME/oc-work/oc-wt-<task>  a base this lib does not own -> registry
#
# RESOLUTION IS PARTITIONED BY JURISDICTION, and that is what makes each leg
# load-bearing (each is independently mutable in the selftest):
#
#   * The CANONICAL BASE is resolved BY NAME. `list` strips exactly one `oc-wt-`
#     prefix from the basename, so its inverse is exactly two names — <task> and
#     oc-wt-<task> — plus the legacy home-level form. Three candidates, and for
#     that base the ladder is COMPLETE by construction, which is why the registry
#     below is scoped to exclude it. Drop the oc-wt- candidate and the prefixed
#     shape stops resolving: the round trip goes red.
#   * EVERY OTHER BASE is resolved BY REGISTRY — the rows `oc_wt_rows` reads,
#     derived from the SAME enumeration `list` prints. A base nobody hardcoded
#     still resolves, and no new base needs a code change here. Neuter the
#     lookup and the foreign-base shape stops resolving.
#
# Enumerating remembered bases instead would have been the defect CLASS, not the
# fix: the pre-#429 fallback guessed exactly ONE non-canonical base and missed
# every other — including the prefix under its OWN base, which is the common case.
#
# Callers set GIT_BIN / REPO / WT_BASE in scope (or take the lib defaults).
# Nothing here exits or sets rc: the CALLER owns the verdict (oc-wt remove keeps
# its own rc 5 for a task with no tree anywhere).
# =============================================================================

# oc_wt_base — where `add` creates worktrees ($OC_WT_BASE wins). ONE owner: the
# two carriers used to compute this independently, in two places.
oc_wt_base() { printf '%s\n' "${OC_WT_BASE:-$HOME/opencrabs-wt}"; }

# oc_wt_rows — TSV "task<TAB>path<TAB>branch" for every worktree `oc-wt list`
# reports. The predicate (/\/oc-wt-/ or /\/opencrabs-wt\//) and the task
# derivation (basename, strip one oc-wt- prefix) ARE list's contract: changing
# them here changes both what `list` prints and what every verb resolves, which
# is the whole point of the two carriers sharing this file. A worktree with no
# `branch` line (detached HEAD) is not a row — also matching `list`.
oc_wt_rows() {
  "${GIT_BIN:-git}" -C "${REPO:-$HOME/opencrabs}" worktree list --porcelain 2>/dev/null | awk '
    /^worktree /  { wt=substr($0,10) }
    /^branch /    { br=substr($0,8)
                    if (wt ~ /\/oc-wt-/ || wt ~ /\/opencrabs-wt\//) {
                      t=wt; sub(/.*\//,"",t); sub(/^oc-wt-/,"",t)
                      print t "\t" wt "\t" br
                    }
                    wt=""; br="" }'
}

# oc_wt_candidates <task> — the canonical-base ladder, most specific first.
#   $WT_BASE/<task>        what `add` creates
#   $WT_BASE/oc-wt-<task>  what `list` strips the prefix off (the 143-of-193 case)
#   $HOME/oc-wt-<task>     the pre-existing legacy layout, kept working
oc_wt_candidates() {
  local t="${1:-}" b
  b="${WT_BASE:-$(oc_wt_base)}"
  printf '%s\n' "$b/$t" "$b/oc-wt-$t" "$HOME/oc-wt-$t"
}

# oc_wt_lookup <task> — registry jurisdiction: the first registered path whose
# derived task matches <task>, or empty. Rows under the canonical base are
# EXCLUDED: that base is the ladder's jurisdiction, and keeping the two disjoint
# is what lets either leg be neutralised alone in the selftest. A separate
# function on purpose — it is a test seam that costs production nothing.
oc_wt_lookup() {
  oc_wt_rows | awk -F'\t' -v want="${1:-}" -v base="${WT_BASE:-$(oc_wt_base)}/" '
    index($2, base) != 1 && $1 == want { print $2; exit }'
}

# oc_wt_resolve <task> — the worktree path for <task>, on stdout.
#   1. the first existing canonical-base candidate (see oc_wt_candidates)
#   2. the registry, for any other base (see oc_wt_lookup)
#   3. $WT_BASE/<task> when neither hit — the path `add` will create, which also
#      keeps `remove <unknown>` reporting "no worktree at …" (rc 5) rather than
#      silently succeeding against a guessed path.
oc_wt_resolve() {
  local t="${1:-}" c
  c="$(oc_wt_candidates "$t" | while IFS= read -r p; do
         [ -d "$p" ] && { printf '%s\n' "$p"; break; }
       done)"
  [ -n "$c" ] || c="$(oc_wt_lookup "$t")"
  [ -n "$c" ] || c="${WT_BASE:-$(oc_wt_base)}/$t"
  printf '%s\n' "$c"
}
