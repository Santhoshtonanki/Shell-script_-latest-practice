#!/bin/bash

R="\e[31m"
G="\e[32m"  
Y="\e[33m"
N="\e[0m"

STARTTIME=$(date +%s)

USER_ID="$(id -u)"
LOG_FOLDER="/var/log/roboshop"
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
USER_ADD="roboshop"
DOMAINE_NAME="lylbwof.shop"


mkdir -p "$LOG_FOLDER" | tee -a ""$LOG_FILE""
echo "script execution started at $(date '+%d-%m-%Y %H:%M:%S')" | tee -a ""$LOG_FILE""

if [ "$USER_ID" -ne 0 ]; then
  echo -e "$R You should run this script as root user or with sudo privileges $N" | tee -a ""$LOG_FILE""
  exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 installing ..........$R failure $N" | tee -a ""$LOG_FILE""
        exit 1
    else
        echo -e "$2 installing ...........$G success $N" | tee -a ""$LOG_FILE""
    fi
}

    dnf module disable nodejs -y &>>""$LOG_FILE""
    VALIDATE $? "disabling nodejs"

    dnf module enable nodejs:20 -y &>>""$LOG_FILE""
    VALIDATE $? "enabling nodejs 20"

    dnf install nodejs -y &>>""$LOG_FILE""
    VALIDATE $? "installing nodejs"


    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    if [ $? -ne 0 ]; then
        echo -e "roboshop user already exists,$Y.....skipping.....$N the user creation" | tee -a ""$LOG_FILE""
    else
        echo -e "$G roboshop user created successfully $N" | tee -a ""$LOG_FILE""
    fi

    mkdir -p /app
    VALIDATE $? "creating APP directory $(date '+%d-%m-%Y %H:%M:%S')" | tee -a ""$LOG_FILE""

    chown -R roboshop:roboshop /app
    VALIDATE $? "changing ownership of /app"

    curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
    VALIDATE $? "downloading user zip file"

    cd /app
    VALIDATE $? "changing directory to /app"

    unzip /tmp/user.zip &>>""$LOG_FILE""
    VALIDATE $? "unzipping user zip file"


    cp /home/centos/Shell-script/Shell-script_-latest-practice/Shell-Roboshop/systemd/user.service /etc/systemd/system/user.service
    VALIDATE $? "copying user.service file"

    npm install $>>""$LOG_FILE""
    VALIDATE $? "installing nodejs dependencies"

    

    systemctl daemon-reload &>>""$LOG_FILE""
    VALIDATE $? "reloading systemctl daemon"

    systemctl enable user &>>""$LOG_FILE""
    VALIDATE $? "enabling user"

    systemctl restart nginx &>>""$LOG_FILE""
    VALIDATE $? "restarting nginx"
