#!/bin/bash

##echo please enter a number:
##read NUMBER

##NUMBER="$1"

##if [ $((NUMBER % 2)) -eq 0 ]; then
  ##  echo "The Given number, $NUMBER is EVEN"
##else 
  ##  echo "The Given number, $NUMBER is ODD"
##fi

##we taking the value, The "user entered read NUMBER. 
##But in next line immediately I gave NUMBER="$1", 
##so that unfortunately the value is overwritten. 
##That's why $1 being like empty and result getting wrong.

## here we have to remove the line NUMBER="$1" and then it will work fine.
## Or we  have to remove the line read NUMBER and then it will work fine.


NUMBER="$1"

if [ $((NUMBER % 2)) -eq 0 ]; then
    echo "The Given number, $NUMBER is EVEN"
else 
    echo "The Given number, $NUMBER is ODD"
fi