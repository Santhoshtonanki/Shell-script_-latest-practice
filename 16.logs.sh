#!/bin/bash

USERID="(id -u)"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_FILE=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"

mkdir -p $LOGS_FOLDER
echo "script started executed at: $(date)" | tee -a $LOG_FILE


if [ $USERID -ne 0 ]; then
    echo " Please run this script with root privileges"
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 installation completely .......$R failure $N" | tee -a $LOG_FILE
        exit 1
    else 
        echo -e "$2 installation process completely ........$G successfully $N" | tee -a $LOG_FILE
    fi
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]; then
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "mysql"
else
    echo -e "MYSQL already installed ........$Y skipping $N" | tee -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]; then
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "Nginx"
else 
    echo -e "NGINX already installed .........$Y skipping $N" | tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]; then
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "PYTHON3 already installed .........$Y skipping $N" | tee -a $LOG_FILE
fi