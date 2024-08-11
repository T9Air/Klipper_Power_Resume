#!/bin/bash

read -r -p "Are you sure you want to uninstall? You will have to redownload if you want to re-install (y/N)" response1

if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    exit 1
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
