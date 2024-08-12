#!/bin/bash
clear
echo "KLIPPER_POWER_RESUME Installer:"
read -r -p "Are you sure you want to proceed? (y/N)" response1

if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    bash /home/$USER/Klipper_Power_Resume/interface.sh
fi
echo " "
echo "Please install the extended_macros repo."
echo " "
echo "This will download another repository from GitHub, and install it."
echo " "
echo "Please follow the instructions at this link: https://github.com/droans/klipper_extras/blob/main/extended_macro/readme.md"
echo " "
echo "Once you finish installing it, you will be sent back here"
echo " "
read -r -p "Do you want to install it from here? (Y/n)" response2
echo " "

if [[ "$response2" == [Yy] ]]; then
    cd ~
    git clone https://github.com/droans/klipper_extras.git
    cd klipper_extras
    python3 scripts/install.py
else
    echo "Please remember to install it on your own, otherwise this will not work."
    echo " "
fi

echo "Changing username in files to your username..."

sed -i "s/\/USER\([[:alnum:]_]*\)/\/$USER\1/g" ~/Klipper_Power_Resume/logger.cfg
sed -i "s/\/USER\([[:alnum:]_]*\)/\/$USER\1/g" ~/Klipper_Power_Resume/config.yaml
sed -i "s/\/USER\([[:alnum:]_]*\)/\/$USER\1/g" ~/Klipper_Power_Resume/Make_Resumed_File.py

echo "usernames changed"
echo " "

echo "Moving logger.cfg to where all your config files are stored..."

mv /home/$USER/Klipper_Power_Resume/logger.cfg /home/$USER/printer_data/config/

echo "logger.cfg moved"
echo ""

echo "Adding [include logger.cfg] to your printer.cfg..."

sed -i '1i \[include logger.cfg]' /home/$USER/printer_data/config/printer.cfg

echo "[logger.cfg moved]"
echo ""

echo "Installation finished!"
echo "Press any key to exit..."
read -n1 -s

bash /home/$USER/Klipper_Power_Resume/interface.sh