#!/bin/bash
read -r -p "Introduisez le nom du logiciel a chercher: " LOGICIEL 
if [[ -z "$LOGICIEL" ]]; then 
  echo "Aucun logiciel indiqué"
exit 2
fi 
if which -eq $LOGICIEL >/dev/null 2>&1; then 
    echo "$LOGICIEL installé par le gestionnaire de paquets"
else 
   echo "$LOGICIEL non installé par le gestionnaire de paquets"
exit 2 
fi
if ! command -v snap >/dev/null 2>&1; then
#echo "le gestionnaire snap n'est pas installé"
exit 2 
fi
if snap list "$LOGICIEL" >/dev/null 2>&1; then 
  echo "$LOGICIEL est installé via Snap"
  echo "le chemin est:" which $LOGICIEL
else 
#  echo "$LOGICIEL n'est pas installé via snap"
fi

