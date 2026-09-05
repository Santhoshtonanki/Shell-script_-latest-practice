#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


STARTTIME=$(date +%s)
echo -e "Script execution started at : $Y$(date)$N" | tee -a ""$LOG_FILE""

USER_ID="$(id -u)"
LOGS_FOLDER="/var/log/shell-Roboshop"
SCRIPT_FILE=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"
DOMAIN_NAME="lylbwof.shop"

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


mkdir -p "$LOGS_FOLDER"
echo -e "Logs folder created at : $Y $LOGS_FOLDER $N" | tee -a ""$LOG_FILE""

dnf module disable redis -y &>>""$LOG_FILE""
VALIDATE $? "disabling redis"

dnf module enable redis:7 -y &>>""$LOG_FILE""   
VALIDATE $? "enabling redis 7"

dnf install redis -y &>>""$LOG_FILE""
VALIDATE $? "installing redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf
VALIDATE $? "configuring redis"

systemctl enable redis &>>""$LOG_FILE""
VALIDATE $? "enabling redis"

systemctl restart redis &>>""$LOG_FILE""
VALIDATE $? "starting redis"


netstat -lntp | grep 6379 &>>""$LOG_FILE""
VALIDATE $? "checking if redis is listening on port 6379"



ENDTIME=$(date +%s)
TOTAL_TIME=$((ENDTIME-STARTTIME))
echo -e "$Y" "Total time taken to execute the script is $TOTAL_TIME seconds" "$N" | tee -a ""$LOG_FILE""