#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


USERID="$(id -u)"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_FILE=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"

mkdir -p $LOGS_FOLDER 
echo -e "$G...SCRIPT STARTED....$N Executed at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "$R...PLEASE RUN THIS SCRIPT WITH ROOT PRIVILEGES...$N"
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$R...FAILURE....$N.....:: $2 Installation process got $R....Failure...$N" | tee -a $LOG_FILE
        exit 1
    else 
        echo -e "$G...SUCCESS....$N.....:: $2 Installation process got $G....Success...$N" | tee -a $LOG_FILE
    fi
}

for package in "$@" # we should not use $ before package.
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]; then
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "$package is already installed,$Y...........skipping.....$N the installation process" | tee -a $LOG_FILE
    fi
done
