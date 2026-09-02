#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SECURITY_GROUP="sg-0fc6e3e381d06a2a8"
HOSTED_ZONE_ID="Z068858712AH0PK53FI2K"
DOMAIN_NAME="lylbwof.shop"

for instance in $@
do 
    aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type t3.micro \
    --security-group-ids "$SECURITY_GROUP" \
    --subnet-id subnet-xxxxxxxxxxxxxxxxx \
    --query "Instances[0].InstanceId" \
    --output text

done