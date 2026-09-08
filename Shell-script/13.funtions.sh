#!/bin/bash

USERID=$(id -u)
if [ $USERID -eq 0 ]; then
    echo "You are a root user, you can run this script"
else
    echo "You are not a root user, please run this script as root user or with sudo privileges."
    exit 1
fi

# functions receive inputs through args just like shell script args
VALIDATE(){ 
    if [ $1 -ne 0 ]; then
        echo "ERROR:: $2 installation got failed"
        exit 1
    else
        echo "INFO:: $2 installation is completed successfully"
    fi
}

dnf install "mysql" -y
VALIDATE "$? MYSQL"

dnf install "nginx" -y
VALIDATE "$? NGINX"

dnf install "docker" -y
VALIDATE "$? DOCKER"
