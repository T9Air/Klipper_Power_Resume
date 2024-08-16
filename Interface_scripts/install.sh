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
    bash /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi

echo " "

# Inform user about extended_macros installation
echo "Please install the extended_macros repo."
echo " "
echo "This will download another repository from GitHub, and install it."
echo " "

# Provide installation instructions link for extended_macros repo
echo "Please follow the instructions at this link: https://github.com/droans/klipper_extras/blob/main/extended_macro/readme.md"
echo " "
echo "Once you finish installing it, you will be sent back here"
echo " "

# Ask user if they want to install extended_macros on their own, or through this script
read -r -p "Do you want to install it from here? (Y/n)" response2
echo " "

if [[ "$response2" == [Yy] ]]; then
    # If installing through script...
    cd ~ # Change directory to user's home directory
    git clone https://github.com/droans/klipper_extras.git # Clone the extended_macros repository from GitHub
    cd klipper_extras # Change directory to the cloned repository
    python3 scripts/install.py # Run the installation script
else
    # If installing manually, tell user they must install it, otherwise the logging will not work
    echo "Please remember to install it on your own, otherwise logging will not work."
    echo " "
fi

# Inform user about replacing username in configuration files
echo "Changing username in files to your username..."
sed -i "s/\/USER\([[:alnum:]_]*\)/\/$USER\1/g" ~/Klipper_Power_Resume/logger.cfg
sed -i "s/\/USER\([[:alnum:]_]*\)/\/$USER\1/g" ~/Klipper_Power_Resume/config.yaml
echo "usernames changed"
echo " "

# Inform user about moving logger.cfg to where the config files are stored
echo "Moving logger.cfg to where all your config files are stored..."
mv /home/$USER/Klipper_Power_Resume/logger.cfg /home/$USER/printer_data/config/
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

/home/$USER/Klipper_Power_Resume/interface.sh
exit 0