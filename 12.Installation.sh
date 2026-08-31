#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Please run this script as root user or with sudo privileges."
    exit 1
fi

dnf install "mysql" -y
if [ $? -ne 0 ]; then
    echo " ERROR:: MYSQL installation got failed"
    exit 1
else
    echo " INFO:: MYSQL installation is completed successfully"
fi

dnf install "nginx" -y
if [ $? -ne 0 ]; then
    echo " ERROR:: NGINX installation got failed"
    exit 1
else
    echo " INFO:: NGINX installation is completed successfully"
fi


dnf install "python3" -y
if [ $? -ne 0 ]; then
    echo "ERROR:: PYTHON3 installation got failed"
    exit 1
else 
    echo " PYTHON3 installation is completed successfully"
fi
