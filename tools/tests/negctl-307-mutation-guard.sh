#!/usr/bin/env bash
# Mutation guard for #307 — proves the anchored Issue-Ref negative controls are
# LIVE, not vacuous.
#
# A negative control that cannot fail is decoration. This guard reverts the
# anchored matcher to the pre-#307 unanchored `git log --grep=#N` on a COPY of
# the tools tree and requires every selftest to FAIL on that copy while the
# unmutated copy stays green. If a prose-only control passes under the mutant,
# it is not testing what it claims to.
#
# Covers all three control sites:
#   (1) tools/oc-harvest-census --selftest
#   (2) tools/oc-harvest-dispatch --selftest   (legs 11e/11f)
#   (3) tools/tests/run.sh §00c lib/oc_claims unit cases
#
# Harness guards (AGENTS.md §Repro harnesses): explicit tool path, recursion
# guard, process budget cap.
set -u
[ "${OC_REPRO_DEPTH:-0}" -ge 1 ] && exit 99
export OC_REPRO_DEPTH=1
ulimit -u $(( $(ps -e --no-headers | wc -l) + 200 )) 2>/dev/null || true

SKILL_DIR="/root/.opencrabs/profiles/ops/skills/opencrabs-dev"
SRC="$SKILL_DIR/tools"
export OC_TOOLS_NOLOG=1

WORK="$(mktemp -d)"
cleanup() { rm -rf "$WORK"; }
trap cleanup EXIT

fails=0
ok()  { echo "  ok   - $1"; }
bad() { echo "  FAIL - $1"; fails=$((fails + 1)); }

echo "=== #307 mutation guard ==="

# --- two independent copies of the tools tree -------------------------------
cp -a "$SRC" "$WORK/baseline" || { echo "copy failed"; exit 2; }
cp -a "$SRC" "$WORK/mutant"   || { echo "copy failed"; exit 2; }

# --- mutate the matcher back to the pre-#307 unanchored form ----------------
if ! python3 - "$WORK/mutant/lib/oc_claims.py" <<'PYEOF'
import re, sys
path = sys.argv[1]
src = open(path).read()
MUTANT = '''def resolve_issue_commits(repo_path, iss, ref="--all", index=None):
    """MUTANT (mutation guard): the pre-#307 unanchored grep."""
    out = _git(repo_path, "log", "-n", "10", "--grep=#%d" % int(iss), "--format=%H")
    if not out:
        return []
    return [s.strip() for s in out.split() if s.strip()]


'''
pat = re.compile(r'^def resolve_issue_commits\(.*?(?=^def )', re.S | re.M)
new, n = pat.subn(MUTANT, src)
if n != 1:
    sys.stderr.write("mutation guard: expected exactly 1 substitution, got %d\n" % n)
    sys.exit(2)
open(path, "w").write(new)
print("  mutated: resolve_issue_commits -> unanchored `git log --grep=#N`")
PYEOF
then
  bad "could not apply the mutation — guard is inert"
  echo
  echo "MUTATION GUARD FAILED (failures=$fails)"
  exit 1
fi

# Confirm the mutant really is the unanchored form (a no-op mutation would make
# this whole guard vacuous while still reporting PASS on every leg below).
if grep -q 'MUTANT (mutation guard)' "$WORK/mutant/lib/oc_claims.py" \
   && grep -q -- '--grep=#%d' "$WORK/mutant/lib/oc_claims.py"; then
  ok "mutant carries the unanchored grep"
else
  bad "mutant does not carry the unanchored grep — guard is inert"
fi

# --- extract the §00c lib unit cases from run.sh ----------------------------
sed -n '/cat > "\$OCT\/unit.py" << .PYEOF./,/^PYEOF$/p' "$SRC/tests/run.sh" \
  | sed '1d;$d' > "$WORK/unit.py"
if [ -s "$WORK/unit.py" ]; then
  ok "extracted lib unit cases ($(wc -l < "$WORK/unit.py" | tr -d '[:space:]') lines)"
else
  bad "could not extract lib unit cases from run.sh"
fi

# --- run a selftest, report its rc -----------------------------------------
run_st() {  # run_st <label> <tool-path> -> echoes rc
  local label="$1" tool="$2" rc=0 out=""
  out="$(timeout 600 "$tool" --selftest 2>&1)" || rc=$?
  printf '%s' "$out" > "$WORK/last.out"
  echo "$rc"
}

# --- (1) census -------------------------------------------------------------
echo
echo "[1] oc-harvest-census --selftest"
rc_base="$(run_st census "$WORK/baseline/oc-harvest-census")"
if [ "$rc_base" = "0" ]; then ok "baseline census GREEN (rc=0)"; else bad "baseline census rc=$rc_base (expected 0)"; fi
rc_mut="$(run_st census-mut "$WORK/mutant/oc-harvest-census")"
if [ "$rc_mut" != "0" ]; then
  ok "mutant census CAUGHT (rc=$rc_mut)"
  grep -m1 -iE 'prose|fence|#307' "$WORK/last.out" | sed 's/^/         /' || true
else
  bad "mutant census PASSED — the prose-only control does not catch the regression"
fi

# --- (2) dispatch -----------------------------------------------------------
echo
echo "[2] oc-harvest-dispatch --selftest"
rc_base="$(run_st dispatch "$WORK/baseline/oc-harvest-dispatch")"
if [ "$rc_base" = "0" ]; then ok "baseline dispatch GREEN (rc=0)"; else bad "baseline dispatch rc=$rc_base (expected 0)"; fi
rc_mut="$(run_st dispatch-mut "$WORK/mutant/oc-harvest-dispatch")"
if [ "$rc_mut" != "0" ]; then
  ok "mutant dispatch CAUGHT (rc=$rc_mut)"
  grep -m1 -E 'bad 11e|bad 11f|#307' "$WORK/last.out" | sed 's/^/         /' || true
else
  bad "mutant dispatch PASSED — legs 11e/11f do not catch the regression"
fi

# --- (3) lib unit cases -----------------------------------------------------
echo
echo "[3] lib/oc_claims unit cases (run.sh 00c)"
if python3 "$WORK/unit.py" "$WORK/baseline/lib" >"$WORK/unit_base.out" 2>&1; then
  ok "baseline lib unit cases GREEN"
else
  bad "baseline lib unit cases failed (expected green)"
  sed 's/^/         /' "$WORK/unit_base.out" | head -5
fi
if python3 "$WORK/unit.py" "$WORK/mutant/lib" >"$WORK/unit_mut.out" 2>&1; then
  bad "mutant lib unit cases PASSED — the #307 cases do not catch the regression"
else
  ok "mutant lib unit cases CAUGHT"
  grep -m1 -E '#307' "$WORK/unit_mut.out" | sed 's/^/         /' || true
fi

echo
if [ "$fails" -eq 0 ]; then
  echo "MUTATION GUARD PASSED — every #307 control fails under the mutant"
  exit 0
fi
echo "MUTATION GUARD FAILED (failures=$fails)"
exit 1
