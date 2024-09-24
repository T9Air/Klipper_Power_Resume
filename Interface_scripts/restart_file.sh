#!/bin/bash

clear

/home/$USER/Klipper_Power_Resume/Interface_scripts/make_restarted_file.sh restart

clear

orig_filepath=$(sed -n '1p' /home/$USER/Klipper_Power_Resume/log.txt)
origfilepath_no_extension="${orig_filepath%.*}"

filename="${origfilepath_no_extension}_restarted.gcode"
filename=$(basename filename)

read -r -p "Do you want to restart the print now? (y/N) " run

echo "Finished" > /home/$USER/Klipper_Power_Resume/log.txt

if [[ $run == [Yy] ]]; then
    echo SDCARD_PRINT_FILE FILENAME=$filename > ~/printer_data/comms/klippy.serial
fi

/home/$USER/Klipper_Power_Resume/interface.sh
exit 0