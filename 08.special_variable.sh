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
    

