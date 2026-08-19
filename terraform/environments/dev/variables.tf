variable "environment" {
  type        = string
  description = "Logical deployment environment."
  default     = "dev"
}

variable "region" {
  type        = string
  description = "AWS region for the platform control plane."
}

variable "vpc_cidr" {
  type        = string
  description = "Dedicated VPC CIDR."
}

variable "availability_zones" {
  type        = list(string)
  description = "At least two selected availability zones."
}

variable "artifact_bucket_name" {
  type        = string
  description = "Globally unique private artifact bucket name."
}

variable "kubernetes_version" {
  type        = string
  description = "Approved EKS Kubernetes version."
}

variable "node_instance_types" {
  type        = list(string)
  description = "Managed EKS node instance types."
}

variable "github_subjects" {
  type        = set(string)
  description = "Exact GitHub OIDC subjects allowed to assume the deploy role."
}
