#!/bin/bash

# Clear the screen before starting
clear

kpr="/home/$USER/Klipper_Power_Resume"

# Ask user to confirm that they want to uninstall
read -r -p "Are you sure you want to uninstall? You will have to redownload if you want to re-install (y/N)" response1

# If user says no...
if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    "$kpr/Interface_scripts/menu.sh" home
    exit 0
fi
echo " "

# Find all printer_data directories
printer_data_dirs=$(find /home/$USER -type d -name "printer_data" 2>/dev/null)

# Process each printer_data directory
for printer_dir in $printer_data_dirs; do
    echo "Processing: $printer_dir"
    
    # Remove kpr-config directory if it exists
    if [ -d "$printer_dir/config/kpr-config" ]; then
        echo "Deleting logger.cfg from $printer_dir..."
        rm -r "$printer_dir/config/kpr-config"
        echo "logger.cfg deleted"
    fi

    # Check and update printer.cfg
    if [ -f "$printer_dir/config/printer.cfg" ]; then
        if grep -q "^\[include kpr-config/logger.cfg\]" "$printer_dir/config/printer.cfg"; then
            echo "Removing logger.cfg inclusion from $printer_dir/config/printer.cfg..."
            sed -i '/^\[include kpr-config\/logger.cfg\]/d' "$printer_dir/config/printer.cfg"
            echo "logger.cfg inclusion removed"
        fi

        if grep -q "^\[include kpr-config/edit_file.cfg\]" "$printer_dir/config/printer.cfg"; then
            echo "Removing edit_file.cfg inclusion from $printer_dir/config/printer.cfg..."
            sed -i '/^\[include kpr-config\/edit_file.cfg\]/d' "$printer_dir/config/printer.cfg"
            echo "edit_file.cfg inclusion removed"
        fi
    fi
done

# Add break before deleting the whole repository
echo "Press any key to continue..."
read -r -n1 -s # Wait for a keypress before continuing
echo " "

# Inform user that the Klipper_Power_Resume repository is being deleted
echo "Deleting Klipper_Power_Resume repository..."
rm -rf $kpr
echo "Repository deleted"
cd ~
exit 0