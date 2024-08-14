# Klipper_Power_Resume

## All feedback will be greatly appreciated

### Background

I recently moved from Marlin to Klipper, and what has annoyed me is that with Klipper, there is **NO** way to recover a print if it got canceled mid-print from a power outage, or the printer getting disconnected from the Raspberry Pi. However, I also did not like the resume ability in Marlin so much since it would cause the printer to stop as it logs where it currently is, which can (and does) cause blobs on the print. Since Klipper uses a Raspberry Pi, which is much more powerful than the onboard MCU, it should not have this problem. Therefore, I decided to create a logger for Klipper that is run after ***every*** single line in the file, and then using that log, you can use a Python script to make a new gcode file that ***only*** includes the gcode that was not run.
> NOTE: I HAVE TRIED IT ON A FEW PRINTS, AND THE LOGGING DOES NOT SEEM TO CREATE ANY VISIBLE DEFECTS IN THE PRINT, EVEN WHEN DOING A VASE MODE PRINT, WHICH WAS A BIG PROBLEM WITH MARLIN

### Installation instructions

Installation instructions can be found here: https://github.com/T9Air/Klipper_Power_Resume/blob/main/Docs/Installation.md

### Usage

You can find the instructions on how to use the interface over here: https://github.com/T9Air/Klipper_Power_Resume/blob/main/Docs/Usage.md

### Currently working interface features

| Feature                                      | Status  |
| -------------------------------------------- | ------- |
| Installing                                   | &check; |
| Uninstalling                                 | &check; |
| Add log macro                                | &check; |
| Can create _restarted file                   | &check; |
| Specify what temps to print at               | &check; |
| Choose how many lines to skip between logs   | &check; |
| Use custom start gcode for _restarted file   | &check; |
| Create custom start gcode in interface       | &check; |
| Edit custom start gcode in interface         | &check; |
| Specify which custom start gcode to use      | &check; |
| Choose to only log at each layer             | &cross; |
