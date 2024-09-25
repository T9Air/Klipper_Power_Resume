#!/bin/bash

# Clear the screen before starting
clear

echo "KLIPPER_POWER_RESUME Installer:"

# Ask for confirmation before installing
read -r -p "Are you sure you want to proceed? (y/N)" response1

# If no, go back to main menu
if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    bash /home/$USER/Klipper_Power_Resume/menu.sh home
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

# Inform user about replacing username in configuration files
echo "Changing username in files to your username..."
sed -i "s/\/USER\([[:alnum:]_]*\)/\/$USER\1/g" ~/Klipper_Power_Resume/logger.cfg
echo "usernames changed"
echo " "

# Inform user about moving logger.cfg to where the config files are stored
echo "Moving logger.cfg to where all your config files are stored..."
cp /home/$USER/Klipper_Power_Resume/logger.cfg /home/$USER/printer_data/config/
echo "logger.cfg moved"
echo ""

# Inform user that adding [include logger.cfg] to their printer.cfg
echo "Adding [include logger.cfg] to your printer.cfg..."
sed -i '1a \[include logger.cfg]' /home/$USER/printer_data/config/printer.cfg
echo "[logger.cfg moved]"
echo ""

# Inform user about creating a folder to store custom start gcodes
echo "Creating custom start gcode folder..."
cd /home/$USER/Klipper_Power_Resume
mkdir start_gcode
echo "custom start gcode folder created"

# Inform user about adding execute permissions to whole directory
echo "Adding permissions to files in Klipper_Power_Resume directory..."
chmod -R u+rwx /home/$USER/Klipper_Power_Resume

# Exit
echo "Installation finished!"
echo "Press any key to exit..."
read -r -n1 -s

/home/$USER/Klipper_Power_Resume/menu.sh home
exit 0