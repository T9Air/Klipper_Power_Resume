#!/bin/bash

clear

echo "Klipper_Power_Resume v3.4.2"
echo " "
echo "Feedback would be greatly appreciated"
echo " "
echo "Press enter to continue..."

read -r -n1 -s

clear

bash "/home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh" restart
exit 0
