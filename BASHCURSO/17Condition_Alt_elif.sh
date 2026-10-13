#!/bin/bash
NOTE=12
if [[ "$NOTE" -ge 16 ]]; then
    echo "BRAVO!"
elif [[ "$NOTE" -ge 10 ]]; then 
    echo "pas assez"
fi
