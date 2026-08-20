# VPC
# Creates an isolated network in AWS
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "TerraWeek-VPC"
  }
}

# Public Subnet
# Public subnet inside the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
}

# Internet Gateway
# Connects VPC to the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "TerraWeek-igw"
  }
}

# Route Table
# Routes traffic from subnet to IGW
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "TerraWeek-Public-RT"
  }
}

# Route Table Association
# Links subnet to the route table
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
# Controls inbound and outbound traffic for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "TerraWeek-SG"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraWeek-SG"
  }
}

# Register your public key with AWS
resource "aws_key_pair" "my_key_pair" {
  key_name   = "terra-key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

# Create the EC2 instance and attach the key
# Creates a server inside the public subnet
resource "aws_instance" "ec2" {
  ami                         = "ami-0db1c5c6dc64eb019" # Amazon Linux 2 AMI
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.my_key_pair.key_name
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "TerraWeek-Server"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Application Logs Bucket
# Explicitly created after the EC2 instance
resource "aws_s3_bucket" "app_logs" {
  bucket     = "terraweek-app-logs-august-2026"
  depends_on = [aws_instance.ec2]
  tags = {
    Name = "TerraWeek-App-Logs"
  }
}



