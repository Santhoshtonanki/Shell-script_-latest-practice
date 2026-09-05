#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

STARTTIME=$(date +%s)
USER_ID="$(id -u)"
LOGS_FOLDER="/var/log/shell-Roboshop"
SCRIPT_FILE=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"
DOMAIN_NAME="lylbwof.shop"

mkdir -p "$LOGS_FOLDER"
echo -e "Script execution started at : $Y$(date)$N" | tee -a ""$LOG_FILE""

if [ "$USER_ID" -ne 0 ]; then
    echo -e "$R" "please run script with root privileges" "$N" | tee -a ""$LOG_FILE""
    exit 1
fi

VALIDATE() {
    if [ "$1" -ne 0 ]; then
        echo -e "$Y" "installation process got "$N" "$R" failure for $2" "$N" | tee -a ""$LOG_FILE""
        exit 1
    else
        echo -e "$Y" "Installation process got "$N" "$G" success for $2" "$N" | tee -a ""$LOG_FILE""
    fi
}

dnf install mysql-server -y
VALIDATE $? "mysql-server"


systemctl enable mysqld
VALIDATE $? "enabling mysql-server"


systemctl start mysqld 
VALIDATE $? "starting mysql-server" 

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "mysql_secure_installation"

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "mysql_secure_installation"


netstat -lntp | grep 3306 &>>""$LOG_FILE""
VALIDATE $? "checking if mysql is listening on port 3306"

