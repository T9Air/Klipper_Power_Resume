#!/bin/bash

clear
kpr="/home/$USER/Klipper_Power_Resume"

echo "Updating Klipper_Power_Resume..."
echo " "

# Run uninstall script without deleting the repository
bash "$kpr/Interface_scripts/uninstall.sh" --skip-delete-repo

# Update the repository
cd "$kpr"
git pull

# Run install script
bash "$kpr/Interface_scripts/install.sh"

echo "Update complete."
echo "Press any key to exit..."
read -r -n1 -s
exit 0