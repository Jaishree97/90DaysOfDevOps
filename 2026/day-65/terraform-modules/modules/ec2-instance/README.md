# EC2 Instance Module

A reusable Terraform module that provisions an AWS EC2 instance with configurable AMI, instance type, subnet, security groups, instance name, and tags.

The module is designed to be reusable across multiple environments or server roles without duplicating the EC2 resource configuration.

---

## Module Structure

```text
modules/ec2-instance/
├── main.tf        # EC2 instance resource definition
├── variables.tf   # Input variable declarations
├── outputs.tf     # Output value declarations
└── README.md      # Module documentation
```
---

## Resources Created

| Resource Type | Description |
|---|---|
| `aws_instance.ec2` | Creates a single EC2 instance with a public IP |

---

## How the Module Works

The module follows a simple input → resource → output pattern:

```text
Root Module
     |
     | Inputs
     |----------------------------->
     |
     | ami_id
     | instance_type
     | subnet_id
     | security_group_ids
     | instance_name
     | tags
     |
     v
EC2 Instance Module
     |
     v
aws_instance.ec2
     |
     | Outputs
     |----------------------------->
     |
     | instance_id
     | public_ip
     | private_ip
     |
     v
Root Module
```
---

## Usage

Call this module from the root `main.tf`:

```hcl
module "web_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraform-day65-web"

  tags = {
    Project     = "Terraform-Day65"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```
The same module can be reused for another EC2 instance:

```hcl
module "api_server" {
  source = "./modules/ec2-instance"

  ami_id             = data.aws_ami.amazon_linux_2.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraform-day65-api"

  tags = {
    Project     = "Terraform-Day65"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```
This allows the same module to provision multiple EC2 instances without duplicating the underlying `aws_instance` resource.

---

## Variables `(variables.tf)`

| Name | Type | Default | Required | Description |
|---|---|---|---|---|
| `ami_id` | `string` | — | Yes | AMI ID for the EC2 instance |
| `instance_type` | `string` | `"t3.micro"` | No | EC2 instance type |
| `subnet_id` | `string` | — | Yes | Subnet ID where the instance will be placed |
| `security_group_ids` | `list(string)` | — | Yes | List of security group IDs to attach |
| `instance_name` | `string` | — | Yes | Name tag for the EC2 instance |
| `tags` | `map(string)` | `{}` | No | Additional tags to apply to the instance |

---

## Outputs `(outputs.tf)`

| Name | Description |
|---|---|
| `instance_id` | ID of the created EC2 instance |
| `public_ip` | Public IP address of the EC2 instance |
| `private_ip` | Private IP address of the EC2 instance |

Reference outputs from the root module:

```hcl
module.web_server.instance_id
module.web_server.public_ip
module.web_server.private_ip
```
For example:

```hcl
output "web_server_public_ip" {
  value = module.web_server.public_ip
}
```
---

## How It Works `(main.tf)`

The module creates a single aws_instance resource.

It:

- Uses the provided `ami_id` and `instance_type`.
- Places the instance in the provided `subnet_id`.
- Associates a public IP address with the instance.
- Attaches the provided `security_group_ids`.
- Applies the `Name` tag using `instance_name`.
- Merges additional custom tags using `merge()`.

```hcl
resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
}
```


