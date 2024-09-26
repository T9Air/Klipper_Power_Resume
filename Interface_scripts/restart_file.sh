#!/bin/bash

clear

# Set the path to the log file
logpath="/home/$USER/Klipper_Power_Resume/log.txt"

originalfilepath=$(sed -n '1p' $logpath)

# Check if the file exists
if [[ ! -f "$originalfilepath" ]]; then
    echo "File not found: $originalfilepath" # Error message if file not found
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home
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
        /home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh home  
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

# Get the linenumber where the printer stopped
linenumber=$(sed -n '2p' $logpath)

# Get the last recorded printer position
printerx=$(sed -n '3p' $logpath)
printery=$(sed -n '4p' $logpath)
printerz=$(sed -n '5p' $logpath)

printerposition="G0 X${printerx} Y${printery} Z${printerz}"

# Ask how many lines were skipped between logs
read -r -p "How many lines were skipped in between logs? " skippedlines

# Calculate the amount of lines to delete
skippedlines=$((skippedlines + 2)) # Add 2 to the amount of lines that were skipped

linenumber=$((linenumber * skippedlines)) # Multiply the logged line number by the above number

# Create a string of the original file without the .gcode extension
origfilepath_no_extension="${originalfilepath%.*}"

# Create a new file that has the same name as the original with an added _restarted.gcode added on
newfilepath="${origfilepath_no_extension}_restarted.gcode"

# Copy the contents of the original file to a new file
cp $originalfilepath $newfilepath

# Delete an amount of lines based on the calculated number above
sed -i "1,${linenumber}d" $newfilepath

# Add the gcode to move to the last recorded position to the first line of the file
sed -i "1i $printerposition" $newfilepath

read -r -p "Are you homing on the print (1) or in the corner (2)? " home_area

if [[ "$home_area" == "1" ]]; then
    touch "$newfilepath.tmp"

    # Adjust Z-coordinates in G0 and G1 commands based on the last recorded printer position
    while IFS= read -r line; do
        if [[ "$line" =~ ^G[01] ]]; then
            if [[ "$line" =~ Z ]]; then
                z_coord=$(echo "$line" | cut -d Z -f 2)
                new_z_coord=$(bc <<< "$z_coord - $printerz")
                if [[ $(bc <<< "$new_z_coord < 1") -eq 1 && $(bc <<< "$new_z_coord != 0") -eq 1 ]]; then
                    new_z_coord="0${new_z_coord}"    
                fi
                if ! [[ $new_z_coord =~ \. ]]; then
                    new_z_coord="${new_z_coord}.0"
                fi
                line=$(echo "$line" | sed "s/Z${z_coord}/Z${new_z_coord}/")
            fi
        fi
    echo "$line" >> "$newfilepath.tmp"
    done < "$newfilepath"
    mv "$newfilepath.tmp" "$newfilepath"
fi

if [[ "$starttype" == [Nn] ]]; then
    # If using custom start gcode...
    sed -i "1r $startfilepath" $newfilepath # Append the contents of the custom gcode to the begginging of the new file
else
    # If using standard start gcode
    sed -i "1i $gcode" $newfilepath # Add the gcode that was created above to the begginging of the new file
fi

echo "_restarted file created!"
echo ""

read -r -p "Do you want to restart the print now? (y/N) " run

echo "Finished" > /home/$USER/Klipper_Power_Resume/log.txt

filename=$(basename newfilepath)

if [[ $run == [Yy] ]]; then
    echo SDCARD_PRINT_FILE FILENAME=$filename > ~/printer_data/comms/klippy.serial
fi

exit 0