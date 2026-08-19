variable "name" {
  type        = string
  description = "EKS cluster name."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnets for managed nodes and private control-plane endpoint access."
}

variable "kubernetes_version" {
  type        = string
  description = "EKS Kubernetes version approved for the platform."
}

variable "node_instance_types" {
  type        = list(string)
  description = "Managed node-group instance types."
}

variable "tags" {
  type        = map(string)
  description = "Additional resource tags."
  default     = {}
}
