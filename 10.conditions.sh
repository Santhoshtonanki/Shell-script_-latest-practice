#!/bin/bash

NUMBER="$1"

## -gt = greater than
## -lt = less than
## -eq = equal to
## -ne = not equal to
## -ge = greater than or equal to
## -le = less than or equal to
## -mt = match
## -nm = not match

##if [ $NUMBER -lt 10 ]; then
   ## echo "The Given number is less than 10"
##elif [ $NUMBER -eq 10 ]; then
    #echo "The Given number is equal to 10"
##else 
    ##echo "The Given number is greater than to 10"
##fi

## now try to add number into the print statement, to know what will show in result.

if [ $NUMBER -lt 10 ]; then
    echo "The Given number $NUMBER is less than 10"
elif [ $NUMBER -eq 10 ]; then
    echo "The Given number $NUMBER is equal to 10"
else 
    echo "The Given number $NUMBER is greater than 10"
fi