#!/bin/bash

# Clear the screen before starting
clear

# Ask the user for the filename
echo "Please write the name of the file you want to add."
echo "If it is in a subdirectory, please write it in this format: directory/file."
echo "If you want to go back to the Main Menu, press enter"
echo " "
read -r -p "Please input the filename: " filepath

# Check if the user pressed enter (empty input)
if [[ "$filepath" == "" ]]; then
    echo "Exiting..."
    read -r -n1 -s  # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/menu.sh
    exit 0
fi

# Initialize line number to skip 
num=1

# Check if the filename has an extension
if [[ $filepath == *.* ]]; then
    # If it has an extension, do not add an extension
    filepath="/home/$USER/printer_data/gcodes/$filepath"
else
    # Otherwise add the .gcode extension
    filepath="/home/$USER/printer_data/gcodes/${filepath}.gcode"
fi

# Check if the file exists
if [[ ! -f "$filepath" ]]; then
    echo "File not found: $filepath" # Error message if file not found
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/menu.sh
fi

# Prompt the user for the number of lines to skip
read -r -p "How many lines do you want to skip between logs? " num

# Add 1 to the number so as to be able to add after each line
num=$((num + 1))

# Insert UNLOG_FILE at the beginning of the file
sed -i '1i \UNLOG_FILE' $filepath

# Insert LOG_FILE after the specified number of lines (skipping the first line)
sed -i "${num}~${num}a\LOG_FILE" $filepath

# Add LOG_FINISHED to end of file
echo "LOG_FINISHED" >> $filepath

# Exit
echo "File changed!"
echo "Press any key to exit..."
read -r -n1 -s
/home/$USER/Klipper_Power_Resume/menu.sh
exit 0