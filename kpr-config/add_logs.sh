#!/bin/bash

# Clear the screen before starting
clear

kpr="/home/$USER/Klipper_Power_Resume"

# Initialize variables
filepath=""
num=5
line_based="yes"
printer_path=""

# Check if script was called with arguments (macro mode)
if [ $# -gt 0 ]; then
    # Command line mode - use the printer directory from which the macro was called
    printer_path="$4"  # New parameter for printer path
    if [ -z "$printer_path" ]; then
        echo "Error: Printer path not provided in macro mode"
        exit 1
    fi
    
    # Command line mode - expect just filename, construct full path
    inputfile="$1"
    filepath="$printer_path/gcodes/$inputfile"
    if [[ ! $filepath =~ \.gcode$ ]]; then
        filepath="${filepath}.gcode"
    fi
    if [ $# -gt 1 ]; then
        line_based="$2"
    fi
    if [ $# -gt 2 ]; then
        num="$3"
    fi
else
    # Interactive mode - use selected printer from config
    if [ ! -f "$kpr/config/selected_printer" ]; then
        echo "No printer selected! Please select a printer first."
        read -r -n1 -s
        "$kpr/Interface_scripts/menu.sh" home
        exit 1
    fi
    selected_printer=$(cat "$kpr/config/selected_printer")
    printer_path="/home/$USER/$selected_printer"
    
    echo "Please enter the name of your gcode file"
    echo "Example: my_print.gcode or my_print"
    echo "If you want to go back to the Main Menu, press enter"
    echo " "
    read -r -p "Filename: " inputfile

    # Check if the user pressed enter (empty input)
    if [[ "$inputfile" == "" ]]; then
        echo "Exiting..."
        read -r -n1 -s
        "$kpr/Interface_scripts/menu.sh" home
        exit 0
    fi

    # Construct full filepath
    filepath="$printer_path/gcodes/$inputfile"
    if [[ ! $filepath =~ \.gcode$ ]]; then
        filepath="${filepath}.gcode"
    fi

    read -r -p "Do you want to log every few lines? (Y/n) " response
    if [[ "$response" =~ ^[Nn]$ ]]; then
        line_based="no"
    fi
    
    if [[ "$line_based" == "yes" ]]; then
        echo "How many lines do you want to skip between logs?"
        read -r -p "5 is the minimum: " num
    fi
fi

# Check if the file exists
if [[ ! -f "$filepath" ]]; then
    echo "File not found: $filepath"
    if [ $# -eq 0 ]; then
        read -r -n1 -s
        "$kpr/Interface_scripts/menu.sh" home
    fi
    exit 1
fi

# Ensure minimum line count
if [ $num -lt 5 ]; then
    num=5
fi

touch "$filepath.tmp"

if [[ "$line_based" == "yes" ]]; then
    echo "Skipping ${num} lines..."
    
    i=0
    start_logging=0

    while IFS= read -r line; do
        echo $line >> "$filepath.tmp"
        if [[ $start_logging == 0 && ! "$line" =~ ^G[01] ]]; then
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

        if [[ $line =~ ^\;LAYER ]]; then
            echo "LOG_FILE" >> "$filepath.tmp"
        fi
    done < "$filepath"
fi

mv "$filepath.tmp" "$filepath"

# Insert UNLOG_FILE at the beginning of the file
sed -i '1i \UNLOG_FILE' $filepath

# Add LOG_FINISHED to end of file
echo "LOG_FINISHED" >> $filepath

# Exit handling
if [ $# -eq 0 ]; then
    echo "File changed!"
    echo "Press any key to exit..."
    read -r -n1 -s
    "$kpr/Interface_scripts/menu.sh" home
fi
exit 0