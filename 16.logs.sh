#!/bin/bash

USERID=$(id -u)
R="\e[031m"
G="\e[032m"
Y="\e[033m"
N="\e[0m"

LOG_FOLDER:"/var/log/Shell-script"
SCRIPTED_NAME: "$( echo $0 -ne 0 | cut -d "." -f1)"
LOG_FILE="$LOG_FOLDER/$SCRIPTED_NAME.log"

mkdir -p $LOG_FOLDER
echo "Script Start Executed at: $(date)" | tee -a $LOG_FILE



if [ $? -ne 0 ]; then
    echo "ERROR:: please run this script with root privileges"
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo "ERROR:: $2 installation is ....... FAILURE" | tee -a $LOG_FILE
    else 
        echo "INFO:: $2 installation is ......... SUCCESS" | tee -a $LOG_FILE
    fi
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "mysql"
else 
    echo "MYSQL is already installed ...........SKIPPING" | Tee -a $LOG_FILE


dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo "NGINX is already installed ......... SKIPPING" | Tee -a $LOG_FILE
fi


dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]; then
    dnf install python3
    VALIDATE $? "python3"
else
    echo "INFO:: PYTHON3 already installed ........SKIPPING" | Tee -a $LOG_FILE
fi



