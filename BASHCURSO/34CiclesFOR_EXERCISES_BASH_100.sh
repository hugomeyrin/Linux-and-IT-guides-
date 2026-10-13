#!/bin/bash
for fichier in $fichier # trouvé la faille dans la solution par moi même au lieu de '$(ls)' c'est seulement $(ls)
  ls
; do
  echo "Fichier trouvé : $fichier"
done
