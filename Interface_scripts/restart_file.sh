#!/bin/bash

clear

/home/$USER/Klipper_Power_Resume/Interface_scripts/make_restarted_file.sh restart

clear

read -r -p "Do you want to restart the print now? (y/N) " run

if [ $run == [Yy] ]; then
fi

/home/$USER/Klipper_Power_Resume/interface.sh
exit 0