#!/bin/bash

printer_path = "$(dirname "$(dirname "$(dirname "$(reallink -f "$0")")")")"

# Clear log.txt and log file path to it
file_path=$1
echo "$file_path" > $printer_path/config/kpr-config/static_log.txt
echo 0 > $printer_path/config/kpr-config/dynamic_log.txt