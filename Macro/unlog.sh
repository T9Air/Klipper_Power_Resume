#!/bin/bash

# Clear log.txt and log file path to it
file_path=$1
echo "$file_path" > /home/$USER/Klipper_Power_Resume/Logs/static_log.txt
echo 0 > /home/$USER/Klipper_Power_Resume/Logs/dynamic_log.txt