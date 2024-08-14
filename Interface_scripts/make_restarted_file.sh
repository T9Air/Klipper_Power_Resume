#!/bin/bash

clear

echo "Please write the name of the file you want to restart."
echo "If it is in a subdirectory, please write it in this format: directory/file."
echo "If you want to go back to the Main Menu, press enter"
echo " "
read -r -p "Please input the filename: " originalfilepath

if [[ "$originalfilepath" == "" ]]; then
    echo "Exiting..."
    /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

originalfilepath="/home/$USER/printer_data/gcodes/${originalfilepath}.gcode"
logpath="/home/$USER/Klipper_Power_Resume/log.txt"

read -r -p "Do you want to use the standard start gcode? (Y/n) " starttype

extruder_temp=200
bed_temp=60

if [[ "$starttype" == [Nn] ]]; then
    echo ""
    echo "Sorry, but this feature is currently not working. Please press enter to continue..."
    read -r -n1 -s
else
    read -r -p "What temperature should your extruder be set to? " extruder_temp
    echo " "
    read -r -p "What temperature should your bed be set to? " bed_temp
    gcode="M190 S$bed_temp \nG28 \nM109 S$extruder_temp \nUNLOG_FILE"
fi

# TODO: Change the next code to work with custom start gcode 
#       Potentially, could have the next code depend on whether using custom gcode or not

linenumber=$(sed -n '1p' $logpath)
printerposition=$(sed -n '2p' $logpath)

linenumber=$(($linenumber * 2))

origfilepath_no_extension="${originalfilepath%.*}"
newfilepath="${origfilepath_no_extension}_restarted.gcode"

cp $originalfilepath $newfilepath

sed -i "1,${linenumber}d" $newfilepath
sed -i "1i $printerposition" $newfilepaths
sed -i "1i $gcode" $newfilepath

echo "_restarted file created!"
echo "Press any key to exit..."
read -r -n1 -s

/home/$USER/Klipper_Power_Resume/interface.sh
exit 0