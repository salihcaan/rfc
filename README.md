# comp-specs

Single source of truth for requirements and design across the compensation,
seller-data and tickets domains. Business brief → PRD → RFC live together per
feature; decisions are kept as ADRs per domain.

## Layout

```
domains/<domain>/context.md     current behavior, rules, dependencies (AI + humans read this first)
domains/<domain>/adr/NNNN-*.md  accepted decisions, one per file, never edited after acceptance
features/<yyyy-mm-slug>/        brief.md, prd.md, rfc.md + diagrams/ (sketches)
architecture/workspace.dsl      C4 model of all domains (Structurizr DSL)
templates/                      copy these to start a new feature or ADR
scripts/                        new-feature, new-adr, render-diagrams
```

## Flow

1. **Brief** – business fills `brief.md`. AI generates "Open questions". Business approves.
2. **PRD** – PM writes `prd.md` (scope, rules, acceptance criteria). AI generates open questions. PM approves.
3. **RFC** – dev writes `rfc.md` with Mermaid diagrams. Opened as a pull request;
   approvers listed in the RFC are the required reviewers. **Merge = approved.**
4. **ADR** – on merge, each decision in the RFC becomes an ADR under the owning
   domain, and `context.md` is updated.
5. **Jira** – cards are created from the RFC task list and link back here.

No layer moves forward while its "Open questions" list has unchecked items.

## Diagrams

| Kind | Tool | Where |
|---|---|---|
| Thinking / whiteboard | Excalidraw | `features/*/diagrams/*.excalidraw` (not maintained after approval) |
| Flows, sequences, states, ER | Mermaid, inline in markdown | `prd.md`, `rfc.md`, `context.md` |
| System landscape (C4) | Structurizr DSL | `architecture/workspace.dsl` |

`./scripts/render-diagrams.sh` renders every Mermaid block to SVG for the wiki.
View the C4 model locally:
`docker run -it --rm -p 8080:8080 -v $PWD/architecture:/usr/local/structurizr structurizr/lite`

## Start something new

```bash
./scripts/new-feature.sh 2026-11-comp-reopen-handling
./scripts/new-adr.sh compensation "Recalculations append, never overwrite"
```
