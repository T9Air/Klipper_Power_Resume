#!/bin/bash

# Clear the screen before starting
clear

kpr="/home/$USER/Klipper_Power_Resume"

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
    "$kpr/Interface_scripts/menu.sh" home
    exit 0
fi

# Initialize line number to skip 
num=1

# Check if the filename has an extension
if [[ $filepath == *.gcode ]]; then
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
    "$kpr/Interface_scripts/menu.sh" home
fi

touch "$filepath.tmp"

read -r -p "Do you want to log every (1) few lines or every (2) layer? " layer

if [ $layer == "1" ]; then
    # Prompt the user for the number of lines to skip
    # Minimum is 5 lines
    echo "How many lines do you want to skip between logs?"
    read -r -p "5 is the minimum: " num

    # Check if num is less than 5
    if [ $num -lt 5 ]; then
        num=5
    fi

    echo "Skipping ${num} lines..."
    
    i=0
    start_logging=0

    while IFS= read -r line; do
        echo $line >> "$filepath.tmp"
        if [ $start_logging == 0 && ! "$line" =~ ^G[01] ]; then
            start_logging=0
        else
            if [ $start_logging == 0 ]; then
                start_logging=1
            fi
            if [ $i == $num ]; then
                i=0
                echo "LOG_FILE" >> "$filepath.tmp"
            else
                i=$(( i + 1 ))
            fi
        fi
    done < "$filepath"
else
    while IFS= read -r line; do
        echo $line >> "$filepath.tmp"

        if [ $line =~ ^;LAYER ]; then
            echo "LOG_FILE" >> "$filepath.tmp"
        fi
    done < "$filepath"
fi

mv "$filepath.tmp" "$filepath"

# Insert UNLOG_FILE at the beginning of the file
sed -i '1i \UNLOG_FILE' $filepath

# Add LOG_FINISHED to end of file
echo "LOG_FINISHED" >> $filepath

# Exit
echo "File changed!"
echo "Press any key to exit..."
read -r -n1 -s
"$kpr/Interface_scripts/menu.sh" home
exit 0