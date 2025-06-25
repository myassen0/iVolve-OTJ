# Lab 7: Ansible Vault – Automate MySQL Setup with Secure Credentials

## 🎯 Objective

Automate the following tasks using Ansible and Ansible Vault:

1. Install MySQL on a managed node.
2. Create a database named `iVolve`.
3. Create a MySQL user with all privileges on the `iVolve` database.
4. Use **Ansible Vault** to encrypt sensitive information like the database password.
5. Validate the setup by connecting to MySQL using the created user and listing databases.

---

## 📁 Project Structure

```
Vault
├── inventory # Ansible inventory file
├── vault_playpook.yml # Main Ansible playbook
├── vault_vars.yml # Encrypted vault file (contains DB credentials)
```

---

## 🔐 Step 1: Create and Encrypt Vault Variables

Use `ansible-vault` to securely store the database credentials.

```bash
ansible-vault create vault_vars.yml
```
Example content inside (will be encrypted):
```
db_user: <db_user>
db_password: <db_password>
```
#### 🔒 You will be prompted to enter a vault password. Save it securely.
---
## 📜 Step 2: Create Playbook
```
---
- name: Lab 7 - Install MySQL and Setup iVolve DB
  hosts: all
  become: yes
  vars_files:
    - vault_vars.yml

  tasks:
    - name: Install MySQL server
      dnf:
        name: mysql-server
        state: present

    - name: Start and enable MySQL service
      systemd:
        name: mysqld
        state: started
        enabled: yes

    - name: Ensure MySQL Python module is installed
      dnf:
        name: python3-PyMySQL
        state: present

    - name: Create my database
      community.mysql.mysql_db:
        name: iVolve
        state: present
        login_user: root
        login_password: ""

    - name: Create MySQL user with privileges
      community.mysql.mysql_user:
        name: "{{ db_user }}"
        password: "{{ db_password }}"
        priv: "iVolve.*:ALL"
        host: "%"
        state: present
        login_user: root
        login_password: ""

    - name: Validate DB by listing databases using the created user
      shell: |
        mysql -u{{ db_user }} -p{{ db_password }} -e "SHOW DATABASES;"
      register: db_output
      changed_when: false

    - name: Show DB list
      debug:
        msg: "{{ db_output.stdout_lines }}"

```
## 📦 Step 3: Create Inventory File
```
[webservers]
<ip manegednode1>
<ip manegednode2>
```
## 🚀 Step 4: Run the Playbook
```
ansible-playbook -i inventory mysql_setup.yml --ask-vault-pass
```
`--ask-vault-pass`: Prompts you to enter the vault password to decrypt sensitive variables.

![image](https://github.com/user-attachments/assets/b2f753b4-0dd4-411a-a566-e62876bc36da)

## 🧪 Step 4: Validation
1- Connect to MySQL using the created user `mysql -u <user> -p `
2- Run `SHOW DATABASES;` to ensure the `iVolve` DB exists.

![image](https://github.com/user-attachments/assets/3cdfa990-e145-43d0-9c96-220b1c44ee8b)

---
# 📌 Notes
- The playbook assumes default root access to MySQL with no password. If your system uses a password or socket authentication, adjust accordingly.
- For repeated execution, the playbook is idempotent (won't recreate users or DB if they already exist).
- You can edit vault variables securely using:
```
ansible-vault edit vault_vars.yml
```
---
# 👨‍💻 Author  
Mahmoud Yassen  
🎓 DevOps Trainee at iVolve

🔗 [(www.linkedin.com/in/myassenn01)]


