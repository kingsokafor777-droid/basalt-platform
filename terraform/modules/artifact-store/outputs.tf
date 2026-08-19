output "bucket_name" {
  value       = aws_s3_bucket.artifacts.bucket
  description = "Artifact bucket name for immutable scanner and index material."
}

output "bucket_arn" {
  value       = aws_s3_bucket.artifacts.arn
  description = "Artifact bucket ARN."
}

output "kms_key_arn" {
  value       = aws_kms_key.artifacts.arn
  description = "KMS key ARN protecting artifact contents."
}
