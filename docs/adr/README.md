# Architecture Decision Records

| ADR | Decision | Status |
|---|---|---|
| [0001](./0001-eks-private-control-plane.md) | Use private-node, private-control-plane EKS as the managed runtime foundation. | Accepted |
| [0002](./0002-artifact-first-integration.md) | Integrate scanners, Warehouse, and RAG through versioned artifacts and a narrow read API boundary. | Accepted |
| [0003](./0003-protected-oidc-releases.md) | Use exact-subject GitHub OIDC and protected manual releases rather than static deployment credentials or push-to-prod. | Accepted |
| [0004](./0004-agent-is-not-a-service.md) | Keep Basalt Agent local and review-only; do not deploy autonomous remediation authority. | Accepted |
