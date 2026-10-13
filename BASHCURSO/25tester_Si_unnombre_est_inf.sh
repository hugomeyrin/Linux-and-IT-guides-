#!/bin/bash
read -r -p "Votre Age: " AGE
if [[ "$AGE" -lt 18 ]]; then 
echo "Mineur"
fi
