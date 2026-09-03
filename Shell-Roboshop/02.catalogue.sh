#!/bin/bash

R="\e[31m"
G="\e[32m"  
Y="\e[33m"
N="\e[0m"

USER_ID="$(id -u)"
LOG_FOLDER="/var/log/roboshop"
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOG_FOLDER" | tee -a "$LOG_FILE"
echo "script execution started at $(date '+%d-%m-%Y %H:%M:%S')" | tee -a "$LOG_FILE"

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

    dnf module disable nodejs -y &>>"$LOG_FILE"
    VALIDATE $? "disabling nodejs"

    dnf module enable nodejs:20 -y &>>"$LOG_FILE"
    VALIDATE $? "enabling nodejs 20"

    dnf install nodejs -y &>>"$LOG_FILE"
    VALIDATE $? "installing nodejs"

    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    
    mkdir -p /app 
    VALIDATE $? "creating APP directory $(date '+%d-%m-%Y %H:%M:%S')" | tee -a "$LOG_FILE"
    
    rm -rf /etc/systemd/system/catalogue.service
    VALIDATE $? "removing catalogue.service file from /etc/systemd/system/"
    
    cp /home/ec2-user/Shell-script_-latest-practice/Shell-Roboshop/catalogue.service /etc/systemd/system/catalogue.service
    VALIDATE $? "copying catalogue.service file into /etc/systemd/system/"

    rm -rf /tmp/catalogue.zip   
    VALIDATE $? "deleting catalogue.zip file"

    curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>"$LOG_FILE"
    VALIDATE $? "downloaded Catalogue.zip"



    cd /app 
    VALIDATE $? "changing the directory into APP"

    rm -rf  /app/*
    VALIDATE $? "removing the all files from APP folder"

    unzip /tmp/catalogue.zip &>>"$LOG_FILE"
    VALIDATE $? "unzipping the catalogue.zip file"


    npm install &>>"$LOG_FILE"
    VALIDATE $? "installing node package management npm"


    systemctl daemon-reload
    
    systemctl enable catalogue &>>"$LOG_FILE"
    VALIDATE $? "enabling catalogue"


    systemctl start catalogue &>>"$LOG_FILE"
    VALIDATE $? "starting catalogue"
    
    dnf install mongodb-mongosh -y &>>"$LOG_FILE"
    VALIDATE $? "installing mongodb-mongosh"


    #mongosh --host MONGODB-SERVER-IPADDRESS </app/db/master-data.js
    #mongosh --host MONGODB-SERVER-IPADDRESS
    #show dbs
    #use catalogue
    #show collections
    #db.products.find()