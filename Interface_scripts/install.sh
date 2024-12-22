#!/bin/bash

clear
kpr="/home/$USER/Klipper_Power_Resume"

# Function to find printer configs
find_printer_configs() {
    local configs=()
    for dir in /home/$USER/printer_*; do
        if [ -d "$dir" ]; then
            configs+=("${dir##*/}")
        fi
    done
    echo "${configs[@]}"
}

echo "KLIPPER_POWER_RESUME Installer:"

read -r -p "Are you sure you want to proceed? (y/N)" response1
if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s
    bash "$kpr/Interface_scripts/menu.sh" home
    exit 0
fi

# Create config directory if it doesn't exist
mkdir -p "$kpr/config"

# Get available printer configs
printer_configs=($(find_printer_configs))

if [ ${#printer_configs[@]} -eq 0 ]; then
    echo "No printer configurations found!"
    exit 1
fi

# Display found printers
echo "Found printer configurations:"
for printer in "${printer_configs[@]}"; do
    echo "- $printer"
done
echo "Installing for all printers..."

# Inform user that they need to install gcode_shell_command
echo " "
echo "Please install the gcode_shell_command extension from Kiauh"
echo "Press option 4 (advanced), and then option 8"
echo " "

# Wait for keypress to continue
echo "Press enter to continue..."
read -r -n1 -s
echo " "

# Install for each printer configuration
for printer in "${printer_configs[@]}"; do
    printer_path="/home/$USER/$printer"
    echo "Installing for $printer..."

    # Create and copy kpr-config directory
    echo "Creating kpr-config directory in config folder..."
    mkdir -p "${printer_path}/config/kpr-config"
    cp -r $kpr/kpr-config/* "${printer_path}/config/kpr-config/"

    # Change ownership of the kpr-config directory to the current user
    chown -R $USER:$USER "${printer_path}/config/kpr-config"

    # Set permissions for kpr-config directory
    chmod -R 777 "${printer_path}/config/kpr-config"
    
    # Set write permissions for log files
    chmod 666 "${printer_path}/config/kpr-config/static_log.txt"
    chmod 666 "${printer_path}/config/kpr-config/dynamic_log.txt"

    # Check and update printer.cfg
    in_config=$(sed -n '2p' "${printer_path}/config/printer.cfg")
    if [[ "$in_config" == "[include kpr-config/logger.cfg]" ]]; then
        echo "[include kpr-config/logger.cfg] already in printer.cfg"
    else
        echo "Adding [include kpr-config/logger.cfg] to printer.cfg..."
        sed -i '1a \[include kpr-config/logger.cfg]' "${printer_path}/config/printer.cfg"
    fi
    echo "Installation complete for $printer"
    echo ""
done

# Inform user about creating a folder to store custom start gcodes
echo "Creating custom start gcode folder..."
cd $kpr
mkdir -p start_gcode

# Change ownership of the Klipper_Power_Resume directory to the current user
chown -R $USER:$USER $kpr

# Inform user about adding execute permissions to whole directory
echo "Adding permissions to files in Klipper_Power_Resume directory..."
chmod -R 777 $kpr

# Exit
echo "Installation finished for all printers!"
echo "Press any key to exit..."
read -r -n1 -s

"$kpr/Interface_scripts/menu.sh" home
exit 0
