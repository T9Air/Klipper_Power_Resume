#!/bin/bash

kpr="/home/$USER/Klipper_Power_Resume"

printer_path="$(dirname "$(dirname "$(dirname "$(readlink "$0")")")")"

dynamic_logpath="$printer_path/config/kpr-config/dynamic_log.txt"

filepath="$1"
starttype="$2"
startfile="$3"
extruder_temp="$4"
bed_temp="$5"
home_area="$6"

# Check if the filename has an extension
if [[ "$filepath" == *.gcode ]]; then
    # If it has an extension, do not add an extension
    filepath="$printer_path/gcodes/$filepath"
else
    # Otherwise add the .gcode extension
    filepath="$printer_path/gcodes/${filepath}.gcode"
fi

# Check if the file exists
if [[ ! -f "$filepath" ]]; then
    echo "File not found: $filepath" # Error message if file not found
    exit 1
fi

if [[ "$starttype" != "yes" ]]; then
    # Construct the full filepath with extension
    startfilepath="$kpr/start_gcode/${startfile}.gcode"

    # Check if the file exists
    if [[ ! -f "$startfilepath" ]]; then
        # If not...
        echo "File not found: $startfilepath"
        exit 1
    fi
else
    # If using standard start gcode
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
origfilepath_no_extension="${filepath%.*}"

# Create a new file that has the same name as the original with an added _restarted.gcode added on
newfilepath="${origfilepath_no_extension}_restarted.gcode"

# Copy the original file to the new file, and delete the first x bytes of the file based on the log
dd if="$filepath" of="$newfilepath" bs=1 skip="$bytes"
touch "$newfilepath.tmp"

if [[ "$home_area" == "yes" ]]; then
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
done < "$filepath"

mv "$newfilepath.tmp" "$newfilepath"

# Add the gcode to move to the last recorded position to the first line of the file
sed -i "1i $move" "$newfilepath"

if [[ "$starttype" != "yes" ]]; then
    # If using custom start gcode...
    sed -i "1r $startfilepath" "$newfilepath" # Append the contents of the custom gcode to the begginging of the new file
else
    # If using standard start gcode
    sed -i "1i $gcode" "$newfilepath" # Add the gcode that was created above to the begginging of the new file
fi

# Exit
echo "_restarted file created!"
exit 0