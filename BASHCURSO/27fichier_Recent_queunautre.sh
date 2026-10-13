#!/bin/bash
if [[ "file1.txt" -nt "file2.txt" ]]; then #plus récent que 
 echo "file1.txt est plus récent"
fi	
