# Usage

## Selecting Your Printer

1. Run `~/Klipper_Power_Resume/kpr.sh` on your Raspberry Pi
2. Select option 7
3. Follow the on-screen prompts to select your printer

## Adding Required Log Macros

The program needs to track printer positions and states through log macros.

1. Run `~/Klipper_Power_Resume/kpr.sh`
2. Select option 2
3. Follow the prompts to add the necessary macros to your g-code file

## Resuming After a Power Loss

To create a recovery file after a print was interrupted:

1. Run `~/Klipper_Power_Resume/kpr.sh`
2. Select option 3
3. Follow the prompts to create a "(original_name)_restarted.gcode" file

> Note: The original gcode file must have had logging macros added for this to work

## Custom Start G-Code Management

### Creating Custom Start Files

1. Run `~/Klipper_Power_Resume/kpr.sh`
2. Select option 4
3. Follow the prompts

> Alternative: Use WinSCP to manually place files in the start_gcode folder

### Editing Existing Start Files

1. Run `~/Klipper_Power_Resume/kpr.sh`
2. Select option 5
3. Follow the prompts

> Note: Ensure you have proper file permissions before running any commands (this should be set up during the installation process)
