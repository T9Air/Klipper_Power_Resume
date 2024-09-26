#!/bin/bash

# Clear the screen before starting
clear

echo "Custom start gcode creater"

# Ask for confirmation before starting 
read -r -p "Are you sure you want to create a custom start gcode? (Y/n) " response1

# If no, go back to main
if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home
    exit 0
fi

# Ask what the name of the file should be
read -r -p "What to name the file? " filename

# Construct the full filepath with extension
filename="/home/$USER/Klipper_Power_Resume/start_gcode/${filename}.gcode"

# Create the file
touch $filename

echo "Please remember to add UNLOG_FILE to the end of the file"
echo "Press ctrl+x when finished editing"
read -r -n1 -s

# Navigate to the directory the file is in
cd /home/$USER/Klipper_Power_Resume/start_gcode

# Open the nano editor
nano ${filename}

# Exit
echo " "
echo "Exiting..."
read -r -n1 -s
/home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home