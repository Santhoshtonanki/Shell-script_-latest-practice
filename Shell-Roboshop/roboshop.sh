#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SECURITY_GROUP="sg-0fc6e3e381d06a2a8"
HOSTED_ZONE_ID="Z068858712AH0PK53FI2K"
DOMAIN_NAME="lylbwof.shop"

for instances in "$@"
do
    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type t3.micro \
    --security-group-ids "$SECURITY_GROUP" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instances}]" \
    --query "Instances[0].InstanceId" \
    --output text)

    if [ $instance != "frontend" ]; then
        ip=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
        echo "the current instance is not frontend, so providing private ip address for this instance $ip"
        RECORD_NAME="$instances.lylbwof.shop"
        echo "record name is $instances.lylbwof.shop"
    
    else
        ip=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
        echo "the current instance is frontend, so providing public ip address for this instance $ip"
        echo "record name is $instances.lylbwof.shop"
        RECORD_NAME="$instances.lylbwof.shop"
    fi

done

