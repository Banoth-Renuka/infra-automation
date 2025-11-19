# Workflow — Terraform + Ansible Automation

## 1️⃣ Terraform Execution
```
terraform init
terraform validate
terraform apply -auto-approve
```

### Terraform Output
- VPC, Subnets, Route Tables, Internet Gateway
- Security Groups
- EC2 instance(s)
- Public IP(s)
- inventory.ini for Ansible

## 2️⃣ Verify EC2 Connectivity
```
ansible -i inventory.ini webservers -m ping
```

## 3️⃣ Run Ansible Playbook
```
ansible-playbook -i inventory.ini apache.yml
```

### Ansible Tasks
- Install Apache
- Start & enable service
- Deploy custom index.html

## 4️⃣ Access via Browser
http://13.127.248.144

## 5️⃣ Destroy Infrastructure (optional)
```
terraform destroy
```
