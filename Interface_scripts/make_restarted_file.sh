#!/bin/bash

# Clear the screen before starting
clear

# Ask user the name of the file that need to be restarted
echo "Please write the name of the file you want to restart."
echo "If it is in a subdirectory, please write it in this format: directory/file."

# Inform the user that they can press enter to exit
echo "If you want to go back to the Main Menu, press enter"
echo " "
read -r -p "Please input the filename: " originalfilepath

# If user pressed enter, exit
if [[ "$originalfilepath" == "" ]]; then
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

# Check if the filename has an extension
if [[ $originalfilepath == *.* ]]; then
    # If it has an extension, do not add an extension
    originalfilepath="/home/$USER/printer_data/gcodes/$originalfilepath"
else
    # Otherwise add the .gcode extension
    originalfilepath="/home/$USER/printer_data/gcodes/${originalfilepath}.gcode"
fi

# Check if the file exists
if [[ ! -f "$originalfilepath" ]]; then
    echo "File not found: $originalfilepath" # Error message if file not found
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/interface.sh
fi

# Set the path to the log file
logpath="/home/$USER/Klipper_Power_Resume/log.txt"

# Ask user if they want to use the standard gcode
read -r -p "Do you want to use the standard start gcode? (Y/n) " starttype

# Set base extruder and bed temps
extruder_temp=200
bed_temp=60

if [[ "$starttype" == [Nn] ]]; then
    # If using custom start gcode

    # List available start gcode files
    echo " "
    echo "List of available start_gcode files..."
    echo " "
    cd /home/$USER/Klipper_Power_Resume/start_gcode 
    ls
    echo " "

    # Ask user to write the name of the file they want to use
    echo "Please just write the name of the file, excluding the .gcode"
    read -r -p "Pleae input the filename: " startfile

    # Construct the full filepath with extension
    startfilepath="/home/$USER/Klipper_Power_Resume/start_gcode/${startfile}.gcode"

    # Check if the file exists
    if [[ ! -f "$startfilepath" ]]; then
        # If not...
        echo "File not found: $startfilepath"
        echo "Press any key to exit..."
        read -r -n1 -s # Wait for a keypress to prevent immediate exit
        /home/$USER/Klipper_Power_Resume/interface.sh  
    fi
else
    # If using standard start gcode

    # Ask what tempature the extruder should be set to
    read -r -p "What temperature should your extruder be set to? " extruder_temp
    echo " "

    # Ask what tempature the bed should be set to
    read -r -p "What temperature should your bed be set to? " bed_temp

    # Use the input to create a start gcode
    # 1. Heat up the bed, 2. Home the extruder, 3. Heat up the extruder, 4. UNLOG_FILE
    gcode="M190 S$bed_temp \nG28 \nM109 S$extruder_temp \nUNLOG_FILE"
fi

linenumber=$(sed -n '1p' $logpath)
printerposition=$(sed -n '2p' $logpath)

read -r -p "How many lines were skipped in between logs? " skippedlines

skippedlines=$((skippedlines + 2))

linenumber=$((linenumber * skippedlines))

origfilepath_no_extension="${originalfilepath%.*}"
newfilepath="${origfilepath_no_extension}_restarted.gcode"

cp $originalfilepath $newfilepath

sed -i "1,${linenumber}d" $newfilepath
sed -i "1i $printerposition" $newfilepath

if [[ "$starttype" == [Nn] ]]; then
    sed -i "1r $startfilepath" $newfilepath
else
    sed -i "1i $gcode" $newfilepath
fi


echo "_restarted file created!"
echo "Press any key to exit..."
read -r -n1 -s

/home/$USER/Klipper_Power_Resume/interface.sh
exit 0