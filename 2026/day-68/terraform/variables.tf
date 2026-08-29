variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "EC2 key pair used for SSH access"
  type        = string
  default     = "day68-ansible-key"
}

variable "instances" {
  description = "Map of instance names to AMI IDs, SSH users, OS family and instance type"

  type = map(object({
    ami           = string
    user          = string
    os_family     = string
    instance_type = string
  }))

  default = {
    "control-node" = {
      ami           = "ami-01b14b7ad41e17ba4"
      user          = "ec2-user"
      os_family     = "amazon"
      instance_type = "t3.micro"
    }

    "web-server" = {
      ami           = "ami-01b14b7ad41e17ba4"
      user          = "ec2-user"
      os_family     = "amazon"
      instance_type = "t3.micro"
    }

    "app-server" = {
      ami           = "ami-01b14b7ad41e17ba4"
      user          = "ec2-user"
      os_family     = "amazon"
      instance_type = "t3.micro"
    }

    "db-server" = {
      ami           = "ami-01b14b7ad41e17ba4"
      user          = "ec2-user"
      os_family     = "amazon"
      instance_type = "t3.micro"
    }
  }
}

variable "allowed_ports" {
  description = "List of allowed inbound TCP ports"
  type        = list(number)
  default     = [22, 80]
}