# Installation

## Prerequisites

- Raspberry Pi running Klipper
- VIRTUAL_SDCARD must be enabled
- SSH access to your Raspberry Pi
- KIAUH installed (for gcode_shell_command extension)

## Automatic Installation (Recommended)

1. SSH into your Raspberry Pi and run:

   ```bash
   cd ~
   git clone https://github.com/T9Air/Klipper_Power_Resume.git
   cd Klipper_Power_Resume
   bash kpr.sh
   ```

2. Select option 1 for automatic installation
3. When prompted, install the gcode_shell_command extension:
   - Run `./kiauh/kiauh.sh`
   - Select option 4 (Advanced)
   - Select option 8 (Install gcode_shell_command)

> IMPORTANT: Run the installation script first to set proper permissions

## Manual Installation

If you prefer manual control:

1. Clone and set permissions:

   ```bash
   cd ~
   git clone https://github.com/T9Air/Klipper_Power_Resume.git
   chown -R $USER:$USER /home/$USER/Klipper_Power_Resume
   chmod -R u+rwx /home/$USER/Klipper_Power_Resume
   ```

2. Install gcode_shell_command via KIAUH as described above

3. Create required directories:

   ```bash
   mkdir -p ~/Klipper_Power_Resume/start_gcode
   ```

4. Add the config files to each printer:
   > Repeat this step for each printer you want Klipper_Power_Resume to work with.
   >
   > In all of the commands, replace `printer_data` with the name of your printer's path if the name is not `printer_data` (such as `printer_1_data`, `printer_ender3v3se_data`, etc.)

   - Copy `kpr-config` to `~/printer_data/config/kpr-config/`:

      ```bash
      mkdir -p ~/printer_data/config/kpr-config
      cp -r ~/Klipper_Power_Resume/kpr-config/* ~/printer_data/config/kpr-config/
      ```

   - Update the config files:
      - Add this to the printer.cfg:

         ```ini
         [include kpr-config/logger.cfg]
         [include kpr-config/shell_command.cfg]
         ```

      - Change `USER` in `logger.cfg` and `edit_file.cfg` to your username.
      - Change `PRINTER_NAME` in `logger.cfg` and `edit_file.cfg` to the printer's directory (i.e. `printer_data`, `printer_ender3v3se_data`, etc.).

5. Verify permissions:

      ```bash
   chmod +x ~/Klipper_Power_Resume/scripts/*
   chmod +x ~/Klipper_Power_Resume/kpr.sh
   ```

## Uninstallation

1. Execute `~/Klipper_Power_Resume/kpr.sh`
2. Select option 0
3. Follow the uninstallation prompts

## Troubleshooting

- If you get permission errors, ensure the installation script was run first
- Verify VIRTUAL_SDCARD is enabled in your configuration
- Check that logger.cfg is properly included in your printer.cfg
