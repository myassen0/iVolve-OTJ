# 🛠️ Lab 6: Ansible Roles for Application Deployment

---

This lab demonstrates how to use **Ansible roles** to automate the installation of common DevOps tools: **Docker**, **kubectl** (Kubernetes CLI), and **Jenkins** on a managed node.

---

## 🎯 Lab Objectives

- ✅ Create separate Ansible roles to:
  - Install **Docker**
  - Install **Kubernetes CLI** (`kubectl`)
  - Install **Jenkins**

- ✅ Write an Ansible Playbook that calls these roles.
- ✅ Apply the Playbook to a managed node.
- ✅ Verify the tools are successfully installed.

---

## 📋 Requirements

- 🖥️ Ansible Control Node
- 🖥️ One or more Managed Nodes (Linux-based)
- ✅ SSH key-based access between control and managed nodes
- 📡 Internet access on managed nodes to install packages
- 📦 `ansible-galaxy` to generate role structure

---

## 🗂️ Project Structure
```
├── README.md
├── inventory
├── playbook.yml
└── roles/
├── docker/
│ └── tasks/main.yml
├── kubectl/
│ └── tasks/main.yml
└── jenkins/
    ├── tasks/
    │   └── main.yml
    └── handlers/
        └── main.yml
```
---

## 🧾 Step-by-Step Instructions

### ✅ 1. Create Roles

Generate each role using:

```bash
ansible-galaxy init roles/docker
ansible-galaxy init roles/kubectl
ansible-galaxy init roles/jenkins
```
### ✅ 2. Define Role Tasks
### `roles/docker/tasks/main.yml`
```
- name: Install required dependencies
  ansible.builtin.yum:
    name:
      - yum-utils
      - device-mapper-persistent-data
      - lvm2
    state: present

- name: Add Docker repository
  ansible.builtin.get_url:
    url: https://download.docker.com/linux/centos/docker-ce.repo
    dest: /etc/yum.repos.d/docker-ce.repo

- name: Install Docker CE
  ansible.builtin.yum:
    name:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    state: present

- name: Start and enable Docker
  ansible.builtin.service:
    name: docker
    state: started
    enabled: true
```
### `roles/kubectl/tasks/main.yml`

```
- name: Install kubectl
  ansible.builtin.get_url:
    url: https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl
    dest: /usr/local/bin/kubectl
    mode: '0755'

```

### `roles/jenkins/tasks/main.yml`
```
---
- name: Ensure Java 17 is installed
  package:
    name: java-17-openjdk
    state: present

- name: Set Java 17 as default
  shell: |
    alternatives --install /usr/bin/java java /usr/lib/jvm/java-17-openjdk*/bin/java 2
    alternatives --set java /usr/lib/jvm/java-17-openjdk*/bin/java
  args:
    executable: /bin/bash

- name: Add Jenkins repository
  get_url:
    url: https://pkg.jenkins.io/redhat-stable/jenkins.repo
    dest: /etc/yum.repos.d/jenkins.repo

- name: Import Jenkins GPG key
  rpm_key:
    key: https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    state: present

- name: Install Jenkins
  package:
    name: jenkins
    state: present

- name: Create systemd override directory
  file:
    path: /etc/systemd/system/jenkins.service.d
    state: directory
    mode: 0755

- name: Override Jenkins ExecStart to use jenkins.war with Java 17
  copy:
    dest: /etc/systemd/system/jenkins.service.d/override.conf
    content: |
      [Service]
      ExecStart=
      ExecStart=/usr/bin/java -jar /usr/share/java/jenkins.war
  notify:
    - Reload systemd
    - Restart Jenkins

- name: Enable and start Jenkins
  systemd:
    name: jenkins
    enabled: true
    state: started

- name: Wait for Jenkins to generate admin password
  wait_for:
    path: /var/lib/jenkins/secrets/initialAdminPassword
    timeout: 120

- name: Show Jenkins initial admin password
  command: cat /var/lib/jenkins/secrets/initialAdminPassword
  register: jenkins_password
  changed_when: false

- name: Print Jenkins admin password
  debug:
    msg: "🔐 Jenkins Initial Admin Password: {{ jenkins_password.stdout }}"
```
### `roles/jenkins/handlers/main.yml`
```
---
- name: Reload systemd
  command: systemctl daemon-reexec

- name: Restart Jenkins
  systemd:
    name: jenkins
    state: restarted

```

## ✅ 3. Create Playbook `site.yml`
```
---
- name: Deploy DevOps Tools
  hosts: all
  become: true
  roles:
    - docker
    - kubectl
    - jenkins
```
## ✅ 4. Create Inventory File
```
[webservers]
<ip manegednode1>
<ip manegednode2>
```
## ✅ 5. Run the Playbook
```
ansible-playbook -i inventory playbook.yml
```
![image](https://github.com/user-attachments/assets/9afb9bf3-7c0c-46c1-ad17-ad6ece2cfb85)

# ✅ Verification Commands
On the managed node:
```
docker --version
kubectl version --client
systemctl status jenkins
```
![image](https://github.com/user-attachments/assets/e3cc9d54-69e2-464f-ad29-d270b29f656f)


