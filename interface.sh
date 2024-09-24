#!/bin/bash

# Clear screen before displaying menu
clear

# Check if the last print was finished or not
finished=$(sed -n '1p' /home/$USER/Klipper_Power_Resume/log.txt)

if ! [ "$finished" == "Finished" ]; then
    read -r -p "Do you want to restart your last print? (Y/n) " restart
    
    if [[ "$restart" == [Yy] ]]; then
        /home/$USER/Klipper_Power_Resume/Interface_scripts/restart_file.sh
    fi
fi

echo "Finished" > /home/$USER/Klipper_Power_Resume/log.txt

# Menu
echo "Klipper_Power_Resume:"
echo "(1) Install"
echo "(2) Add logging gcode to a file"
echo "(3) Make a restarted file"
echo "(4) Create start gcode"
echo "(5) Edit start gcode"
echo "(6) Uninstall"
echo "(0) Quit"

# Ask user for menu option
read -r -n1 -p "#### Perform an action: " action
# Wait for additional keypress
read -r -n1 -s

echo " "

if [[ "$action" == 1 ]]; then
    bash /home/$USER/Klipper_Power_Resume/Interface_scripts/install.sh
    exit 0
fi

if [[ "$action" == 2 ]]; then
    /home/$USER/Klipper_Power_Resume/Interface_scripts/add_logs.sh
    exit 0
fi

if [[ "$action" == 3 ]]; then
    /home/$USER/Klipper_Power_Resume/Interface_scripts/make_restarted_file.sh main
    exit 0
fi

if [[ "$action" == 4 ]]; then
    /home/$USER/Klipper_Power_Resume/Interface_scripts/create_gcode.sh
    exit 0
fi

if [[ "$action" == 5 ]]; then
    /home/$USER/Klipper_Power_Resume/Interface_scripts/edit_gcode.sh
    exit 0
fi

if [[ "$action" == 6 ]]; then
    /home/$USER/Klipper_Power_Resume/Interface_scripts/uninstall.sh
    exit 0
fi

if [[ "$action" == 0 ]]; then
    echo " "
    echo "exiting..."
    exit 0
fi