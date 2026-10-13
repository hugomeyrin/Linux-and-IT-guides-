#!/bin/bash
#This program represents a car retailer available choices!!
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
VIOLET='\033[35m'
WHITE='\033[0;37m'
NC='\033[0m' # Pas de couleur
#start of the program
OPTIONS=("ALFAROMEO" "SUZUKIESCUDO" "PEUGEOT308PIKESPEAK" "VOLVOX60" "SUBARUIMPREZAWRC")
PRIX1="20000$"
PRIX2="1500600$"
PRIX3="56000$"
PRIX4="4800000$"
PRIX5="3000000$"
for i in ${OPTIONS[@]}; do # select each element i inside of all  @ values on the Table TAB[@]
  case $i in                # WILL MAKE THE MENU LIST THE CASE 
  ALFAROMEO) 
    echo -e "${RED}$i                     $PRIX1${NC}"
    ;;
  SUZUKIESCUDO)
    echo -e "${GREEN}$i                   $PRIX2${NC}"
    ;;
  PEUGEOT308PIKESPEAK)
    echo -e "${BLUE}$i                    $PRIX4${NC}"
    ;;
  VOLVOX60)
    echo -e "${WHITE}$i                   $PRIX3${NC}"
    ;;
  SUBARUIMPREZAWRC) 
    echo -e "${VIOLET}$i                  $PRIX5${NC}"
    ;;
      esac                                                                                     #print the message "les voitures disponibles" showing one element $i of the tableau TAB[@] individualy until it reaches the end of the tableau
  done  
echo ""                                                                                        # show also the car list with all the elements from the tableau
read -r -p "Selectionnez les voitures parmi les choix 0 a 4: " ch #asks the user to select his car on the available cars and store into the variable i
case $ch in                                                                                  #case in value inside i will do something for each selection
0)
  echo -e "${RED}la voiture selectionnée est ${OPTIONS[$ch]}${NC}"
  ;;
1)
  echo -e "${GREEN}la voiture selectionnée est ${OPTIONS[$ch]}${NC}"
  ;;
2)
  echo -e "${BLUE}la voiture selectionnée est ${OPTIONS[$ch]}${NC}"
  ;;
3)
  echo -e "${WHITE}la voiture selectionnée est ${OPTIONS[$ch]}${NC}"
  ;;
4)
  echo -e "${VIOLET}la voiture selectionnée est ${OPTIONS[$ch]}${NC}"
  ;;
esac
#echo "La Voiture Selectionnée est la: " ${OPTIONS[$ch]}
if [ -z "$ch" ]; then # if the indivual value inside of i = $i
  echo "le choix à pas été fait"   
fi 
