#!/bin/bash

echo "All variables passed to the script are stored in a special variable called $@"
echo "All variables passed to the script are stored in a special variable called $."
echo "All variables passed to the script are stored in a special variable called $*"
echo "All variables passed to the script are stored in a special variable called $?"
echo "All variables passed to the script are stored in a special variable called $!"
echo "All variables passed to the script are stored in a special variable called $-"
echo "All variables passed to the script are stored name in a special variable called $0"
echo "All variables passed to the script are stored in a special variable called $1"
echo "All variables passed to the script are stored in a special variable called $2"
echo "current working directory: $PWD"
echo "current user: $USER"
echo "current home directory: $HOME"
echo "current shell: $SHELL"
echo "current process id: $$"
echo "current script name: $0"
echo "current script arguments: $@"
sleep 20 &
echo "get the process id of the last background command: $!"


## untill here Variable are over

##Note:- In every script 5 things are very important
    ##1.Variables
    ##2.Data types
    ##3.Conditions
    ##4.Functions
    ##5.Loops
    ##6.Error handling

    #From next file will start with Data Types.
    ## Data type:- 
        ##Name:- "Table"
        ##Integer:- 12
        ##Decimal:- 12.1
        ##Complex_Number:- 2+5i
        ##String:- "Hello World"
        ##Log:- log34
        ##boolean:- true/false
        ##character:- a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
        ##float:- 12.34
        ##long:- 12345678901234567890
        ##double:- 12.345678901234567890
        ##int:- i=0, j=1, k=2, l=3, m=4, n=5, o=6, p=7, q=8, r=9, s=10
        ##there are no explicit data types in bash/shell scripting, 
            ##all variables are treated as strings by default. 
            ##However, you can perform arithmetic operations on variables that contain numeric values.
            



