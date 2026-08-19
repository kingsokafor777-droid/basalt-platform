# Release Runbook

## Preconditions

The reviewer must confirm that Platform CI and Basalt IaC have passed for the commit, the container image is immutable and has passed its own repository validation, the Warehouse read API endpoint is authorized for the environment, and GitHub `production` Environment protection is active. The deploy role must use exact-subject OIDC trust, not a broad repository wildcard.

## Provisioning

The `Provision Platform Infrastructure` workflow is the only Terraform apply path in this repository. It runs only when an authorized user dispatches it, types `PROVISION`, and is approved in the production environment. It reads its backend configuration and OIDC role from protected environment configuration. Inspect the generated Terraform plan in workflow logs before approval.

## Runtime release

Dispatch `Release Basalt Platform`, type `DEPLOY`, and provide an immutable dashboard image tag or digest. The workflow uses short-lived OIDC credentials, fetches an EKS token, and performs `helm upgrade --install` with `--wait`. It does not build an image, make Terraform changes, or invoke Basalt Agent.

## Rollback

Identify the last known-good immutable image tag from the Helm release history. Dispatch the release workflow with that tag after a human review. Do not use a mutable image tag for rollback. If the incident affects infrastructure or identity, stop runtime changes and follow the organization’s incident response procedure before considering a Terraform rollback.
