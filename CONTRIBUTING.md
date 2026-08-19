# Contributing

Platform changes must preserve the separation between infrastructure provisioning, runtime delivery, artifact ingestion, and local remediation. Do not add static credentials, `pull_request_target`, push-triggered apply/deploy steps, broad OIDC trust subjects, public artifact buckets, or an autonomous agent service.

Terraform module changes require `terraform fmt`, `terraform validate`, and Basalt IaC validation. Helm changes require `helm lint` and a rendered-manifest review. Documentation changes must preserve internal link integrity. Run `make check` before proposing a change and add an ADR for a decision that changes a security boundary, ownership boundary, or irreversible operating model.
