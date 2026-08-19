# Product Requirements Document: Basalt Platform

## Problem

The Basalt portfolio provides normalized cloud, IaC, Kubernetes, analytics, retrieval, and remediation capabilities. Without a shared platform boundary, each component can be demonstrated independently but not operated coherently. The platform must turn these parts into a secure, reviewable delivery system while preserving the safety properties of the scanners and remediation agent.

## Users and outcomes

| User | Outcome | Non-negotiable requirement |
|---|---|---|
| Security engineer | Reliable dashboard of current posture and drift. | Scanner evidence retains source provenance. |
| Platform engineer | Reproducible environment and runtime release. | No static cloud credentials in repositories or workflows. |
| Engineering lead | Traceable product scope, decision history, and delivery sequence. | Documentation follows implementation and has an owner. |
| Reviewer | Clear infrastructure and remediation change evidence. | Production action remains protected and explicit. |

## Functional requirements

The platform shall provide Terraform modules for network, EKS, artifact storage, and GitHub OIDC; a Helm chart for the dashboard and optional maintenance jobs; static CI validation; an IaC scanner workflow producing SARIF; and manual provision/release workflows guarded by confirmation input and a protected production environment. It shall document the Warehouse read API boundary, artifact lifecycle, component ownership, operational checks, product roadmap, and technical decisions.

## Safety requirements

The platform shall not contain cloud credentials, execute `terraform apply` on push, deploy on push, expose a public EKS API endpoint, create public scanner artifact storage, or deploy Basalt Agent as an autonomous remediation service. The state backend shall be operator-provided and excluded from version control. Runtime images must be supplied as immutable tags or digests through the protected release workflow.

## Success measures

Success is demonstrated by reproducible static validation, rendered chart manifests, a passing Basalt IaC SARIF workflow, externally configured OIDC instead of long-lived deploy secrets, and a documentation trail linking product requirement, architecture, ADR, release procedure, and operational ownership.
