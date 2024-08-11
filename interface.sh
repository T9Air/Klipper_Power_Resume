#!/bin/bash

clear

echo "Klipper_Power_Resume:"
echo "(1) Install"
echo "(2) Add logging gcode to a file"
echo "(3) Make a restarted file"
echo "(4) Create start gcode"
echo "(5) Edit start gcode"
echo "(6) Uninstall"
echo "(0) Quit"

read -r -n1 -p "#### Perform an action: " action

if [[ "$action" == 1 ]]; then
    bash /home/$USER/Klipper_Power_Resume/Interface scripts/install.sh
fi

if [[ "$action" == 2 ]]; then
    bash /home/$USER/Klipper_Power_Resume/Interface scripts/add_logs.sh
fi

if [[ "$action" == 6 ]]; then
    bash /home/$USER/Klipper_Power_Resume/Interface scripts/uninstall.sh
fi

if [[ "$action" == 0 ]]; then
    echo "exiting..."
    exit 0
fi