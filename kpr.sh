#!/bin/bash

echo "Klipper_Power_Resume v3.6.0-beta.1"
echo " "
echo "Feedback would be greatly appreciated"
echo " "
read -r -n1 -s "Press enter to continue..."
clear

current_version="v3.6.0-beta.1"
kpr="/home/$USER/Klipper_Power_Resume"

# Check for updates
cd "$kpr"
git fetch

latest_version=$(git describe --tags $(git rev-list --tags --max-count=1))

if [ "$current_version" != "$latest_version" ]; then
    echo "A new version ($latest_version) is available."
    read -r -p "Do you want to update? (Y/n) " response
    if [[ $latest_version =~ ("alpha"|"beta") ]]; then
        echo "This is a pre-release version."
        read -r -p "Are you sure you want to update? (Y/n) " response
    fi
    if [[ "$response" =~ ^(Y|y|)$ ]]; then
        bash "$kpr/update.sh"
        exit 0
    fi
fi

bash "$kpr/Interface_scripts/menu.sh" restart
exit 0
