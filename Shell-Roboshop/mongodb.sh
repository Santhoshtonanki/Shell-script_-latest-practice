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

mkdir -p "$LOGS_FOLDER"
echo -e "Script Started executed at : $Y$(date)$N" | tee -a ""$LOG_FILE""

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

    rm -rf /etc/yum.repos.d/mongodb.repo &>>""$LOG_FILE""
    VALIDATE $? "mongodb.repo file removed $G Successfully $N"

    cp /home/ec2-user/Shell-script_-latest-practice/Shell-Roboshop/mongo.repo \
        /etc/yum.repos.d/mongo.repo &>>""$LOG_FILE""
    VALIDATE $? "mongodb.repo file copied $G Successfully $N"

    dnf install mongodb-org -y &>>""$LOG_FILE""
    VALIDATE $? "mongodb-org installed $G Successfully $N"


    systemctl enable mongod &>>""$LOG_FILE""
    VALIDATE $? "mongodb-org enabled $G Successfully $N"
 
    systemctl start mongod &>>""$LOG_FILE""     
    VALIDATE $? "mongodb-org started $G Successfully $N"

    sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
    VALIDATE $? "mongodb-org bind address changed $G Successfully $N"

    systemctl daemon-reload &>>""$LOG_FILE""
    VALIDATE $? "mongodb-org daemon reloaded $G Successfully $N"

    systemctl restart mongod &>>""$LOG_FILE""
    VALIDATE $? "mongodb-org restarted $G Successfully $N"


    systemctl is-active --quiet mongod
    VALIDATE $? "MongoDB service is running"

    systemctl status mongod &>>""$LOG_FILE""
    VALIDATE $? "checking the status of mongodb service is active or not"

    ENDTIME=$(date +%s)
    TOTAL_TIME=$(("$ENDTIME"-"$STARTTIME"))
    echo -e "$Y" "Total time taken to execute the script is $TOTAL_TIME seconds" "$N" | tee -a ""$LOG_FILE""
    