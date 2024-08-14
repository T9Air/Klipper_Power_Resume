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



