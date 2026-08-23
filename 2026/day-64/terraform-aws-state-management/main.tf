# Data Source
# Dynamically finds the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
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

# Data Source
# Fetches available Availability Zones in the selected AWS region
data "aws_availability_zones" "available" {
  state = "available"
}

# Local values
# Reusable values derived from variables
locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# VPC
# Creates an isolated network in AWS
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}


# Public Subnet
# Public subnet inside the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-subnet"
  })
}

# Internet Gateway
# Connects VPC to the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-igw"
  })
}

# Route Table
# Routes traffic from subnet to IGW
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-rt"
  })
}

# Route Table Association
# Links subnet to the route table
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
# Firewall: allow dynamically configured inbound ports
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-${var.environment}-SG"
  description = "Security group with dynamic allowed ports"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg"
  })
}

# Register your public key with AWS
resource "aws_key_pair" "my_key_pair" {
  key_name   = "terra-key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

# Create the EC2 instance and attach the key
# Creates a server inside the public subnet
resource "aws_instance" "ec2" {
  ami = data.aws_ami.amazon_linux.id # Amazon Linux 2 AMI
  #instance_type               = var.instance_type
  instance_type               = var.environment == "prod" ? "t3.small" : "t3.micro"
  key_name                    = aws_key_pair.my_key_pair.key_name
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-server"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# Application Logs Bucket
# Explicitly created after the EC2 instance
resource "aws_s3_bucket" "app_logs" {
  bucket     = "terraweek-app-logs-august-2026"
  depends_on = [aws_instance.ec2]
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-app-logs"
  })
}

# Existing S3 bucket imported into Terraform
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "terraweek-import-test-jaishree-2026"
}

