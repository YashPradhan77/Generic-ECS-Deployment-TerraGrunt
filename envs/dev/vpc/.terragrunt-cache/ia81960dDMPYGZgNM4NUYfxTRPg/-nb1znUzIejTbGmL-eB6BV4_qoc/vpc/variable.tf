# Network variables

variable "namespace" {
  description = "Namespace for resource names"
  default     = "ecs"
  type        = string
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "dev"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  default     = "10.1.0.0/16"
  type        = string
}

# variable "common_tags" {
#   type = map(string)
# }
