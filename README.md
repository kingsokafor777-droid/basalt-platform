# Basalt Platform

**Basalt Platform** is the deployment and product-governance repository for the Basalt security posture portfolio. It separates durable cloud infrastructure, Kubernetes application delivery, scanner artifact flow, and human-controlled release decisions. The repository includes Terraform for AWS foundations, a Helm chart for runtime workloads, GitHub Actions controls, and the documentation hub that connects product intent to technical decisions.

> This repository contains **deployment definitions and manual, protected release workflows**. Nothing in this repository provisions, deploys, applies Terraform, or changes cloud state until a human explicitly dispatches a workflow, enters the confirmation phrase, and clears the configured GitHub Environment protection.

## Platform topology

```text
Basalt scanners ──> signed CI artifacts ──> private encrypted artifact bucket
                                             │
                                     Warehouse ingestion / dbt maintenance jobs
                                             │
                                    authenticated Warehouse read API boundary
                                             │
Internet ─> ingress ─> Basalt Dashboard on private-node EKS
                                             │
                                      RAG index maintenance job (optional)

Basalt Agent remains a local, review-only remediation workflow and is never deployed as an autonomous cluster service.
```

## Repository map

| Path | Responsibility |
|---|---|
| [`terraform/`](./terraform/) | Separated VPC, EKS, encrypted scanner artifact store, and constrained GitHub OIDC role modules. |
| [`charts/basalt/`](./charts/basalt/) | Hardened dashboard release and optional Warehouse/RAG CronJobs. |
| [`.github/workflows/`](./.github/workflows/) | Static validation, Basalt IaC scanning, and confirmation-gated provisioning/release workflows. |
| [`docs/`](./docs/) | Architecture, PRD, roadmap, ADRs, research, operating model, and release runbook. |
| [`scripts/validate_repo.py`](./scripts/validate_repo.py) | Offline internal-link and workflow guardrail validation. |

## Operating boundary

The dashboard is a read-only consumer of Warehouse semantics. Scanners and the Agent are not exposed as application endpoints: scanners produce signed artifacts through CI, the Warehouse turns accepted artifacts into query models, and the Agent produces only reviewable local remediation artifacts. This prevents a browser session from obtaining cloud credentials, raw scanner access, or unreviewed source mutation authority.

## Local validation

Install Terraform, Helm, Python 3.12, and `actionlint`, then run:

```bash
make check
```

The validation path has no AWS credentials and no backend access. It formats and validates Terraform with `-backend=false`, lints and renders Helm, checks documentation links and workflow guardrails, and checks Actions syntax. See the [developer guide](./docs/developer-guide.md) for tool installation and the [release runbook](./docs/release-runbook.md) for protected-environment configuration.

## Product documentation

The [product requirements document](./docs/product/PRD.md) defines the platform’s user, safety, and release requirements. The [roadmap](./docs/product/roadmap.md) identifies the delivery sequence. The [ADR index](./docs/adr/README.md) records irreversible technical choices, while the [research index](./docs/research/README.md) links primary infrastructure and security sources.

## License

Apache License 2.0. See [`LICENSE`](./LICENSE).
