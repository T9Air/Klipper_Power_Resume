#!/bin/bash

echo "Custom start gcode creater"
read -r -p "Are you sure you want to create a custom start gcode? (Y/n) " response1

if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s
    /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

read -r -p "What to name the file? " filename

filename="/home/$USER/Klipper_Power_Resume/start_gcode/${filename}.gcode"
touch $filename

cd /home/$USER/Klipper_Power_Resume/start_gcode
nano ${filename}

echo " "
echo "Exiting..."
read -r -n1 -s
/home/$USER/Klipper_Power_Resume/interface.sh