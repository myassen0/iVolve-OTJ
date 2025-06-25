# Lab 8: Ansible Dynamic Inventories (AWS EC2)

## 🎯 Objective

- Provision an AWS EC2 instance with tag `Name=ivolve`.
- Configure Ansible Dynamic Inventory using AWS EC2 plugin.
- Automatically discover and manage EC2 instances based on tag.
- List target hosts using `ansible-inventory` command.

---

## 🛠️ Prerequisites

- AWS account with access keys.
- EC2 instance running with:
  - Tag: `Name=ivolve`
  - Key pair for SSH access
  - Security group allowing SSH (port 22)
- Ansible installed on control node.
- `amazon.aws` collection installed:

```bash
ansible-galaxy collection install amazon.aws
```
---
## 🖥️ Step-by-Step Instructions

### 🔐 Step 1: Configure AWS CLI Credentials
- Run the following command to set your AWS credentials and default region:
```
aws configure
```
- You will be prompted to enter:
```
AWS Access Key ID [None]: <your-access-key-id>
AWS Secret Access Key [None]: <your-secret-access-key>
Default region name [None]: us-east-1
Default output format [None]: json
```

### 2. 🖥️ Launch EC2 Instance with Tag
- Use AWS Console or CLI to launch an EC2 instance with the tag
- Ensure SSH access is allowed (port 22), and save your `.pem` key.

### 3. 🗂️ Configure `ansible.cfg`
```
[inventory]
enable_plugins = host_list, script, auto, yaml, ini, toml
```

### 4. 🗂️ Configure Dynamic Inventory File
- Create a file named `aws_ec2.yml`:
```
plugin: amazon.aws.aws_ec2
filters:
  tag:Name: ivolve
```

### 5. 🔍 Test Dynamic Inventory
- List all hosts (with details):
```
ansible-inventory -i aws_ec2.yml --list
```
![image](https://github.com/user-attachments/assets/d6617898-7aec-4cf8-8001-985645f533d4)

- List all hosts (graph format):
```
ansible-inventory -i aws_ec2.yml --graph
```
![image](https://github.com/user-attachments/assets/7486ca48-f97c-4a09-8fc5-1d729f2c8b92)

### 6. ✅ Ping Target Host (Example)
```
ansible all -i aws_ec2.yml -u ec2-user --private-key /path/to/ivolve.pem -m ping
```
![image](https://github.com/user-attachments/assets/f84f9024-a0fe-4c54-b627-dea5dd7f8c2d)

---
## 📌 Notes

- Default username:
  - `ec2-user` (Amazon Linux)
  - `ubuntu` (Ubuntu AMI)
- Make sure your key pair (`.pem`) is placed on the control node and has proper permissions (`chmod 400`).

--- 

## 🎉 Lab Complete!
- You’ve successfully used Ansible Dynamic Inventory with AWS EC2.

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]
