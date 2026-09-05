#!/bin/bash

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

dnf module disable redis -y
VALIDATE $? "disabling redis"

dnf module enable redis:7 -y
VALIDATE $? "enabling redis 7"

dnf install redis -y 
VALIDATE $? "installing redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf
VALIDATE $? "configuring redis"

systemctl enable redis 
VALIDATE $? "enabling redis"

systemctl start redis 
VALIDATE $? "starting redis"

curl -s http://localhost:6379 | grep PONG
VALIDATE $? "checking redis service is running or not"

netstat -plntu | grep 6379
VALIDATE $? "checking if redis is listening on port 6379"



ENDTIME=$(date +%s)
TOTAL_TIME=$((ENDTIME-STARTTIME))
echo -e "$Y" "Total time taken to execute the script is $TOTAL_TIME seconds" "$N" | tee -a ""$LOG_FILE""