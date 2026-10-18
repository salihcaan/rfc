# Instructions for AI assistants working in this repo

This repo holds requirements (brief, PRD), designs (RFC) and decisions (ADR).

Before writing or reviewing anything in `features/<x>/`, read the
`context.md` and ADRs of every domain the feature touches.

## Open-questions pass
When asked to review a brief, PRD or RFC, append to its "Open questions"
section a checklist of questions that must be answered before the next
layer can start. Look for:
- terms used but not defined in the glossary or context files
- rules without a concrete example
- missing edge cases: duplicates, retries, reopen/undo, partial failure, empty data, peaks
- acceptance criteria that a tester could not turn into a test
- conflicts with an existing ADR or invariant (cite it)
- external dependencies with no stated failure behavior
Do not answer the questions yourself. Do not rewrite the author's text.

## Diagrams
Use Mermaid code blocks. Sequence for interactions, stateDiagram-v2 for
lifecycles, erDiagram for tables, flowchart for business flows.
System-level changes also update `architecture/workspace.dsl`.

## On RFC acceptance
Create one ADR per item in "Decisions" with `scripts/new-adr.sh`, and add
a line under "Decisions" in each affected `context.md`.
