# ADR 0003: Protected OIDC releases instead of static cloud credentials

## Context

Deployment workflows need short-lived cloud authorization but must not store long-lived AWS keys in a repository or generic action secret. GitHub environments also provide a place for reviewers and branch restrictions before a production action runs.

## Decision

Terraform creates a GitHub OIDC identity provider and a deploy role whose trust policy requires `aud=sts.amazonaws.com` and an exact set of GitHub `sub` values. Provisioning and release workflows are manual, compare explicit confirmation input, target a protected `production` environment, and request only `contents: read` plus `id-token: write`.

## Consequences

The operator must configure the protected environment and role ARN variables before use. This is deliberate; GitHub advises restricting OIDC trust policy subjects so untrusted repositories cannot request cloud access tokens.[1]

## References

[1]: https://docs.github.com/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services "GitHub Actions OIDC on AWS"
