#!/bin/bash
touch script.sh
if [[ -x "./script.sh" ]]; then 
   ./script.sh 
else
echo "il faudra changer les permissions"
fi



