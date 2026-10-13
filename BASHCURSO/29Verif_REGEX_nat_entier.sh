#!/bin/bash
#L'expression ^[0-9]+$ signifie :
#
#    ^ : Début de la chaîne.
#    [0-9]+ : Un ou plusieurs chiffres.
#    $ : Fin de la chaîne.
#
#Cela garantit que la variable ne contient que des chiffres du début à la fin.
VAR="1234"
if [[ "$VAR" =~ ^[0-9]+$ ]]; then
  echo "C'est un entier"
fi #test avec neovim
