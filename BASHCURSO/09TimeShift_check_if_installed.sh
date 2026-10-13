#!/bin/bash
if which timeshift >/dev/null 2>&1; then #wich keepassxc  va montrer /usr/bin/keepassxc 
    echo "le logiciel est installé"	
    echo "timeshift --version"
exit 2

#if flatpak --system --app --columns=application 2>/dev/null | grep -Fxq "org.keepassxc.KeePassXC"; then
#echo "KeePassXC est installé via Flatpak."
#exit 0 
else 
    echo "le logiciel n'est pas installé!"
    exit 1
fi  
#if snap list keepassxc >/dev/null 2>&1; then
#   echo "KeePassXC est installé via Snap."
#   else 
#   echo "KeePassXC n'est pas installé via Snap"
#fi
