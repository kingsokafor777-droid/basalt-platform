# Research Index

The platform design uses primary sources for provider, orchestration, and release controls. These sources are not executed by the repository; they inform the documented design decisions.

| Source | Design use |
|---|---|
| [Terraform: provision EKS](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks) | Separates cluster creation from application runtime deployment and documents lifecycle implications. |
| [Terraform: Helm provider](https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider) | Informs the distinct infrastructure and Helm release boundaries. |
| [Amazon EKS security best practices](https://docs.aws.amazon.com/eks/latest/best-practices/security.html) | Informs private endpoints, identity, pod, runtime, and network security controls. |
| [GitHub OIDC on AWS](https://docs.github.com/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) | Informs exact-subject OIDC trust and protected deploy environments. |
| [Basalt Core](https://github.com/kingsokafor777-droid/basalt-core) | Defines normalized finding and control contracts. |
| [Basalt Warehouse](https://github.com/kingsokafor777-droid/basalt-warehouse) | Defines durable ingestion, modeled current findings, and drift semantics. |
| [Basalt Agent](https://github.com/kingsokafor777-droid/basalt-agent) | Defines the local, review-only remediation boundary. |
