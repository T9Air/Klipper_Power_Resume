
#!/bin/bash

clear
kpr="/home/$USER/Klipper_Power_Resume"

# Function to find printer configs
find_printer_configs() {
    local configs=()
    for dir in /home/$USER/printer_*; do
        if [ -d "$dir" ]; then
            configs+=("${dir##*/}")
        fi
    done
    echo "${configs[@]}"
}

# Get available printer configs
printer_configs=($(find_printer_configs))

if [ ${#printer_configs[@]} -eq 0 ]; then
    echo "No printer configurations found!"
    read -r -n1 -s
    "$kpr/Interface_scripts/menu.sh" home
    exit 1
fi

# Display available printers
echo "Available printer configurations:"
for i in "${!printer_configs[@]}"; do
    echo "($((i+1))) ${printer_configs[i]}"
done

read -r -p "Select printer configuration (1-${#printer_configs[@]}): " selection

if [ $selection -lt 1 ] || [ $selection -gt ${#printer_configs[@]} ]; then
    echo "Invalid selection"
    read -r -n1 -s
    "$kpr/Interface_scripts/menu.sh" home
    exit 1
fi

selected_printer="${printer_configs[$((selection-1))]}"

# Store selected printer in config file
echo "$selected_printer" > "$kpr/config/selected_printer"
echo "Selected printer: $selected_printer"
read -r -n1 -s

"$kpr/Interface_scripts/menu.sh" home
exit 0