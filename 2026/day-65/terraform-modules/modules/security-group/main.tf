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