#!/bin/bash
if [[ -n $1 ]]; then #if the variable is set $1 we gonna use it 
    name=$1
else
   read -p 'Enter your name' name   # if the variable $1 is not set we gonna read it from the user 
echo "Welcome MR $name"
fi
