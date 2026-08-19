# ADR 0004: Basalt Agent remains local and review-only

## Context

Basalt Agent creates narrowly guarded Terraform remediation proposals and validates them using Basalt IaC in a temporary copy. Turning it into a web-deployed component would introduce privileged source, Git, and possibly cloud access that contradicts its safety contract.

## Decision

The Helm chart never runs Basalt Agent. The platform documents the agent as a local review workflow whose output may be attached to a human-authored pull request. GitHub Actions does not invoke it to write or submit changes.

## Consequences

Remediation remains a human-owned activity. This limits automation but provides an unambiguous security boundary: the platform cannot autonomously alter Terraform, create a branch, or apply infrastructure.
