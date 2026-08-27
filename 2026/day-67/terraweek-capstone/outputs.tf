output "workspace" {
  description = "Current Terraform workspace."
  value       = terraform.workspace
}

output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "Public subnet ID."
  value       = module.vpc.subnet_id
}

output "security_group_id" {
  description = "Security group ID."
  value       = module.security_group.sg_id
}

output "instance_id" {
  description = "EC2 instance ID."
  value       = module.ec2.instance_id
}

output "public_ip" {
  description = "EC2 public IP."
  value       = module.ec2.public_ip
}