#!/bin/bash

clear

echo "Please write the name of the file you want to add."
echo "If it is in a subdirectory, please write it in this format: directory/file."
echo "If you want to go back to the Main Menu, press enter"
echo " "
read -r -p "Please input the filename: " filepath

if [[ "$filepath" == "" ]]; then
    echo "Exiting..."
    exit 0
fi

num=1

filepath="/home/$USER/printer_data/gcodes/$filepath"

if [[ ! -f "$filepath" ]]; then
    echo "File not found: $filepath"
    exit 1
fi

read -r -p "How many lines do you want to skip between logs? " num

num=$(($num + 1))

sed -i '1i \UNLOG_FILE' $filepath
sed -i "${num}~${num}a\LOG_FILE" $filepath

echo "File changed!"
echo "Press any key to exit..."
read -n1 -s