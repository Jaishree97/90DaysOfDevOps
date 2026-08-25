# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-*"]
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

# Data source to get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Locals for common values and tags
locals {
  common_tags = {
    Project     = "Terraform-Day65"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# ============================================================
# Task 5 - Terraform Registry VPC Module
# ============================================================

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "terraform-day65-vpc"
  cidr = var.vpc_cidr

  azs            = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway   = false
  enable_dns_hostnames = true

  tags = local.common_tags
}

# -------------------------
# Security Group Module
# -------------------------

module "web_sg" {
  source = "./modules/security-group"

  vpc_id        = module.vpc.vpc_id
  sg_name       = "terraform-day65-web-sg"
  ingress_ports = [22, 80, 443]
  tags          = local.common_tags
}

# -------------------------
# Web Server Module
# -------------------------

module "web_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraform-day65-web"
  tags               = local.common_tags
}

# -------------------------
# API Server Module
# -------------------------

module "api_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraform-day65-api"
  tags               = local.common_tags
}











# # ============================================================
# # Task 4 - Hand-written VPC resources
# # Replaced by Terraform Registry VPC module in Task 5
# # ============================================================

# # VPC
# # Creates an isolated network in AWS
# resource "aws_vpc" "vpc" {
#   cidr_block           = var.vpc_cidr
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = merge(local.common_tags, {
#     Name = "terraform-day65-vpc"
#   })
# }

# # Public Subnet
# # Public subnet inside the VPC
# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.public_subnet_cidr
#   availability_zone       = data.aws_availability_zones.available.names[0]
#   map_public_ip_on_launch = true

#   tags = merge(local.common_tags, {
#     Name = "terraform-day65-public-subnet"
#   })
# }

# # Internet Gateway
# # Connects VPC to the internet
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc.id

#   tags = merge(local.common_tags, {
#     Name = "terraform-day65-igw"
#   })
# }

# # Route Table
# # Routes traffic from subnet to IGW
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = merge(local.common_tags, {
#     Name = "terraform-day65-public-rt"
#   })
# }

# # Route Table Association
# # Links subnet to the route table
# resource "aws_route_table_association" "public_rt_assoc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }