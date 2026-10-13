#!/bin/bash
#read -r -p "Do you what to backup your CachyOS packages ? " option
#if [ "$option" == "yes" ]; then
#else
# read -r -p "packages not saved, try again:" option
#fi
while true; do
  echo
  echo "===== Main Menu ====="
  echo "1) Backup cachyos packages"
  echo "2) Restore cachyos packages"
  echo "3) Update packages"
  echo "4) Quit"
  read -rp "Choose an option: " choice
  case $choice in
  1)
    sudo pacman -Qq >backup-paquets_cachyos.txt
    echo "Package Backup Done" 2>&1
    ;;
  2)

    sudo pacman -S --needed - <backup-paquets_cachyos.txt
    sudo pacman -Syu
    echo "Restore done" 2>&1
    ;;
  3)
    sudo pacman -Syu
    echo "Update done!!!" 2>&1
    ;;
  4)
    exit
    ;;
  *)
    echo "Invalid option"
    ;;
  esac
done
#read -r -p "What is your choice"
#sudo pacman -S --needed - < backup-paquets.txt
