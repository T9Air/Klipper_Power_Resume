#!/bin/bash

printer_path="$(dirname "$(dirname "$(dirname "$(reallink -f "$0")")")")"

filepath="$1"
layer="$2"
num="$3"

# Check if the filename has an extension
if [[ "$filepath" == *.gcode ]]; then
    # If it has an extension, do not add an extension
    filepath="$printer_path/gcodes/$filepath"
else
    # Otherwise add the .gcode extension
    filepath="$printer_path/gcodes/${filepath}.gcode"
fi

# Check if the file exists
if [[ ! -f "$filepath" ]]; then
    echo "File not found: $filepath" # Error message if file not found
    exit 1
fi

touch "$filepath.tmp"

if [ $layer == "yes" ]; then

    # Check if num is less than 5
    if [ $num -lt 5 ]; then
        num=5
    fi

    echo "Skipping ${num} lines..."
    
    i=0
    start_logging=0

    while IFS= read -r line; do
        echo $line >> "$filepath.tmp"
        if [[ $start_logging == 0 && ! "$line" =~ ^G[01] ]]; then
            start_logging=0
        else
            if [ $start_logging == 0 ]; then
                start_logging=1
            fi
            if [ $i == $num ]; then
                i=0
                echo "LOG_FILE" >> "$filepath.tmp"
            else
                i=$(( i + 1 ))
            fi
        fi
    done < "$filepath"
else
    while IFS= read -r line; do
        echo $line >> "$filepath.tmp"

        if [[ $line =~ ^\;LAYER ]]; then
            echo "LOG_FILE" >> "$filepath.tmp"
        fi
    done < "$filepath"
fi

mv "$filepath.tmp" "$filepath"

# Insert UNLOG_FILE at the beginning of the file
sed -i '1i \UNLOG_FILE' "$filepath"

# Add LOG_FINISHED to end of file
echo "LOG_FINISHED" >> "$filepath"

# Exit
echo "File changed!"
exit 0