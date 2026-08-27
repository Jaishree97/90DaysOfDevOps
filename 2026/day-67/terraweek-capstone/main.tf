# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

module "vpc" {
  source = "./modules/vpc"

  cidr                = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  environment         = local.environment
  project_name        = var.project_name
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id         = module.vpc.vpc_id
  ingress_ports  = var.ingress_ports
  environment    = local.environment
  project_name   = var.project_name
}

module "ec2" {
  source = "./modules/ec2-instance"

  ami_id              = data.aws_ami.amazon_linux.id
  instance_type       = var.instance_type
  subnet_id           = module.vpc.subnet_id
  security_group_ids  = [module.security_group.sg_id]
  environment         = local.environment
  project_name        = var.project_name
}