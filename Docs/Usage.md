# Usage

## Selecting Printer

> Whenever you want to choose which printer to use, if you have multiple printers, or when using the program for the first time, do this

1. Run the following command on your Raspberry Pi ```~/Klipper_Power_Resume/kpr.sh```
2. Press 7 to run the select printer script

## Adding Log Macro to a File

> You need to do this so that the positions of the printer, etc. can be logged to a file.
> The program will use that log to create a new file after a reset.

1. Run the following command on your Raspberry Pi ```~/Klipper_Power_Resume/kpr.sh```
2. Press 2 to run the add_logs script
3. Follow the instructions in the script to add the macros

### Create a _restarted file after a reset

> To do this, the gcode file that got canceled must have the log macros added to it (see previous instruction)
> It will create a file that contains all of the gcode after the print was canceled, with instructions on how to start based on your input to the script
> The file will be named "(original_name)_restarted.gcode"

1. Run the following command on your Raspberry Pi ```~/Klipper_Power_Resume/kpr.sh```
2. Press 3 to run the make_restarted_file script
3. Follow the instructions in the script

## Creating Custom Start Gcode Files

> Note: You can also import files using an editor such as WinSCP.
> Make sure to put the files in the start_gcode folder

1. Run the following command on your Raspberry Pi ```~/Klipper_Power_Resume/kpr.sh```
2. Press 4 to run the create_gcode script
3. Follow the instructions in the script

### Editing Custom Start Gcode Files

1. Run the following command on your Raspberry Pi ```~/Klipper_Power_Resume/kpr.sh```
2. Press 5 to run the edit_gcode script
3. Follow the instructions in the script
