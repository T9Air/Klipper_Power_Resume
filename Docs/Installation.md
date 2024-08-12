# Installation

#### Using the interface script

1. Run the following commands on your Raspberry Pi
   ```
   cd ~
   git clone https://github.com/T9Air/Klipper_Power_Resume.git
   cd Klipper_Power_Resume
   bash interface.sh
   ```
2. Press 1 to run the installation script

> NOTE: YOU MUST RUN THE INSTALLATION SCRIPT FIRST, OTHERWISE YOU WILL RECIEVE AN ERROR TELLING YOU THAT YOU DO NOT HAVE EXECUTE PERMISSIONS

3. Follow the instructions in the install script. The instructions for installing the extended_macros repo are [here](https://github.com/droans/klipper_extras/blob/main/extended_macro/readme.md).

#### Manually installing 

1. Run the following commands on your Raspberry Pi
   ```
   cd ~
   git clone https://github.com/T9Air/Klipper_Power_Resume.git
   ```
2. Install the extended_macros repo. Instructions can be found [here](https://github.com/droans/klipper_extras/blob/main/extended_macro/readme.md).
3. In all the files, change "$USER" to your username
4. Move logger.cfg to the path where all your config files are. (Usually ~/printer_data/config)
5. In your printer.cfg add ```[include logger.cfg]```