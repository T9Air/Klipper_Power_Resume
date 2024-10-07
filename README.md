# Klipper_Power_Resume

[![CodeFactor](https://www.codefactor.io/repository/github/t9air/klipper_power_resume/badge)](https://www.codefactor.io/repository/github/t9air/klipper_power_resume)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/09208fa8791d47e1a94103b238895fa5)](https://app.codacy.com/gh/T9Air/Klipper_Power_Resume/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
![Static Badge](https://img.shields.io/badge/version-3.2.3-blue)

## All feedback/ideas would be greatly appreciated

### Installation instructions

Installation instructions can be found here: <https://github.com/T9Air/Klipper_Power_Resume/blob/main/Docs/Installation.md>

> NOTE: You must have VIRTUAL_SDCARD enabled

### Usage

You can find the instructions on how to use the interface over here: <https://github.com/T9Air/Klipper_Power_Resume/blob/main/Docs/Usage.md>

## Changelog

### version 3.2.3

* Created a minimum amount of lines that can be skipped: 5
  * Avoids [#53](https://github.com/T9Air/Klipper_Power_Resume/issues/53)
* Log the current speed, revert back from v3.2.2
* Log the current extrusion value
* Subtract all extrusions by the saved extrusion value when making a _restarted file

### version 3.2.2

* 2 log files are used
* When restarting, ask User for the speed, instead of logging the speed during the print
* Fixed 2 errors:
  * Get "ome: command not found" when going back to menu.sh
  * When giving a file without the .gcode extension, but the file has a "." in the name, it does not add .gcode to the end of the extension, and therefore can not find the file

### version 3.2.1

* The speed is logged, and used in the _restarted file
* In the install script, only add [include logger.cfg] to printer.cfg if it is not already there
* The gcode to move to the last known position has been changed to have the z axis moved separately than the x & y axes

### version 3.2.0

* After creating a _restarted file, user can start the print from the interface
* When interface first opened, if the print has been cancelled, the interface asks whether to make a _restarted file or not

### version 3.1.0

* User can now home on the print itself, instead of just in the corner
* Fixed bug in [make_restarted_file.sh](https://github.com/T9Air/Klipper_Power_Resume/blob/v3.1.0/Interface_scripts/make_restarted_file.sh) where if files do not exist, the script will still run

### version 3.0.0

* Logging and unlogging done through shell scripts instead of a Python script
* Use gcode_shell_command instead of the previous [klipper-extras](https://github.com/droans/klipper_extras) repo that was in use
* When logging during printing, each axis is logged on its own line
* Made a new install script
* Updated uninstall script

### version 2.2.1

* Can fully uninstall directly from the interface
* Ask the user how many lines skipped in make_restarted_file.sh

### version 2.2.0

* User can create and edit custom start gcode files from the interface
* Added checks to add_logs.sh and make_restarted_file.sh to see if the user added .gcode in the filename, and act accordingly

### version 2.1.0

* Allow user to use a custom gcode file as the start gcode

### version 2.0.0

* Deprecated the post-processing script for Cura
* Deprecated the Python script to make a _restarted file
* Created the command line interface with these basic features
  * Add the logging gcode to the gcode files
  * Make a _restarted file just by inputting basic information
  * Used the install script from v1.1.0 with minor changes
  * An uninstall script

### version 1.1.0

* Added an install script
* Still no interface for other features, and creating a _restarted file is still complicated

### version 1.0.0

* All basic functionality is working, without an interface
* No scripts for installation
* Creating a _restarted file is complicated
