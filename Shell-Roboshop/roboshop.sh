#!bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SECURITY_GROUP_ID="sg-055c71bb814fafb35"
HOSTED_ZONE_ID="Z068858712AH0PK53FI2K"
DOMAIN_NAME="lylbwof.shop"

for instance in "$@"
do
    aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SECURITY_GROUP_ID "Tags=[{key=NAME,value=$instance}]" --query "Instances[0].InstanceId" --output text
