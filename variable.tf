# variables.tf

# AWS Region
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

# EC2 Instance Type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# EC2 Key Pair Name
variable "key_name" {
  description = "Name of the EC2 Key Pair"
  type        = string
}

# Public Key Path
variable "public_key_path" {
  description = "Path of the SSH public key"
  type        = string
}

# AMI ID
variable "ami_id" {
  description = "Amazon Machine Image ID"
  type        = string
  default     = "ami-0d176f79571d18a8" # Amazon Linux 2 (ap-south-1)
}

# Security Group Name
variable "security_group_name" {
  description = "Name of the EC2 security group"
  type        = string
  default     = "webserver_sg"
}
