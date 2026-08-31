#!/bin/bash

R="\e[0;31m"
G="\e[0;32m"
Y="\e[0;33m"
BL="\e[0;34m"
MG="\e[0;35m"
CY="\e[0;36m"
WT="\e[0;37m"
N="\e[0m"


USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script as root user or with sudo privileges"
    exit 1
fi

Validate() {
    if [ $1 -ne 0 ] ; then
        echo -e "ERROR:: $2 installation process got $R failed $N"
        exit 1
    else
        echo -e "INFO:: $2 installation process is completed $G successfully $N"
    fi
}

dnf list installed mysql
## if mysql is not installed, then install it, otherwise skip the installation.
if [ $? -ne 0 ]; then
    dnf install "mysql" -y
    Validate "$?" "mysql"
else 
    echo -e "INFO:: MYSQL is already installed,........$Y Skipping $N the installation process"
fi

dnf list installed nginx
## if nginx is not installed, then install it, otherwise skip the installation.
if [ $? -ne 0 ]; then
    dnf install "nginx" -y
    Validate "$?" "nginx"
else 
    echo -e "INFO:: NGINX is already installed,........ $Y Skipping $N the installation process"
fi

dnf list installed docker
## if docker is not installed, then install it, otherwise skip the installation.
if [ $? -ne 0 ]; then
    dnf install "docker" -y
    Validate "$?" "docker"
else 
    echo -e "INFO:: DOCKER is already installed,........ $Y Skipping $N the installation process"
fi


dnf list installed java
## if docker is not installed, then install it, otherwise skip the installation.
if [ $? -ne 0 ]; then
    dnf install "java" -y
    Validate "$?" "java"
else 
    echo -e "INFO:: JAVA is already installed,........ $Y Skipping $N the installation process"
fi



