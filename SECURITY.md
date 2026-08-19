# Security Policy

## Reporting

Report suspected vulnerabilities through a private GitHub Security Advisory. Do not publish credentials, Terraform state, object-store paths containing customer data, cluster endpoints, kubeconfig files, or production findings in public issues.

## Scope

This repository intentionally contains no deploy credentials and does not deploy automatically. A passing static validation result does not authorize a cloud change. The protected-environment configuration, remote state backend, OIDC trust policy, image provenance policy, and runtime network controls are all part of the production security boundary and must be reviewed together.
