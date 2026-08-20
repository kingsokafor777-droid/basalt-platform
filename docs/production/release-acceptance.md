# Production Release Acceptance Criteria

A Basalt production release is approved only when every item below has objective evidence. A passing unit test or a rendered Helm manifest alone is insufficient.

## Application and data plane

- Dashboard analytics procedures require an authenticated user and enforce the configured organization identifier.
- Dashboard reads production analytics only through an authenticated Warehouse read adapter; fixture seeding is disabled in production.
- Warehouse read responses are schema-versioned, paginated, bounded, and audited.
- RAG indexes are generated from a versioned Warehouse export and citations resolve to retained source documents.
- Agent remains offline and review-only; no cluster service account or GitHub token can publish an Agent patch.

## Artifact and dependency supply chain

- Each deployed service has a reproducible multi-stage container build.
- Every image is vulnerability-scanned, has an SBOM, carries provenance, is signed, and is published to the private registry.
- Helm production values use immutable image digests.
- Critical dependency advisories are zero unless a time-bounded, reviewed exception exists.
- Python cross-repository dependencies resolve from an immutable registry version or a documented immutable source reference.
- GitHub Actions are pinned to full commit SHAs and updated through reviewed automation.

## AWS and Kubernetes

- Terraform state uses an encrypted, versioned remote S3 backend and DynamoDB lock table with a documented bootstrap path.
- EKS endpoint, logging, encryption, node hardening, and network policy match the Platform architecture.
- Each workload uses a dedicated IRSA role with least privilege and no node-role credential fallback.
- Runtime configuration contains no secret values; secrets are sourced from an approved secret manager or protected workflow environment.
- Liveness, readiness, resource limits, disruption settings, autoscaling policy, and rollback behavior have been exercised in staging.

## Governance and operation

- `main` is protected in every Basalt repository; force pushes and bypasses are prohibited, review and required CI are enforced, and workflow changes have code ownership.
- A protected `production` environment exists with required reviewers, scoped variables, and non-interactive OIDC deployment identity.
- A staging deployment rehearsal has completed successfully from the exact release digest.
- The operator runbook includes deployment, rollback, key rotation, incident triage, artifact retention, and break-glass access procedures.
- No cloud resource is applied from a local workstation or unmanaged credential.
