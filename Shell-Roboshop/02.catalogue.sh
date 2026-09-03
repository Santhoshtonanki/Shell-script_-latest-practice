#!/bin/bash

R="\e[31m"
G="\e[32m"  
Y="\e[33m"
N="\e[0m"

USER_ID="$(id -u)"
LOG_FOLDER="/var/log/roboshop"
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
USER_ADD="roboshop"
DOMAINE_NAME="lylbwof.shop"


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
    if [ $? -ne 0 ]; then
        echo -e "$Y roboshop user already exists, skipping the user creation $N" | tee -a "$LOG_FILE"
    else
        echo -e "$G roboshop user created successfully $N" | tee -a "$LOG_FILE"
    fi
    
    
    mkdir -p /app 
    VALIDATE $? "creating APP directory $(date '+%d-%m-%Y %H:%M:%S')" | tee -a "$LOG_FILE"

    chown -R roboshop:roboshop /app
    VALIDATE $? "changing ownership of /app"
    
    rm -rf /etc/systemd/system/catalogue.service
    VALIDATE $? "removing catalogue.service file from /etc/systemd/system/"

    mkdir -p /etc/systemd/system/
    VALIDATE $? "creating /etc/systemd/system/ directory"

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
    VALIDATE $? "installing npm dependencies"


    systemctl daemon-reload
    VALIDATE $? "reloading the systemctl daemon"
    
    systemctl enable catalogue &>>"$LOG_FILE"
    VALIDATE $? "enabling catalogue"


    systemctl restart catalogue &>>"$LOG_FILE"
    VALIDATE $? "restarting catalogue"


    systemctl is-active --quiet catalogue
    VALIDATE $? "checking the status of catalogue service is active or not"

    rm -rf /etc/yum.repos.d/01.mongodb.repo &>>"$LOG_FILE"
    VALIDATE $? "01.mongodb.repo file removed $G Successfully $N"

    cp /home/ec2-user/Shell-script_-latest-practice/Shell-Roboshop/01.mongodb.repo \
        /etc/yum.repos.d/01.mongodb.repo &>>"$LOG_FILE"
    VALIDATE $? "01.mongodb.repo file copied $G Successfully $N"

    dnf clean all
    VALIDATE $? "cleaning the dnf cache"

    dnf makecache
    VALIDATE $? "making the dnf cache"

    dnf repolist | grep -i mongo
    VALIDATE $? "checking the mongodb repo is available or not"
    
    dnf search mongosh
    VALIDATE $? "checking the mongosh package is available or not"

    dnf install mongodb-mongosh -y &>>"$LOG_FILE"
    VALIDATE $? "installing mongodb-mongosh"

    mongosh --host "mongodb.lylbwof.shop" </app/db/master-data.js
    VALIDATE $? "importing the master-data.js into mongodb"

    mongosh --host "mongodb.lylbwof.shop" <<EOF
    show dbs
    use catalogue
    show collections   
    db.products.find()
    EOF


    