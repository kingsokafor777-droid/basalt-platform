variable "name" {
  type        = string
  description = "Platform identifier used as a resource-name prefix."
}

variable "vpc_cidr" {
  type        = string
  description = "IPv4 CIDR assigned to the dedicated platform VPC."
}

variable "availability_zones" {
  type        = list(string)
  description = "At least two availability zones for private workload subnets."

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "Provide at least two availability zones."
  }
}

variable "tags" {
  type        = map(string)
  description = "Additional resource tags."
  default     = {}
}
