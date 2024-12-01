#!/bin/bash

# Clear log.txt and log file path to it
file_path=$1
echo "$file_path" > /home/$USER/printer_data/config/kpr-config/static_log.txt
echo 0 > /home/$USER/printer_data/config/kpr-config/dynamic_log.txt