#!/bin/bash

# Clear log.txt and log file path to it
file_path=$1
echo "$file_path" > /home/$USER/Klipper_Power_Resume/static_log.txt
echo 0 > /home/$USER/Klipper_Power_Resume/dynamic_log.txt