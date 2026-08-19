# Platform Architecture

## Deployment planes

The platform intentionally separates four planes. The **infrastructure plane** establishes the VPC, private-node EKS cluster, encrypted artifact bucket, and trust boundary for GitHub OIDC. The **runtime plane** applies the Helm chart for the dashboard and optionally schedules the Warehouse and RAG maintenance jobs. The **artifact plane** carries scanner outputs into Warehouse ingestion and index material without granting browser workloads scanner credentials. The **governance plane** records requirements, decisions, validation evidence, and the human release sequence.

| Plane | Primary implementation | Trust boundary | Does not do |
|---|---|---|---|
| Infrastructure | Terraform modules | AWS account and protected state backend | Run business workloads or apply automatically. |
| Runtime | Helm chart | Kubernetes namespace, service account, NetworkPolicy | Create cloud resources or retrieve long-lived cloud credentials. |
| Artifact | Private S3 bucket with KMS, versioning, TLS deny policy | Artifact writers/readers are separately authorized | Expose observations publicly or overwrite versions. |
| Governance | GitHub Actions and docs | Protected environment plus exact OIDC subject | Bypass human confirmation or approve a production release. |

## Component contract

The deployed dashboard receives an authenticated `WAREHOUSE_READ_API_URL` only. The Warehouse adapter exposes minimized, tenant-authorized relation views corresponding to scan runs, finding observations, controls, and drift events. The dashboard never connects directly to DuckDB files, object storage, a cloud scanner, or an unvalidated ingestion endpoint.

Warehouse maintenance consumes only accepted scanner artifacts and emits a versioned read model. RAG index maintenance may run after Warehouse refreshes and writes a versioned index artifact. Basalt Agent remains outside the cluster: its contract deliberately stops at a local, reviewed patch bundle and must not become a privileged web service.

## Security controls

The EKS control-plane endpoint is private and control-plane audit logs are enabled. The chart runs workload containers as non-root, drops Linux capabilities, enables RuntimeDefault seccomp, uses read-only root filesystems, has explicit resource requests and limits, and enables a default-deny policy for dashboard ingress and egress. Platform deployment identity is federated from GitHub OIDC and scoped by exact subjects rather than static AWS keys.[1] [2]

The Terraform state backend is external to the environment module; operators must supply an encrypted S3 backend and lock table using `backend.hcl`. State must never be committed. Infrastructure and application delivery are separate workflows and may have separate owners, which prevents a chart change from implicitly mutating network or IAM resources.[3]

## References

[1]: https://docs.aws.amazon.com/eks/latest/best-practices/security.html "Amazon EKS security best practices"
[2]: https://docs.github.com/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services "GitHub Actions OIDC on AWS"
[3]: https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider "Terraform Helm provider deployment guidance"
