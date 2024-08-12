#!/bin/bash

clear

echo "Please write the name of the file you want to restart."
echo "If it is in a subdirectory, please write it in this format: directory/file."
echo "If you want to go back to the Main Menu, press enter"
echo " "
read -r -p "Please input the filename: " filepath

if [[ "$filepath" == "" ]]; then
    echo "Exiting..."
    bash /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

filepath="/home/$USER/printer_data/gcodes/$filepath"
logpath="/home/$USER/Klipper_Power_Resume/log.txt"

