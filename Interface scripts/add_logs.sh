#!/bin/bash

clear

echo "Please write the name of the file you want to add."
echo "If it is in a subdirectory, please write it in this format: directory/file."
read -r -p "If you want to go back to the Main Menu, press 0 and then press enter" filepath

if [[ "$filepath" == [0] ]]; then
    echo "Exiting..."
    exit 0
fi

num=0

filepath = "/home/$USER/printer_data/gcodes/" + $filepath

read -r -p "How many lines do you want to skip between logs?" num

sed "0~num a\LOG_FILE" $filepath

sed -i '1i \UNLOG_FILE' $filepath