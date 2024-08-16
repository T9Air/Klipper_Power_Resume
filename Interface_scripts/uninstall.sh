#!/bin/bash

# Clear the screen before starting
clear

# Ask user to confirm that they want to uninstall
read -r -p "Are you sure you want to uninstall? You will have to redownload if you want to re-install (y/N)" response1

# If user says no...
if [[ "$response1" == [Nn] ]]; then
    echo "Exiting..."
    read -r -n1 -s # Wait for a keypress to prevent immediate exit
    /home/$USER/Klipper_Power_Resume/interface.sh
    exit 0
fi
echo " "

# Inform user that logger.cfg is being deleted
echo "Deleting logger.cfg..."
rm /home/$USER/printer_data/config/logger.cfg
echo "logger.cfg deleted"

# Ask user if the 2nd line of the printer.cfg is "[include logger.cfg]"
read -r -p "Is the second line in your printer.cfg [include logger.cfg]?: (y/N)" response2

if [[ "$response2" == [Nn] ]]; then
    # If no...
    # Tell the user to delete it on their own
    echo "Please remove it when you can."
    echo "Press any key to continue..."
    read -r -n1 -s # Wait for a keypress before continuing
else
    # If yes...
    # Inform user that [include logger.cfg] is being deleted
    echo "removing logger.cfg inclusion from printer.cfg..."
    sed -i '2d' /home/$USER/printer_data/config/printer.cfg
    echo "logger.cfg inclusion removed"
fi

# Ask user if the want to delete the klipper_extras repo on their own
read -r -p "Do you want to delete the klipper_extras repo on your own? (y/N) " response3
echo " "

if [[ "$response3" == [Nn] ]]; then
    # If no...
    # Inform user that the klipper_extras repo is being deleted
    echo "Deleting klipper_extras repo..."
    rm -rf /home/$USER/klipper_extras
    echo "klipper_extras repo deleted"
else
    # If yes...
    # Tell user to remove it on their own
    echo "Please remember to remove the klipper_extras repo"
fi

# Add break before deleting the whole repository
echo "Press any key to continue..."
read -r -n1 -s # Wait for a keypress before continuing
echo " "

# Inform user that the Klipper_Power_Resume repository is being deleted
echo "Deleting Klipper_Power_Resume repository..."
rm -rf /home/$USER/Klipper_Power_Resume
echo "Repository deleted"
exit 0