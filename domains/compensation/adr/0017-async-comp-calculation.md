# ADR-0017: Compensation is calculated asynchronously via Kafka

Date: 2026-10-27 · Status: Accepted · Source: [RFC-042](../../../features/2026-10-async-comp/rfc.md)

## Context
Synchronous calls from ticket-service to comp-service to seller-data timed
out at peak, closing tickets without a compensation (~40 lost per week).

## Decision
ticket-service emits `TicketClosed` through a transactional outbox; comp-worker
consumes it and calculates idempotently on `(ticket_id, closure_seq)`.

## Why
Decouples ticket closure from seller-data availability and makes failures
retryable and visible. Nightly batch was rejected for its 24 h delay; direct
publish without outbox was rejected because events could be lost.

## Consequences
+ Ticket closure no longer depends on seller-data uptime
+ Failures land in a DLQ with an alert instead of disappearing
− Compensation is eventually consistent (p95 under 5 min)
− New service, outbox relay and DLQ to operate (owned by Comp)
