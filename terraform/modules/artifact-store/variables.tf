variable "name" {
  type        = string
  description = "Globally unique artifact-bucket name."
}

variable "tags" {
  type        = map(string)
  description = "Additional resource tags."
  default     = {}
}
