output "cluster_name" {
  value       = module.eks.cluster_name
  description = "Cluster name for the manual Helm release workflow."
}

output "artifact_bucket_name" {
  value       = module.artifacts.bucket_name
  description = "Private scanner and index artifact bucket."
}

output "github_deploy_role_arn" {
  value       = module.github_oidc.deploy_role_arn
  description = "Role ARN stored as the protected deploy environment secret."
}
