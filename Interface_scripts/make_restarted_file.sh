#!/bin/bash

clear

echo "Please write the name of the file you want to restart."
echo "If it is in a subdirectory, please write it in this format: directory/file."
echo "If you want to go back to the Main Menu, press enter"
echo " "
read -r -p "Please input the filename: " originalfilepath

if [[ "$originalfilepath" == "" ]]; then
    echo "Exiting..."
    read -r -n1 -s
    /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi


if [[ $originalfilepath == *.* ]]; then
    originalfilepath="/home/$USER/printer_data/gcodes/$originalfilepath"
else
    originalfilepath="/home/$USER/printer_data/gcodes/${originalfilepath}.gcode"
fi
if [[ ! -f "$originalfilepath" ]]; then
    echo "File not found: $originalfilepath"
    read -r -n1 -s
    /home/$USER/Klipper_Power_Resume/interface.sh
fi


logpath="/home/$USER/Klipper_Power_Resume/log.txt"

read -r -p "Do you want to use the standard start gcode? (Y/n) " starttype

extruder_temp=200
bed_temp=60

if [[ "$starttype" == [Nn] ]]; then
    echo " "
    echo "List of available start_gcode files..."
    echo " "
    cd /home/$USER/Klipper_Power_Resume/start_gcode 
    ls
    echo " "
    echo "Please just write the name of the file, excluding the .gcode"
    read -r -p "Pleae input the filename: " startfile
    startfilepath="/home/$USER/Klipper_Power_Resume/start_gcode/${startfile}.gcode"
    if [[ ! -f "$startfilepath" ]]; then
        echo "File not found: $startfilepath"
        echo "Press any key to exit..."
        read -r -n1 -s
        /home/$USER/Klipper_Power_Resume/interface.sh  
    fi
else
    read -r -p "What temperature should your extruder be set to? " extruder_temp
    echo " "
    read -r -p "What temperature should your bed be set to? " bed_temp
    gcode="M190 S$bed_temp \nG28 \nM109 S$extruder_temp \nUNLOG_FILE"
fi

linenumber=$(sed -n '1p' $logpath)
printerposition=$(sed -n '2p' $logpath)

linenumber=$((linenumber * 2))

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