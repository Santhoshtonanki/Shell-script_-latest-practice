#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m]"
N="\e[0m"

USER_ID="$(id -u)"
LOGS_FOLDER="/var/log/shell-Roboshop"
SCRIPT_FILE=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"

mkdir -p $LOGS_FOLDER
echo "Script Started executed at : $(date)" | tee -a $LOG_FILE

if [ $USER_ID -ne 0 ]; then
    echo "please run script with root privileges" | tee -a $LOG_FILE
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo " installation process got failure for $2" | tee -a $LOG_FILE
        exit 1
    else
        echo "Installation process got success for $2" | tee -a $LOG_FILE
    fi
}

for package in "$@"
do
    dnf install mongodb-org -y 
    VALIDATE $? "mongodb-org installed $G Successfully $N"


    systemctl enable mongod
    VALIDATE $? "mongodb-org enabled $G Successfully $N"
 
    systemctl start mongod 
    VALIDATE $? "mongodb-org started $G Successfully $N"

    sed -i -e 's/ 127.0.0.1/0.0.0.0/' /etc/mongod.conf

    systemctl restart mongod
    VALIDATE $? "mongodb-org restarted $G Successfully $N"
done
