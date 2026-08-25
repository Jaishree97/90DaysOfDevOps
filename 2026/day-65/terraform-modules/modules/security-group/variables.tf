variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "ingress_ports" {
  description = "List of TCP ports allowed for ingress"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "tags" {
  description = "Additional tags for the security group"
  type        = map(string)
  default     = {}
}