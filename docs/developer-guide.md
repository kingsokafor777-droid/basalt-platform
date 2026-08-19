# Developer Guide

## Prerequisites

Install Terraform 1.8 or later, Helm 3, Python 3.12, `actionlint`, and optionally a container registry client. AWS credentials, `kubectl`, and a cluster are **not** required for static validation.

## Static workflow

Run `make check`. Terraform initialization uses `-backend=false`, so it validates syntax and module wiring without reading remote state or authenticating to AWS. Helm lint and template rendering use only the chart and default values. The Python validator checks internal documentation links, rejects `pull_request_target`, requires explicit workflow permissions, and verifies the Dashboard-to-Warehouse boundary remains declared.

## Configuration

Copy `terraform/environments/dev/terraform.tfvars.example` to an ignored `.auto.tfvars` file only in a secure local environment. Copy `backend.hcl.example` to a private `backend.hcl` and configure an encrypted S3 state bucket plus lock table. Do not commit either file, provider credentials, kubeconfig, generated plans, rendered manifests, or production image credentials.

## Manual release sequence

First, configure a GitHub `production` Environment with reviewers and branch restrictions. Then create the state backend, apply the environment through the confirmation-gated `Provision Platform Infrastructure` workflow, configure the required cluster, bucket, and role variables, and dispatch the `Release Basalt Platform` workflow with an immutable image tag. Review the artifact and workload status through the approved operational tooling before declaring the release complete.
