#!/bin/bash

R="\e[31m"
G="\e[32m"  
Y="\e[33m"
N="\e[0m"

START_TIME=$(date +%s)
echo "execution starting time"
USER_ID="$(id -u)"
LOG_FOLDER="/var/log/roboshop"
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
USER_ADD="roboshop"
DOMAINE_NAME="lylbwof.shop"


mkdir -p "$LOG_FOLDER" | tee -a "$LOG_FILE"
echo "script execution started at $(date '+%d-%m-%Y %H:%M:%S')" | tee -a "$LOG_FILE"
VALIDATE $? "creating "$LOG_FOLDER" directory"

if [ "$USER_ID" -ne 0 ]; then
  echo -e "$R You should run this script as root user or with sudo privileges $N" | tee -a "$LOG_FILE"
  exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 installing ..........$R failure $N" | tee -a "$LOG_FILE"
        exit 1
    else
        echo -e "$2 installing ...........$G success $N" | tee -a "$LOG_FILE"
    fi
}


    dnf module disable nginx -y &>>"$LOG_FILE"
    VALIDATE $? "disabling nginx"

    dnf module enable nginx:1.24 -y &>>"$LOG_FILE"
    VALIDATE $? "enabling nginx 1.24"


    dnf install nginx -y &>>"$LOG_FILE"
    VALIDATE $? "installing nginx"

    systemctl enable nginx 
    VALIDATE $? "enabling nginx"

    systemctl start nginx 
    VALIDATE $? "starting nginx"

    rm -rf /usr/share/nginx/html/* 
    VALIDATE $? "removing existing content from /usr/share/nginx/html"
    
    curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>"$LOG_FILE"
    VALIDATE $? "downloading frontend zip file"

    cd /usr/share/nginx/html 
    VALIDATE $? "changing directory to /usr/share/nginx/html"

    unzip /tmp/frontend.zip &>>"$LOG_FILE"
    VALIDATE $? "unzipping frontend zip file"


    systemctl daemon-reload &>>"$LOG_FILE"
    VALIDATE $? "reloading systemctl daemon"

    systemctl restart nginx &>>"$LOG_FILE"
    VALIDATE $? "restarting nginx"



    END_TIME=$(date +%s)
    TOTAL_TIME=$(($END_TIME - $START_TIME))
    echo "total executed time for installing $TOTAL_TIME seconds" | tee -a "$LOG_FILE"
