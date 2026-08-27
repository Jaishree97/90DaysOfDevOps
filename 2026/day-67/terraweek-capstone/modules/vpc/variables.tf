variable "cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
}

variable "environment" {
  description = "Environment name such as dev, staging, or prod."
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}