#!/bin/bash

B="\033[0;30m"
MG="\033[0;35m"
CY="\033[0;36m"
WT="\033[0;37m"

B_B="\033[1;30m"
B_R="\033[1;31m"
B_G="\033[1;32m"
B_Y="\033[1;33m"
B_BL="\033[1;34m"
B_MG="\033[1;35m"
B_CY="\033[1;36m"
B_WT="\033[1;37m"

##R="\e[0;31m"
##G="\e[0;32m"
##Y="\e[0;33m"
##BL="\e[0;34m"
##MG="\e[0;35m"
##CY="\e[0;36m"
##WT="\e[0;37m"
##N="\e[0m"

## if we use \e instead of \033,
## echo -e "/e[32mHello World!/e[0m" 
## echo please check the color.
##will not work, but echo -e "/033[32mHello World!/033[0m" will work fine.]"

N="\033[0m"

echo -e "${B_G}Hello world${N}${B_B}!${N}" 
echo Please check the color 