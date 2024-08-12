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
read -n1 -s

echo " "

if [[ "$action" == 1 ]]; then
    bash /home/$USER/Klipper_Power_Resume/Interface_scripts/install.sh
    exit 0
fi

if [[ "$action" == 2 ]]; then
    bash /home/$USER/Klipper_Power_Resume/Interface_scripts/add_logs.sh
    exit 0
fi

if [[ "$action" == 3 ]]; then
    echo "Sorry, but this feature is currently not working. Please press enter to continue..."
    bash /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

if [[ "$action" == 4 ]]; then
    echo "Sorry, but this feature is currently not working. Please press enter to continue..."
    bash /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

if [[ "$action" == 5 ]]; then
    echo "Sorry, but this feature is currently not working. Please press enter to continue..."
    bash /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

if [[ "$action" == 6 ]]; then
    bash /home/$USER/Klipper_Power_Resume/Interface_scripts/uninstall.sh
    exit 0
fi

if [[ "$action" == 0 ]]; then
    echo " "
    echo "exiting..."
    exit 0
fi