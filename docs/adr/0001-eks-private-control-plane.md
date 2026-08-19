# ADR 0001: Private-node and private-control-plane EKS

## Context

The platform dashboard requires a durable runtime, while scanner artifacts and Warehouse records include sensitive resource metadata. A cluster exposed broadly by default expands the management-plane attack surface and complicates network ownership.

## Decision

Terraform provisions an EKS cluster with a private endpoint, managed node group in private subnets, enabled control-plane logs, non-public workload addresses, and per-AZ NAT egress. Public subnets are reserved for controlled load balancer placement. The ingress controller is responsible for the only internet-facing application edge.

## Consequences

Operators require private network access, approved jump-host access, or a controlled CI runner to administer the cluster. This operational cost is accepted in exchange for a smaller default control-plane exposure. AWS identifies identity, pod, runtime, and network security as customer responsibilities for EKS workloads.[1]

## References

[1]: https://docs.aws.amazon.com/eks/latest/best-practices/security.html "Amazon EKS security best practices"
