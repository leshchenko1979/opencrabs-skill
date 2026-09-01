# =============================================================================
# lib/oc-embed.sh — single job-name embed decoder (E2 finding 3, v0.4.72)
# =============================================================================
# Decodes the "(<40-hex>, <features>)" identity embed from a quick-build job
# name. ONE implementation: oc-job-verify and oc-artifact-verify both had
# private copies that had already drifted (grep vs sed, plus a dead identical
# fallback in oc-job-verify). Echoes "sha|features" or empty.
#
# Function form so callers keep their own gh/jq plumbing; sourcing guard
# matches lib/oc-log.sh house style.
# =============================================================================

# oc_decode_job_embed <job-name> -> "sha|features" on stdout, empty if none
oc_decode_job_embed() {
  printf '%s\n' "${1:-}" | sed -nE 's/.*\(([0-9a-f]{40}),[[:space:]]*([^)]*)\).*/\1|\2/p'
}
