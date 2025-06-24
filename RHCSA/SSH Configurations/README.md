# 🔐 Lab 3: SSH Configuration and Secure Access

This lab demonstrates how to securely connect to a remote Linux server using SSH key-based authentication and simplify access using SSH config aliases.

---
## 🎯 Lab Objectives
- ✅ Generate public & private SSH keys on your local machine.
- ✅ Securely transfer the public key to a remote machine using `ssh-copy-id`.
- ✅ Configure SSH to allow access to the remote machine with a simple command: `ssh ivolve`.
---
## 📋 Requirements
- 🖥️ Local Linux machine with `ssh` and `ssh-keygen`
- 🌐 Remote server with SSH access and a valid IP
- 📡 Network connectivity between the two systems
---
## 🧾 Steps Overview
### 1. Generate SSH Key Pair
`ssh-keygen`

![1](https://github.com/user-attachments/assets/4dd91d78-c7c7-4940-98f6-8b8071092d92)

### 2. Copy Public Key to Remote Server
`ssh-copy-id user@remote_ip`

![2](https://github.com/user-attachments/assets/db2d8d8f-244f-4491-89ed-3f2927f883b5)

### 3. Connect to Remote Server
`ssh user@remote_ip`

![3](https://github.com/user-attachments/assets/494d6e8a-0632-40dd-81c0-95de35348292)

### 4. Configure SSH for Easy Access (Alias)
#### Edit SSH config file:
`nano ~/.ssh/config`
#### Add:
![4](https://github.com/user-attachments/assets/a418ffad-b0ac-4c45-84b5-00304a8e1703)

### 5. Connect Using the Alias
`ssh ivolve`

![5](https://github.com/user-attachments/assets/7968d4b3-f2b3-4f54-87b8-01d1516a6b32)

---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee ay iVolve
🔗 [(www.linkedin.com/in/myassenn01)]



