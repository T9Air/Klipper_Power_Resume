#!/bin/bash

printer_path = "$(dirname "$(dirname "$(dirname "$(reallink -f "$0")")")")"

# Echo "Finished" to the static_log file
echo "Finished" > "$printer_path/config/kpr-config/static_log.txt"