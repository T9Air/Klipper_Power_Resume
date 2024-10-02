#!/bin/bash

clear
echo "It seems that I have been having problems during the print where it stops every few lines for a few seconds."
echo "If you have the same problem, I would greatly appreciate if tell me about it."
echo "If your printer does not do that, it would be greatly appreciated if you could inform me about that,
echo " so that I know that it is just my printer, and not a bug with the code.
echo ""
echo "Press any button to continue..."
read -r -n1 -s

bash "/home/$USER/Klipper_Power_Resume/Interface_scripts/menu.sh" restart
exit 0
