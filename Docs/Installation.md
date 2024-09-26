# Installation

## Using the interface script

1. Run the following commands on your Raspberry Pi

   ```bash
   cd ~
   git clone https://github.com/T9Air/Klipper_Power_Resume.git
   cd Klipper_Power_Resume
   bash kpr.sh
   ```

2. Press 1 to run the installation script

3. Follow the instructions in the install script. To install the gcode_shell_command extension, go to kiauh, `./kiauh/kiauh.sh`, press option 4 (advanced), and then option 8.

> NOTE: YOU MUST RUN THE INSTALLATION SCRIPT FIRST, OTHERWISE YOU WILL RECEIVE AN ERROR TELLING YOU THAT YOU DO NOT HAVE EXECUTE PERMISSIONS
> NOTE: You must have VIRTUAL_SDCARD enabled

## Manually installing

1. Run the following commands on your Raspberry Pi

   ```bash
   cd ~
   git clone https://github.com/T9Air/Klipper_Power_Resume.git
   chmod -R u+rwx /home/$USER/Klipper_Power_Resume
   ```

2. Install the gcode_shell_command extension. To install, go to kiauh, `./kiauh/kiauh.sh`, press option 4 (advanced), and then option 8.
3. In all the files, change "USER" to your username
4. Move logger.cfg to the path where all your config files are. (Usually ~/printer_data/config)
5. In your printer.cfg add ```[include logger.cfg]```

## Uninstalling

1. Run the following command on your Raspberry Pi `~/Klipper_Power_Resume/kpr.sh`

2. Press 0 to run the uninstall script

3. Follow the instructions in the script
