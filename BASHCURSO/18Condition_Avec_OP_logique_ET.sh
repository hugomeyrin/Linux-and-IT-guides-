#!/bin/bash
## operateur (  -a (ET) -and actuellement pour que ça marche on utilise && ) ( -n  -not empty)  ( -x -execution )  ( -z -empty ) 
#test
A=4
if [[ "$A" -gt 0 && "$A" -lt 10 ]]; then 
  echo "numeros entre 1 et 9"
fi
