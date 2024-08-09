# Installation
1. Install the extended_macros library. Instructions can be found here: https://github.com/droans/klipper_extras/tree/main/extended_macro
2. Run the following commands on your RPI
   ```
   cd
   git clone https://github.com/T9Air/Klipper_Power_Resume.git
   ```
3. In all the files, change "$USER" to your username
4. Move logger.cfg to the path where all your config files are. (Usually ~/printer_data/config)
5. In your printer.cfg add ```[include logger.cfg]```
> NOTE: Currently you must be using Cura for this to work, that will be changed in the future
6. On your PC, download the AddLoggingGcode.py script, and move it to C:\Users\(Your Username)\AppData\Roaming\cura\(most recent version of cura)\scripts

# Setup
### Cura setup
1. Add the "Add Logging Gcode" post-processing script to the **end** of the list

### Resumed file setup
> You will only need to do this if a file does get canceled mid-print
> This process is manual right now, it will be improved in the future
1. Delete all 1st lines in the g-code file until the line that says "UNLOG_FILE"
2. In the Make_Resumed_File.py file, at the bottom of the file, change the file2 variable to the path to the file that got messed up
3. Run the following commands on your RPI
   ```
   cd Klipper_Power_Resume
   python3 ./Make_Resumed_File.py
   ```
