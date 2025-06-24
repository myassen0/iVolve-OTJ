# Lab 1: Shell Scripting Basics – MySQL Backup Automation
---
## 📋 Objective

#### This lab focuses on automating MySQL database backups using shell scripting and cron jobs. By the end of this lab, you'll have a script that regularly backs up a MySQL database and stores the backups in a dedicated directory.
---
## 🛠️ Tasks Overview

1. **Install MySQL server** on your Linux machine.
2. **Create a directory** to store backup files.
3. **Write a shell script** to:
   - Use `mysqldump` to create a backup of your MySQL database.
   - Save the backup with a timestamped filename like:  
     `MySQL_backup_YYYY-MM-DD.sql`
4. **Automate the script** using `cron` to run **daily at 5:00 PM**.

---

## 🧱 Requirements

- Linux environment (e.g., Ubuntu, CentOS)
- MySQL Server installed
- Basic shell scripting knowledge
- Root or sudo privileges

---

## 📦 Steps

### 1. Install MySQL
#### For Ubuntu/Debian:
```bash
sudo apt update
sudo apt install mysql-server -y
```
#### For CentOS/RHEL:
```bash
sudo yum install mysql-server -y
sudo systemctl start mysql
```
![image](https://github.com/user-attachments/assets/ba7d772d-02ef-437c-86ab-1f47fa9059a2)

### 2. create Database:
```bash
mysql -u root -p
CREATE DATABASE <nameDB>;
SHOW DATABASES;
```
![image](https://github.com/user-attachments/assets/6662ef37-39a2-41b3-853f-ee8b092c3e00)

### 3. Create a Backup Directory:
```bash
mkdir -p ~/mysql_backups
```
### 4. Shell Script :
```
#!/bin/bash

# Variables
BACKUP_DIR="$HOME/mysql_backups"
DATE=$(date +%F)
FILENAME="MySQL_backup_${DATE}.sql"

# Command
mysqldump -u root -pYourPassword --all-databases > "$BACKUP_DIR/$FILENAME"

# Optional: Print confirmation
echo "Backup saved to $BACKUP_DIR/$FILENAME"
```
⚠️ Important: Replace YourPassword with your actual MySQL root password or consider using a .my.cnf file for more secure credentials handling.

![image](https://github.com/user-attachments/assets/44cead82-0708-4803-83fa-4e38bf36c583)

#### Make the script executable:
```
chmod +x mysql_backup.sh
```

### 5. ⏰ Set Up Cron Job:
####Edit your crontab:
```bash
crontab -e
```
#### Add the following line to schedule the backup at 5:00 PM daily:
`0 17 * * * /path/to/mysql_backup.sh`

![image](https://github.com/user-attachments/assets/7de9a613-c242-469f-9675-5776945b10ac)

### 6. ✅ Output:
```bash
bash ~/mysql_backup.sh
```
![image](https://github.com/user-attachments/assets/a5b92f5f-1d2c-4248-947a-373c9a6d6bc2)









