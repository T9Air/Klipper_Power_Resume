#!/bin/bash

# Clear screen before displaying menu
clear

kpr="/home/$USER/Klipper_Power_Resume"

# if [ $1 == "restart" ]; then
#      # Check if the last print was finished or not
#     finished1=$(sed -n '1p' /home/$USER/printer_data/config/kpr-config/static_log.txt)
#     finished2=$(sed -n '2p' /home/$USER/printer_data/config/kpr-config/static_log.txt)

#     if ! [[ $finished1 == "Finished" || $finished2 == "Finished" ]]; then
#         read -r -p "Do you want to restart your last print? (Y/n) " restart
    
#         if [[ "$restart" == [Yy] ]]; then
#             $kpr/Interface_scripts/restart_file.sh
#         fi
#         echo "Finished" >> /home/$USER/printer_data/kpr-config/static_log.txt
#     fi
# fi

# Get currently selected printer
selected_printer=""
if [ -f "$kpr/config/selected_printer" ]; then
    selected_printer=$(cat "$kpr/config/selected_printer")
fi

clear

# Menu
echo "Klipper_Power_Resume:"
if [ ! -z "$selected_printer" ]; then
    echo "Current printer: $selected_printer"
fi
echo "(1) Install"
echo "(2) Add logging gcode to a file"
echo "(3) Make a restarted file"
echo "(4) Create start gcode"
echo "(5) Edit start gcode"
echo "(6) Uninstall"
echo "(7) Select printer"
echo "(0) Quit"

# Ask user for menu option
read -r -n1 -p "#### Perform an action: " action
# Wait for additional keypress
read -r -n1 -s

echo " "

if [[ "$action" == 1 ]]; then
    bash $kpr/Interface_scripts/install.sh
    exit 0
fi

if [[ "$action" == 2 ]]; then
    $kpr/Interface_scripts/add_logs.sh
    exit 0
fi

if [[ "$action" == 3 ]]; then
    $kpr/Interface_scripts/make_restarted_file.sh
    exit 0
fi

if [[ "$action" == 4 ]]; then
    $kpr/Interface_scripts/create_gcode.sh
    exit 0
fi

if [[ "$action" == 5 ]]; then
    $kpr/Interface_scripts/edit_gcode.sh
    exit 0
fi

if [[ "$action" == 6 ]]; then
    $kpr/Interface_scripts/uninstall.sh
    exit 0
fi

if [[ "$action" == 7 ]]; then
    $kpr/Interface_scripts/select_printer.sh
    exit 0
fi

if [[ "$action" == 0 ]]; then
    echo " "
    echo "exiting..."
    exit 0
fi