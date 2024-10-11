#!/bin/bash

echo "Klipper_Power_Resume v3.4.1"
echo " "
echo "Feedback would be greatly appreciated"
echo " "
read -r -n1 -s "Press enter to continue..."
clear

bash "/home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh" restart
exit 0
