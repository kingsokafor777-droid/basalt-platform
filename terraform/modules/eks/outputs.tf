output "cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "EKS cluster name for kubeconfig and Helm deployment."
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "Private EKS control-plane endpoint."
}
