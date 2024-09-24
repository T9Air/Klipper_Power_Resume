#!/bin/bash

# Truncate file to clear it
echo 0 > /home/$USER/Klipper_Power_Resume/log.txt

# Log file path
file_path=$1
echo "$file_path" >> /home/$USER/Klipper_Power_Resume/log.txt