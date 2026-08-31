#!/bin/bash

NUMBER="$1"

if [ $NUMBER -lt 10 ]; then
    echo "The Given number is less than 10"
elif [ $NUMBER -eq 10 ]; then
    echo "The Given number is equal to 10"
else 
    echo "The Given number is greater than to 10"
fi