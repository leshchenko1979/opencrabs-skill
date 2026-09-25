# tools/instruments/

Corpus-agnostic analysis tools. **Not** fleet tools.

`tools/` is the `oc-*` fleet's namespace: tools that operate on this factory's
repos, ledger, crons and deploy chain. An instrument that reviews an arbitrary
*corpus* — any directory of markdown, any law set, any repo — is a different kind
of thing and belongs here instead.

Same rule as `tools/archive/`: the directory says what the artefact IS, so a new
instrument has an obvious home and a reader knows not to look for it in the
`oc-*` namespace.

Declared in `SKILL.md` §Canonical tooling (v0.4.254).

## Contents

*(empty — the JEV rule-xref instrument is the first intended occupant)*
