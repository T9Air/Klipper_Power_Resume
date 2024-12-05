#!/bin/bash

# Clear the screen before starting
clear

kpr="/home/$USER/Klipper_Power_Resume"

# Add near the start of each script after kpr definition:
# Check if printer is selected
if [ ! -f "$kpr/config/selected_printer" ]; then
    echo "No printer selected! Please select a printer first."
    read -r -n1 -s
    "$kpr/Interface_scripts/menu.sh" home
    exit 1
fi

selected_printer=$(cat "$kpr/config/selected_printer")
printer_path="/home/$USER/$selected_printer"

# Set the path to the log file
dynamic_logpath="/home/$USER/$printer_path/config/kpr-config/dynamic_log.txt"

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
    "$kpr/Interface_scripts/menu.sh" home
    exit 0
fi

# Check if the filename has an extension
if [[ $originalfilepath == *.gcode ]]; then
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
    "$kpr/Interface_scripts/menu.sh" home
    exit 0
fi

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
    cd $kpr/start_gcode 
    ls
    echo " "

    # Ask user to write the name of the file they want to use
    echo "Please just write the name of the file, excluding the .gcode"
    read -r -p "Pleae input the filename: " startfile

    # Construct the full filepath with extension
    startfilepath="$kpr/start_gcode/${startfile}.gcode"

    # Check if the file exists
    if [[ ! -f "$startfilepath" ]]; then
        # If not...
        echo "File not found: $startfilepath"
        echo "Press any key to exit..."
        read -r -n1 -s # Wait for a keypress to prevent immediate exit
        "$kpr/Interface_scripts/menu.sh" home  
        exit 0
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

# Get the number of bytes that were run in the file
bytes=$(sed -n '1p' "$dynamic_logpath")

# Get the last recorded printer position
printerx=$(sed -n '2p' "$dynamic_logpath")
printery=$(sed -n '3p' "$dynamic_logpath")
printerz=$(sed -n '4p' "$dynamic_logpath")
printere=$(sed -n '5p' "$dynamic_logpath")
speed=$(sed -n '6p' "$dynamic_logpath")

move="G90 \nG0 F${speed} X${printerx} Y${printery} \nG0 F150 Z${printerz} \nG0 F${speed} \nG92 E0"

# Create a string of the original file without the .gcode extension
origfilepath_no_extension="${originalfilepath%.*}"

# Create a new file that has the same name as the original with an added _restarted.gcode added on
newfilepath="${origfilepath_no_extension}_restarted.gcode"

# Copy the original file to the new file, and delete the first x bytes of the file based on the log
dd if=$originalfilepath of=$newfilepath bs=1 skip=$bytes

read -r -p "Are you homing on the print (1) or in the corner (2)? " home_area

touch "$newfilepath.tmp"

if [[ "$home_area" == "1" ]]; then
    move="SET_GCODE_OFFSET Z_ADJUST=-${printerz} \n$move"
fi

while IFS= read -r line; do
    if [[ "$line" =~ ^G[01] ]]; then        
        # Adjust E-coordinates in G1 commands based on the last recorded e position
        if [[ "$line" =~ E ]]; then
            e_coord=$(echo "$line" | cut -d E -f 2)
            new_e_coord=$(bc <<< "$e_coord - $printere")
            line=$(echo "$line" | sed "s/E${e_coord}/E${new_e_coord}/")
        fi
    fi

    echo "$line" >> "$newfilepath.tmp"
done < "$newfilepath"

mv "$newfilepath.tmp" "$newfilepath"

# Add the gcode to move to the last recorded position to the first line of the file
sed -i "1i $move" $newfilepath

if [[ "$starttype" == [Nn] ]]; then
    # If using custom start gcode...
    sed -i "1r $startfilepath" $newfilepath # Append the contents of the custom gcode to the begginging of the new file
else
    # If using standard start gcode
    sed -i "1i $gcode" $newfilepath # Add the gcode that was created above to the begginging of the new file
fi

# Exit
echo "_restarted file created!"

echo ""

read -r -p "Do you want to restart the print now? (y/N) " run

filename=$(basename newfilepath)

if [[ $run == [Yy] ]]; then
    echo SDCARD_PRINT_FILE FILENAME=$filename > ~/printer_data/comms/klippy.serial
fi

"$kpr/Interface_scripts/menu.sh" home
exit 0