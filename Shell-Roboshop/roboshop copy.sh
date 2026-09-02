#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SECURITY_GROUP="sg-0fc6e3e381d06a2a8"
HOSTED_ZONE_ID="Z068858712AH0PK53FI2K"
DOMAIN_NAME="lylbwof.shop"  

for instance in "$@"
do 
    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type t3.micro \
    --security-group-ids "$SECURITY_GROUP" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query "Instances[0].InstanceId" \
    --output text)

    if [ $instance != "frontend" ]; then
        ip=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query "Reservations[*].Instances[*].PrivateIpAddress" \
    --output text)
        echo "the current instance is not frontend, so I providing a private ip address for this instance $ip"
        echo "record name is $instance.lylbwof.shop"
        RECORD_NAME="$instance.lylbwof.shop"
    else
        ip=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text)
        echo "the current instance is frontend, so I providing a public ip address for this instance $ip"
        echo "record name is $instance.lylbwof.shop"
        RECORD_NAME="$instance.lylbwof.shop"
    fi
done
