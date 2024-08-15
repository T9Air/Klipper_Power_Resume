#!/bin/bash

clear

read -r -p "Are you sure you want to uninstall? You will have to redownload if you want to re-install (y/N)" response1

if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s
    /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi
echo " "
echo "Deleting logger.cfg..."
rm /home/$USER/printer_data/config/logger.cfg
echo "logger.cfg deleted"

read -r -p "Is the second line in your printer.cfg [include logger.cfg]?: (y/N)" response2
if [[ "$response2" == [Nn] ]]; then
    echo "Please remove it when you can."
    echo "Press any key to continue..."
    read -r -n1 -s
else
    echo "removing logger.cfg inclusion from printer.cfg..."
    sed -i '2d' /home/$USER/printer_data/config/printer.cfg
    echo "logger.cfg inclusion removed"
fi

echo "You will need to remove the klipper_extras repo on your own."
#echo "Sadly, there is some strange error when running the rm -r command"
#echo "Therefore, you will need to delete the Klipper_Power_Resume folder on your own."

echo "Press any key to continue..."
read -r -n1 -s
#/home/$USER/Klipper_Power_Resume/interface.sh
#exit 0