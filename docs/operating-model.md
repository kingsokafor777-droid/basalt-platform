# Operating Model

## Ownership

| Domain | Accountable owner | Inputs | Output and evidence |
|---|---|---|---|
| Scanner rules and provider behavior | Security engineering | Cloud and Terraform target scope | Native Basalt finding artifacts and SARIF. |
| Artifact admission and Warehouse | Data engineering | Accepted scanner artifacts | Modeled scan, finding, control, and drift records. |
| Dashboard and read API | Application engineering | Authorized Warehouse read model | Health checks, query telemetry, and executive report views. |
| Infrastructure and runtime | Platform engineering | Terraform and Helm changes | Reviewed plan, rendered manifests, environment approvals, and deployment history. |
| Product direction | Product owner | User requirements, risk priorities, roadmap | PRD, roadmap, ADR approvals, and release decisions. |

## Artifact lifecycle

A scanner result is produced in a repository-specific workflow, retained as CI evidence, and admitted to private versioned object storage only by an authorized path. Warehouse verifies the normalized schema and builds its models. A read API exposes the dashboard’s relation-level contract. RAG index maintenance is optional and must retain document digest provenance. Any agent output remains a review bundle, not an admitted production artifact.

## Change management

Terraform changes require a formatted, validated plan and Basalt IaC SARIF result. Helm changes require linting, rendered-manifest review, and a smoke environment. Production actions require a protected environment and confirmation. A deployment rollback is a human action using a prior, known Helm image tag and release history; automatic rollback policies are intentionally not encoded until runtime SLOs and observability are deployed.
