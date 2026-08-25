# Security Group Terraform Module

A reusable Terraform module that creates an AWS Security Group with dynamic TCP ingress rules based on a list of ports and a permissive egress rule for outbound traffic.

The module allows the same Security Group configuration to be reused across different environments and workloads without duplicating the `aws_security_group` resource.

---

## Module Structure

```text
modules/security-group/
├── main.tf        # Security group resource definition
├── variables.tf   # Input variable declarations
├── outputs.tf     # Output value declarations
└── README.md      # Module documentation
```

## Resources Created

| Resource Type | Description |
|---|---|
| `aws_security_group.sg` | Creates a security group with dynamic TCP ingress rules |

---

## How the Module Works

The module follows an input → resource → output pattern:

```text
Root Module
     |
     | Inputs
     |---------------------------->
     |
     | vpc_id
     | sg_name
     | ingress_ports
     | tags
     |
     v
Security Group Module
     |
     v
aws_security_group.sg
     |
     | Outputs
     |---------------------------->
     |
     | sg_id
     |
     v
Root Module
```
---

## Usage

Call this module from the root `main.tf`:

```hcl
module "web_sg" {
  source = "./modules/security-group"

  vpc_id        = module.vpc.vpc_id
  sg_name       = "terraform-day65-web-sg"
  ingress_ports = [22, 80, 443]

  tags = {
    Project     = "Terraform-Day65"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```
---

## Variables (`variables.tf`)

| Name | Type | Default | Required | Description |
|---|---|---|---|---|
| `vpc_id` | `string` | — | Yes | VPC ID where the Security Group will be created |
| `sg_name` | `string` | — | Yes | Name of the Security Group |
| `ingress_ports` | `list(number)` | `[22, 80, 443]` | No | List of TCP ports allowed for ingress |
| `tags` | `map(string)` | `{}` | No | Additional tags to apply to the Security Group |

---

## Outputs (`outputs.tf`)

| Name | Description |
|---|---|
| `sg_id` | ID of the created Security Group |

Reference the output from the root module:

```hcl
module.web_sg.sg_id
```

For example, pass the Security Group ID to the EC2 module:

```hcl
module "web_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraform-day65-web"
}
```
---

## How It Works `(main.tf)`

The module creates an AWS Security Group:

```hcl
resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = "Security group managed by Terraform"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports

    content {
      description = "Allow TCP ${ingress.value}"
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

  tags = merge(var.tags, {
      Name = var.sg_name
    })
}
```

## Key Points

| Feature | Detail |
|---|---|
| **Dynamic ingress** | Each port in `ingress_ports` becomes its own TCP inbound rule — no hardcoded rules |
| **CIDR** | All ingress rules allow traffic from `0.0.0.0/0` (open to the internet) |
| **Egress** | All outbound traffic is allowed (`protocol = "-1"`) |
| **Tagging** | `Name` tag is always set from `sg_name`; additional tags are merged in |


