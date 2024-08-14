#!/bin/bash

echo "Custom start gcode creater"
read -r -p "Are you sure you want to create a custom start gcode? (Y/n) " response1

if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s
    bash /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi