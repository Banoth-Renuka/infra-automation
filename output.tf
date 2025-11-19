# outputs.tf

# VPC ID
output "vpc_id" {
  description = "ID of the custom VPC"
  value       = aws_vpc.mycustom_vpc.id
}

# Public Subnet IDs
output "public_subnets" {
  description = "IDs of public subnets"
  value       = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
}

# Private Subnet IDs
output "private_subnets" {
  description = "IDs of private subnets"
  value       = [aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id]
}

# EC2 Instance Public IP
output "instance_public_ip" {
  description = "Public IP of the web EC2 instance"
  value       = aws_instance.web_instance.public_ip
}
