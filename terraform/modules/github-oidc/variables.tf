variable "name" {
  type        = string
  description = "Prefix for the narrowly scoped GitHub deployment role."
}

variable "github_subjects" {
  type        = set(string)
  description = "Exact permitted GitHub OIDC subjects, usually one protected environment."

  validation {
    condition     = length(var.github_subjects) > 0
    error_message = "At least one exact GitHub OIDC subject must be allowed."
  }
}

variable "artifact_bucket_arn" {
  type        = string
  description = "Artifact bucket ARN allowed for controlled release reads."
}

variable "tags" {
  type        = map(string)
  description = "Additional resource tags."
  default     = {}
}
