# ADR-0018: Recalculations supersede, never overwrite

Date: 2026-10-27 · Status: Accepted · Source: [RFC-042](../../../features/2026-10-async-comp/rfc.md)

## Context
Reopened and re-closed tickets can change the compensation amount. Finance
and Seller Ops need to see what was owed at each point in time.

## Decision
Each closure creates a new calculation row. The previous ACTIVE row becomes
SUPERSEDED. Rows are never updated in place or deleted.

## Why
Full history for audits and seller disputes at almost no cost. Overwriting
was simpler but loses the trail finance needs.

## Consequences
+ Complete audit history per ticket
− Readers must always filter on `status = ACTIVE`
