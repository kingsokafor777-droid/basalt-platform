# ADR 0002: Artifact-first integration with a narrow read API

## Context

Basalt scanners are designed to run without cloud credentials in tests and emit normalized findings. Warehouse owns durable ingestion and drift modelling, while Dashboard needs a stable read contract. Direct browser-to-scanner or browser-to-object-store access would break those boundaries.

## Decision

Scanners write versioned artifacts to private storage through authorized CI or controlled ingestion. Warehouse accepts and models those artifacts. Dashboard receives only an authenticated, minimized Warehouse read API. RAG maintenance consumes a materialized model and writes a versioned index artifact. No component discovers raw cloud credentials through this pathway.

## Consequences

An API adapter and artifact admission service remain explicit follow-on deliverables. The early platform is therefore deployable without pretending that a DuckDB process is a multi-tenant public API.
