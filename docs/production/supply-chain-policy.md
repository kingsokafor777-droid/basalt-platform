# Software Supply-Chain Policy

Basalt’s first production release uses **private GitHub Container Registry packages** and an internal or otherwise access-controlled Python package registry. Public source code does not imply public runtime artifacts. Production images, package releases, SBOMs, provenance statements, scan output, and signing metadata are treated as release records.

## Immutable inputs

GitHub Actions in privileged Platform workflows are referenced by full commit SHA, with the human-readable upstream version retained in a comment. Cross-repository Basalt builds consume reviewed Core and IaC commit pins until immutable registry releases replace source references. A pin change is a compatibility change: it requires a pull request, the complete relevant test suite, security review for a newly introduced third-party action, and an explicit entry in the release evidence.

Image promotion is digest-only. A Helm production values file must use `repository@sha256:...`; a mutable tag is allowed only in local or staging experiments and may not be accepted by the production release workflow. Each promoted image must have a reproducible build, SBOM, vulnerability scan, provenance statement, signature, and retained scan result.

## Dependency response

Critical advisories block release unless an accountable owner records a time-bounded exception, compensating controls, affected runtime path, and target remediation release. High advisories require triage before promotion. Dependabot or an equivalent reviewed update process is mandatory for Actions, Python, and JavaScript dependencies.

## Registry bootstrap boundary

Registry creation, package visibility, repository package permissions, signing identities, and deploy environment access are external administration actions. They are never created implicitly from a pull request or a developer workstation. The production runbook must record the principal, approval, and resulting immutable identifier for each bootstrap action.
