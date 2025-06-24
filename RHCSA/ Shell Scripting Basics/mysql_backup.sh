#!/bin/bash

BACKUP_DIR=/home/yassen/mysql_backups
DATE=$(date +%F)
FILENAME="MySQL_backup_$DATE.sql"

MYSQL_USER="root"
MYSQL_PASSWORD=""StrongPass123!
DATABASE_NAME="yassendb"

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_NAME > $BACKUP_DIR/$FILENAME

echo "Backup saved to $BACKUP_DIR/$FILENAME"
