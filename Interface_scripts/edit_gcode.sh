#!/bin/bash

clear

if [ "$(ls -A "/home/$USER/Klipper_Power_Resume/start_gcode")" ]; then
    echo "These are the files currently available to edit..."
    echo " " 
    cd /home/$USER/Klipper_Power_Resume/start_gcode
    ls
else
    echo "Directory is empty..."
    echo "Exiting..."
    read -r -n1 -s
    /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

echo " "
echo "Please input the name of the file you want to edit"
echo "Do not include the .gcode extension"
read -r -p "If you want to exit, press enter. " filename
