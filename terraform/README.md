# Terraform — AWS Infrastructure

This folder contains Terraform code to automate AWS infrastructure provisioning.

## Features
- VPC, Subnets, Route Tables, Internet Gateway
- Security Groups
- EC2 instances
- Key Pair
- Dynamic Ansible inventory

## Commands
```
terraform init
terraform validate
terraform apply -auto-approve
terraform destroy
```

## Outputs
- EC2 Public IP
- inventory.ini for Ansible
