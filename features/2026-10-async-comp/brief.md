# Brief: No more lost seller compensations

Status: Approved · Owner (business): Seller Operations · Date: 2026-10-06

## Problem
When a support ticket is closed in favor of the seller, the compensation is
calculated at that moment. During campaign peaks the calculation fails and the
seller is never paid unless someone notices. Seller Ops finds roughly 40 such
cases a week through seller complaints and fixes them by hand.

## Desired outcome
Every ticket closed with a compensation decision results in a calculated
compensation, even during peaks, without manual follow-up.

## Success metric
- Compensations found missing by Seller Ops: ~40/week → 0
- Time from ticket closure to calculated compensation: under 5 minutes (p95)

## Out of scope
- Changing how compensation amounts are calculated
- Payout to the seller's account (handled by finance after calculation)

## Deadline / constraints
Before the November campaign period.

## Open questions
- [x] Is "within 5 minutes" acceptable, or must it be instant? → 5 min is fine, sellers see it the next day anyway.
- [x] What happens if a closed ticket is reopened? → See PRD R3.

## Approval
- [x] Business owner: Seller Ops lead (2026-10-07)
