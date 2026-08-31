#!/bin/bash

NUMBER="$1"

if [ $NUMBER even ]; then
    echo "The Given number $NUMBER is even"
else 
    echo "The Given number $NUMBER is odd"
fi