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

read -r -p "Do you want to use the standard start gcode? (Y/n) " starttype

extruder_temp=200
bed_temp=60

if [[ "$starttype" == [Nn] ]]; then
    echo ""
    echo "Sorry, but this feature is currently not working. Please press enter to continue..."
    read -n1 -s
else
    read -r -p "What temperature should your extruder be set to? " extruder_temp
    echo " "
    read -r -p "What temperature should your bed be set to? " bed_temp
    gcode="M190 S$bed_temp \nG28 \nM109 S$extruder_temp \nUNLOG_FILE"
fi