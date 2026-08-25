output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.ec2.private_ip
}