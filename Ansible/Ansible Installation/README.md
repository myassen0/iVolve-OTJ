# 🤖 Lab 4: Ansible Installation and Basic Configuration
--- 

This lab demonstrates how to install and configure **Ansible Automation Platform** on a control node, connect to a managed node, and verify functionality using ad-hoc commands.

---

## 🎯 Lab Objectives

- ✅ Install and configure Ansible on the control node
- ✅ Create an inventory file with a managed node
- ✅ Generate SSH key on control node
- ✅ Transfer the public key to the managed node using `ssh-copy-id`
- ✅ Run ad-hoc command to check disk space and validate Ansible connection

---

## 📋 Requirements

- 🖥️ **Control Node** (Linux server with internet)
- 🖥️ **Managed Node** (accessible via SSH)
- 🌐 SSH connectivity between both machines
- 📦 Package manager: `dnf` or `apt` (depending on the system)
- 🧑 Default user with `sudo` privileges on both nodes

---

## 🧾 Steps
### 🔧 1. Ansible Environment Setup
For Managed Node
```
sudo hostnamectl set-hostname managednode
sudo sed -i 's/^PasswordAuthentication no$/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd.service
```
For Control Node
```
sudo hostnamectl set-hostname controlnode
sudo echo "<ip> managednode1" >> /etc/hosts
sudo echo "<ip> managednode2" >> /etc/hosts
```
Verification connect with controlnode & managednode1 ,managednode2

![image](https://github.com/user-attachments/assets/5577abdc-03d5-47c0-be10-f6668220d1ce)

![image](https://github.com/user-attachments/assets/c1be77a6-c342-471f-8f38-79ead2537003)


### 🔧 2. Install Ansible on the Control Node

For RHEL-based (CentOS/Rocky/Alma):

```bash
sudo dnf install epel-release -y
sudo dnf install ansible -y
```
For Debian-based (Ubuntu):
```bash
sudo apt update
sudo apt install ansible -y
```

### 🗂️ 3. Create an Inventory File
```
[webservers]
<ip managednode1>
<ip managednode2>
```

🔐 4. Generate SSH Key on Control Node
```
ssh-keygen
```
🔁 5. Transfer Public Key to Managed Node
```
ssh-copy-id your_user@your_ip
```
⚙️ 6. Run Ad-hoc Command to Check Disk Space
```
ansible all -i inventory -m shell -a "df -h"
```
![image](https://github.com/user-attachments/assets/bcd46fc4-713a-44dc-84b2-9c1f5560db9c)

# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]











