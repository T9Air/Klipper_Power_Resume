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

read -r -p "Do you want to delete the klipper_extras repo on your own? (y/N) " response3
echo " "
if [[ "$response3" == [Nn] ]]; then
    echo "Deleting klipper_extras repo..."
    rm -rf /home/$USER/klipper_extras
    echo "klipper_extras repo deleted"
else
    echo "Please remember to remove the klipper_extras repo"
fi

echo "Press any key to continue..."
read -r -n1 -s
echo " "

echo "Deleting Klipper_Power_Resume repository..."
rm -rf /home/$USER/Klipper_Power_Resume
echo "Repository deleted"
exit 0