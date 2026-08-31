#!/bin/bash

if [ $NUMBER % 1 -eq 0 ] && [ $NUMBER % $NUMBER -eq 0 ]; then
    echo "The Given number, $NUMBER is only divided with 1 and $NUMBER and equal to 0 so this is Prime Number"
else 
    echo "The Given number, $NUMBER is echo "The Given number, $NUMBER is not only divided with 1 and $NUMBER and equal to 0 so this is not Prime Number"not a Prime Number"
fi