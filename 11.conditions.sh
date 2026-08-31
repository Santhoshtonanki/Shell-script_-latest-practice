#!/bin/bash

echo please enter a number:
read NUMBER

NUMBER="$1"

if [ $((NUMBER % 2)) -eq 0 ]; then
    echo "The Given number, $NUMBER is EVEN"
else 
    echo "The Given number, $NUMBER is ODD"
fi