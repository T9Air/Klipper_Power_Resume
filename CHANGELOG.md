# Changelog

## [3.5.0] - 2023-10-XX

### Changed

- Updated documentation for clarity ([#65](https://github.com/T9Air/Klipper_Power_Resume/issues/65))

### Added

- Add multi-printer functionality ([#63](https://github.com/T9Air/Klipper_Power_Resume/issues/63), [#67](https://github.com/T9Air/Klipper_Power_Resume/pulls/67))

## [3.4.1] - 2023-XX-XX

### Fixed

- Resolved an issue where the printer failed to resume properly after homing due to incorrect Z-axis positioning ([#58](https://github.com/T9Air/Klipper_Power_Resume/issues/58))

### Changed

- Use SET_GCODE_OFFSET to change the z-position when homing on the print itself, speeding up making a _restarted file

## [3.4.0] - 2023-XX-XX

### Added

- Allow user to choose to log every layer

### Changed

- Start logging only after the first G0 or G1 command when adding the log macros

## [3.3.0] - 2023-XX-XX

### Changed

- Log how many bytes of the gcode file were run, not the line number
- Make the command more explicit than `sed` when adding logs, enabling added features in the future

## [3.2.4] - 2023-XX-XX

### Changed

- Move Logger.cfg and all macro scripts into one directory
- Move the log files into a separate directory

## [3.2.3] - 2023-XX-XX

### Added

- Create a minimum amount of lines that can be skipped: 5.

### Changed

- Log the current speed, reverting back from v3.2.2
- Log the current extrusion value
- Subtract all extrusions by the saved extrusion value when making a _restarted file

## [3.2.2] - 2023-XX-XX

### Changed

- Use two log files
- Ask user for the speed when restarting instead of logging it during the print

### Fixed

- Fix "ome: command not found" error when returning to menu.sh
- Handle filenames without the .gcode extension correctly when the name contains a "."

## [3.2.1] - 2023-XX-XX

### Added

- Log the speed and use it in the _restarted file

### Changed

- Modify the install script to only add `[include logger.cfg]` to printer.cfg if it's not already there
- Change the G-code to move the Z-axis separately from the X and Y axes when moving to the last known position

## [3.2.0] - 2023-XX-XX

### Added

- Allow user to start the print from the interface after creating a _restarted file
- Prompt user to make a _restarted file if the print has been cancelled when the interface first opens

## [3.1.0] - 2023-XX-XX

### Added

- Enable homing on the print itself instead of just in the corner

### Fixed

- Fix bug in [make_restarted_file.sh](https://github.com/T9Air/Klipper_Power_Resume/blob/v3.1.0/Interface_scripts/make_restarted_file.sh) where the script runs even if files do not exist

## [3.0.0] - 2023-XX-XX

### Changed

- **Breaking:** Perform logging and unlogging through shell scripts instead of a Python script
- **Breaking:** Use `gcode_shell_command` instead of the previous [klipper-extras](https://github.com/droans/klipper_extras) repo
- Log each axis on its own line during printing
- Create a new install script
- Update uninstall script

## [2.2.1] - 2023-XX-XX

### Added

- Enable full uninstallation directly from the interface

### Changed

- Ask the user how many lines to skip in `make_restarted_file.sh`

## [2.2.0] - 2023-XX-XX

### Added

- Allow user to create and edit custom start G-code files from the interface

### Changed

- Add checks in `add_logs.sh` and `make_restarted_file.sh` to handle filenames with or without the `.gcode` extension

## [2.1.0] - 2023-XX-XX

### Added

- Allow user to use a custom G-code file as the start G-code

## [2.0.0] - 2023-XX-XX

### Deprecated

- **Breaking:** Deprecate the post-processing script for Cura
- **Breaking:** Deprecate the Python script to make a _restarted file

### Added

- Create the command-line interface with these basic features:
  - Add logging G-code to the G-code files
  - Make a _restarted file by inputting basic information

### Changed

- Modify the install script from v1.1.0 with minor changes

## [1.1.0] - 2023-XX-XX

### Added

- Add an install script

## [1.0.0] - 2023-XX-XX

_Initial release._

[3.5.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.5.0
[3.4.1]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.4.1
[3.4.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.4.0
[3.3.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.3.0
[3.2.4]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.2.4
[3.2.3]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.2.3
[3.2.2]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.2.2
[3.2.1]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.2.1
[3.2.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.2.0
[3.1.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.1.0
[3.0.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v3.0.0
[2.2.1]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v2.2.1
[2.2.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v2.2.0
[2.1.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v2.1.0
[2.0.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v2.0.0
[1.1.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v1.1.0
[1.0.0]: https://github.com/T9Air/Klipper_Power_Resume/releases/tag/v1.0.0
