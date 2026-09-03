#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID="$(id -u)"
LOGS_FOLDER="/var/log/shell-Roboshop"
SCRIPT_FILE=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"

mkdir -p $LOGS_FOLDER
echo "Script Started executed at : $Y $(date)" $N | tee -a $LOG_FILE

if [ $USER_ID -ne 0 ]; then
    echo -e $R "please run script with root privileges" $N | tee -a $LOG_FILE
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e $Y "installation process got $N $Rfailure for $2" $N | tee -a $LOG_FILE
        exit 1
    else
        echo -e $Y "Installation process got $N $Gsuccess for $2" $N | tee -a $LOG_FILE
    fi
}

for package in "$@"
do
    rm -rf /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
    VALIDATE $? "mongo.repo file removed $G Successfully $N"

    cp /home/ec2-user/Shell-script_-latest-practice/Shell-Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

    dnf install mongodb-org -y &>>$LOG_FILE
    VALIDATE $? "mongodb-org installed $G Successfully $N"


    systemctl enable mongod &>>$LOG_FILE
    VALIDATE $? "mongodb-org enabled $G Successfully $N"
 
    systemctl start mongod &>>$LOG_FILE     
    VALIDATE $? "mongodb-org started $G Successfully $N"

    sed -i 's/ 127.0.0.1/0.0.0.0/' /etc/mongod.conf

    systemctl restart mongod &>>$LOG_FILE
    VALIDATE $? "mongodb-org restarted $G Successfully $N"

    netstat -lntp &>>$LOG_FILE
    VALIDATE $? "mongodb-org listening on port $G Successfully $N"

    curl http://localhost:8080 &>>$LOG_FILE
    VALIDATE $? "mongodb-org curl $G Successfully $N"
done
