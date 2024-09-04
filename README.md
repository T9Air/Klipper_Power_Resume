# Klipper_Power_Resume

## All feedback will be greatly appreciated

### Background

I recently moved from Marlin to Klipper, and what has annoyed me is that with Klipper, there is **NO** way to recover a print if it got canceled mid-print from a power outage, or the printer getting disconnected from the Raspberry Pi. However, I also did not like the resume ability in Marlin so much since it would cause the printer to stop as it logs where it currently is, which can (and does) cause blobs on the print. Since Klipper uses a Raspberry Pi, which is much more powerful than the onboard MCU, it should not have this problem. Therefore, I decided to create a logger for Klipper that is run after ***every*** single line in the file, and then using that log, you can use a Python script to make a new gcode file that ***only*** includes the gcode that was not run.
> NOTE: I HAVE TRIED IT ON A FEW PRINTS, AND THE LOGGING DOES NOT SEEM TO CREATE ANY VISIBLE DEFECTS IN THE PRINT, EVEN WHEN DOING A VASE MODE PRINT, WHICH WAS A BIG PROBLEM WITH MARLIN

### Installation instructions

Installation instructions can be found here: https://github.com/T9Air/Klipper_Power_Resume/blob/main/Docs/Installation.md

### Usage

You can find the instructions on how to use the interface over here: https://github.com/T9Air/Klipper_Power_Resume/blob/main/Docs/Usage.md

## Changelog

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
