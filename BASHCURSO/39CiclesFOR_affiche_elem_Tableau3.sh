#!/bin/bash
TAB=("AVENUE" "SAINTE" "CECILE" "15 ")
for elem in $TAB; do            # PARA cada elemento na $TAB ()
  echo "Addresse : "${TAB[@]}"" ## erreur ici avant Address é igual ao valor $ de todos os elementos @ dentro do tableu TAB
done
