variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string
}

variable "ingress_ports" {
  description = "TCP ports allowed for inbound traffic."
  type        = list(number)
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name used for naming."
  type        = string
}