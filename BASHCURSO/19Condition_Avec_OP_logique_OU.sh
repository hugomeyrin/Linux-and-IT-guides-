#!/bin/bash
read -p "tu peux me confirmer avec oui ou O: " $REP
if [[ "$REP" =~ ^[Oo](ui)?$ ]]; then
echo "Confirmé"
fi
