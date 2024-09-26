#!/bin/bash

# Clear screen before starting
clear

# Check if there are any available files to edit
if [ "$(ls -A "/home/$USER/Klipper_Power_Resume/start_gcode")" ]; then
    # If there are...
    echo "These are the files currently available to edit..."
    echo " " 
    cd /home/$USER/Klipper_Power_Resume/start_gcode # Navigate to the start_gcode directory
    ls # List all of the files available to edit
else
    # If not...
    echo "Directory is empty..."
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home
    exit 0
fi

echo " "

# Ask the user for the name of the file to edit
echo "Please input the name of the file you want to edit"
echo "Do not include the .gcode extension"

# Inform user they can exit by pressing enter
read -r -p "If you want to exit, press enter. " filename

# Check if the user pressed enter (empty input)
if [[ "$filename" == "" ]]; then
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home
    exit 0
fi

# Construct the full filepath with extension
filename="/home/$USER/Klipper_Power_Resume/start_gcode/${filename}.gcode"

# Check if the file exists
if [[ ! -f "$filename" ]]; then
    # If not...
    echo "File not found: $filename"
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home
fi

# Inform user about exiting with ctrl+x
echo "Press ctrl+x when finished editing"
read -r -n1 -s

# Navigate to the start_gcode directory
cd /home/$USER/Klipper_Power_Resume/start_gcode

# Open the nano editor
nano ${filename}

# Exit
echo " "
echo "Exiting..."
read -r -n1 -s
/home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home