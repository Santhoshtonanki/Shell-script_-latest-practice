#!/bin/bash
echo please enter a number:
read NUMBER

if [ $(($NUMBER % 1)) -eq 0 ] && [ $(($NUMBER % $NUMBER)) -eq 0 ]; then
    echo "The Given number is only divided with 1 and $NUMBER and equal to 0 so this is a Prime Number"
else 
    echo "The Given number is not only divided with 1 and $NUMBER and equal to 0 So this is not a Prime Number"
fi