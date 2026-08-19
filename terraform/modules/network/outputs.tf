output "vpc_id" {
  value       = aws_vpc.this.id
  description = "Dedicated platform VPC ID."
}

output "private_subnet_ids" {
  value       = [for subnet in aws_subnet.private : subnet.id]
  description = "Private subnets for EKS worker nodes and internal services."
}

output "public_subnet_ids" {
  value       = [for subnet in aws_subnet.public : subnet.id]
  description = "Public load-balancer subnets; nodes do not receive public IPs."
}
