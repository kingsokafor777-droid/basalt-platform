output "deploy_role_arn" {
  value       = aws_iam_role.deploy.arn
  description = "Role ARN configured as a protected GitHub Environment secret for manual deployment."
}
