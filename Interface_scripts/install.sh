#!/bin/bash

# Clear the screen before starting
clear

kpr="/home/$USER/Klipper_Power_Resume"

echo "KLIPPER_POWER_RESUME Installer:"

# Ask for confirmation before installing
read -r -p "Are you sure you want to proceed? (y/N)" response1

# If no, go back to main menu
if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    bash "$kpr/Interface_scripts/menu.sh" home
    exit 0
fi

# Inform user that they need to install gcode_shell_command
echo " "
echo "Please install the gcode_shell_command extension from Kiauh"
echo "Press option 4 (advanced), and then option 8"
echo " "

# Wait for keypress to continue
echo "Press enter to continue..."
read -r -n1 -s
echo " "

# Create and copy kpr-config directory
echo "Creating kpr-config directory in config folder..."
mkdir -p /home/$USER/printer_data/config/kpr-config
cp -r $kpr/kpr-config/* /home/$USER/printer_data/config/kpr-config/
echo "kpr-config directory created and populated"
echo ""

# Check if logger.cfg is already in printer.cfg
in_config=$(sed -n '2p' /home/$USER/printer_data/config/printer.cfg)

if [[ "$in_config" == "[include kpr-config/logger.cfg]" ]]; then
    # Inform user that [include kpr-config/logger.cfg] is already in printer.cfg
    echo "[include kpr-config/logger.cfg] already in printer.cfg"
    echo ""
else
    # Inform user that adding [include logger.cfg] to their printer.cfg
    echo "Adding [include kpr-configlogger.cfg] to your printer.cfg..."
    sed -i '1a \[include kpr-config/logger.cfg]' /home/$USER/printer_data/config/printer.cfg
    echo "[include kpr-config/logger.cfg] added"
    echo ""
fi

# Inform user about creating a folder to store custom start gcodes
echo "Creating custom start gcode folder..."
cd $kpr
mkdir start_gcode
echo "custom start gcode folder created"

# Inform user about adding execute permissions to whole directory
echo "Adding permissions to files in Klipper_Power_Resume directory..."
chmod -R u+rwx $kpr

# Exit
echo "Installation finished!"
echo "Press any key to exit..."
read -r -n1 -s

"$kpr/Interface_scripts/menu.sh" home
exit 0