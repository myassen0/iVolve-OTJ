# 🌐 Lab 5: Ansible Playbooks for Web Server Configuration

---

This lab demonstrates how to write and run an Ansible Playbook to configure a web server automatically on a managed node.

---

## 🎯 Lab Objectives

- ✅ Write an Ansible playbook to install and configure a web server (e.g., Apache).
- ✅ Apply the playbook to a managed node using Ansible.
- ✅ Verify that the web server is running and accessible.

---

## 📋 Requirements

- 🖥️ Control Node with Ansible installed
- 🖥️ Managed Node accessible via SSH (key-based)
- 🧩 Internet access on managed node to install packages
- 📄 Ansible inventory file with managed node listed
- 🔐 SSH access already configured between control and managed nodes

---

## 🧾 Step-by-Step Instructions

### 1. ✅ Create Inventory File
```
[webservers]
<ip managednode1>
<ip managednode2>
```
### 2. ✅ Write the Ansible Playbook `webserver.yml`
```
---
- name: Configure Apache Web Server
  hosts: webservers
  become: true
  tasks:
    - name: Install Apache
      ansible.builtin.yum:
        name: httpd
        state: present

    - name: Ensure Apache is running and enabled
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: true

    - name: Create custom index.html
      ansible.builtin.copy:
        content: "<h1>Welcome to Ansible Web Server!</h1>"
        dest: /var/www/html/index.html
```

### 3. ✅ Run the Playbook
```
ansible-playbook -i inventory webserver.yml
```


### 4. ✅ Verify the Web Server















