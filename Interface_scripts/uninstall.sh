#!/bin/bash

read -r -p "Are you sure you want to uninstall? You will have to redownload if you want to re-install (y/N)" response1

if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    bash /home/$USER/Klipper_Power_Resume/interface.sh
fi
echo " "
echo "Deleting logger.cfg..."
rm /home/$USER/printer_data/config/logger.cfg
echo "logger.cfg deleted"

read -r -p "Is the first line in your printer.cfg [include logger.cfg]?: (y/N)" response2
if [[ "$response2" == [Nn] ]]; then
    echo "Please remove it when you can."
    echo "Press any key to continue..."
    read -n1 -s
else
    echo "removing logger.cfg inclusion from printer.cfg..."
    sed -i '1d' /home/$USER/printer_data/config/printer.cfg
    echo "logger.cfg inclusion removed"
fi

echo "You will need to remove the klipper_extras repo on your own."
echo "Sadly, there is some strange error when running the rm -r command"
echo "Therefore, you will need to delete the Klipper_Power_Resume folder on your own."

echo "Press any key to exit..."
read -n1 -s
bash /home/$USER/Klipper_Power_Resume/interface.sh
# This is the bug: rm: cannot remove 'Klipper_Power_Resume/.git/objects/pack': Directory not empty