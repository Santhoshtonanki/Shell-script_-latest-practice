#!/bin/bash

R="\e[031m"
G="\e[032m"
Y="\e[033m"
N="\e[0m"

USER_ID="$9(id -u)"
LOGS_FOLDER="/var/log/shell-Roboshop"
SCRIPT_FILE=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"
DOMAIN_NAME="lylbwof.shop"
USER_ADD="roboshop"




mkdir -p $LOG_Folder &>>$LOG_FILE
echo "script started executed $date)" | tee -a $LOG_FILE




if [ $USER_ID -ne 0 ]; then
    echo -e "$R PLease run the script with root privileges $N" | tee -a $LOG_FILE
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 installing ......$R failure $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 installing .......$G success $N" | tee -a $LOG_FILE
}






dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "disabling nodejs"

dnf module enable nodejs:20 -y&>>$LOG_FILE
VALIDATE $? "enabling nodejs 20"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "installing nodejs"





useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop 
if [ $? -ne 0]; then
    echo -e "user already created so i am $Y .....skipping.....$N creating roboshop user" | tee -a $LOG_FILE
    exit 1
else
    echo -e " creating roboshop user $G.......successfully....$N" | tee -a $LOG_FILE
fi




rm -rf /app/* &>>LOG_FILE
VALIDATE $? "deleting the app directory"

mkdir -p /app &>>$LOG_FILE
VALIDATE $? " creating app directory"

chown -R roboshop:roboshop /app &>>$LOG_FILE
VALIDATE $? "giving permission to roboshop user of /app"


rm -rf /tmp/catalogue.zip
VALIDATE $? "deleting catalogue.zip file"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
VALIDATE $? "downloading catalogue.zip file"

cd /app 
VALIDATE $? "changing directory to app"

unzip /tmp/catalogue.zip &>>$LOG_FILE
VALIDATE $? "unzipping the catalogue.zip file"




rm -rf /etc/systemd/system/*
VALIDATE $? "deleting all system files"

mkdir -p /etc/systemd/system/catalogue.service
VALIDATE $? "creating /etc/systemd/system directory"

cp /home/ec2-user/Shell-script_-latest-practice/Shell-Roboshop/catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "coping catalogue.service file into /etc/systemd/system/catalogue.service"

rm -rf /etc/yum.repos.d/01.mongodb.repo
VALIDATE $? "removing 01.mongodb.repo file"


cp /home/ec2-user/Shell-script_-latest-practice/Shell-Roboshop/01.mongodb.repo  /etc/yum.repos.d/01.mongodb.repo
VALIDATE $? "coping the mongodb.repo file into /etc/yum.repos.d/"

dnf clean all &>>$LOG_FILE
VALIDATE $? "clean all"

dnf makecache
VALIDATE $? "making cache"

dnf repolist | grep -i mongo &>>$LOG_FILE
VALIDATE$? "getting repos list"

dnf search mongosh &>>$LOG_FILEd
VALIDATE $? "searching mongosh is available or not"





npm install &>>$LOG_FILE
VALIDATE $? "installing npm dependencies"


systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "refreshing after making some changes from catalogue.service file"

systemctl enable catalogue  &>>$LOG_FILE
VALIDATE $? "enabling the catalogue services"

systemctl restart catalogue &>>$LOG_FILE
VALIDATE $? "starting teh catalogue services"



dnf install mongodb-mongosh -y &>>$LOG_FILE
Validate $? "installing mongodb-mongosh" 

mongosh --host mongodb.$DOMAINE_NAME </app/db/master-data.js &>>$LOG_FILE
VALIDATE $? " trying to  connect mongodb server"


mongosh --host mongodb.$DOMAINE_NAME &>>$LOG_FILE
show dbs
use catalogue
show collections
db.products.find()






