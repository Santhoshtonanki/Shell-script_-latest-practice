#!/bin/bash

## In shell scripting every variable is treated as a string by default.

NUMBER1="1050"
NUMBER2="2025"
NAME="Santhosh"
NAME2="Hemanth"

SUM=$((${NUMBER1}+${NUMBER2}))
echo "The Sum is: $SUM"

SUM=$((${NUMBER1}+${NUMBER2}+${NAME}))
echo "The Sum is: $SUM"

SUB=$((NUMBER1-NUMBER2))
echo "the Subtraction is: $SUB"

SUB=$((NUMBER1-NUMBER2-NAME))
echo "the Subtraction is: $SUB"

MUL=$((NUMBER1*NUMBER2*NAME))
echo "the Multiplication is: $MUL"

## Array types
## In Course we have 6 courses, so we can store them in an array.
## size is 6, Maximum index is 5, Minimum index is 0
COURSE=("DevOps" "AWS" "Azure" "GCP" "Docker" "Kubernetes")
echo "The Course is: ${COURSE[0]}"
echo "The Course is: ${COURSE[1]}"

## In Course we have 5 courses, so we can store them in an array.
## size is 5, Maximum index is 4, Minimum index is 0
SUBJECTS=("Maths" "Science" "Social" "English" "Telugu")
echo "The Subjects are: ${SUBJECTS[0]}"
echo "The Subjects are: ${SUBJECTS[1]}"     
echo "The Subjects are: ${SUBJECTS[4]}"
echo "The Subjects are: ${SUBJECTS[@]}"  
### In Course we have 5 courses, so we can store them in an array. 

