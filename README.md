# Infrastructure Automation Project — Terraform + Ansible

This project demonstrates **end-to-end AWS infrastructure provisioning and configuration** using Terraform and Ansible.

---

## 🚀 Project Workflow

1. **Terraform** provisions:
   - VPC, Subnets, Route Tables, Internet Gateway
   - Security Groups (SSH 22 & HTTP 80)
   - EC2 instances with Key Pair
   - Generates `inventory.ini` for Ansible

2. **Ansible** connects to EC2 using SSH key:
   - Installs Apache (httpd)
   - Starts & enables the service
   - Deploys custom `index.html`

3. **Browser Access**
   - Open: `http://13.127.248.144

---

## 📂 Project Structure

infra-automation/
├── terraform/
├── ansible/
└── project-documentation/

---

## 🛠 Technologies
- Terraform
- Ansible
- AWS VPC, EC2, Subnets, IGW
- Apache HTTPD
- Linux / SSH
