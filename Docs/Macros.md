# Klipper Power Resume Macros Documentation

This document explains the macros defined in the configuration files.

## Macros in edit_file.cfg

### ADD_LOGS

- **Description:** Adds logging commands to a G-code file. Is the same as the `add_logs.sh` file in the `Interface_scripts` directory.
- **How it works:**  
  The macro reads parameters for the filename, whether logging should be line-based, and the number of lines to delay before adding log markers.  
  If a valid filename is provided, it runs the shell command `add_logs.sh` with the parameters to update the file. Otherwise, it returns an error message.
  
### CREATE_FILE

- **Description:** Creates a _restarted file if there is a print failure. Is the same as the `make_restarted_file.sh` file in the `Interface_scripts` directory.
- **How it works:**  
  This macro takes parameters such as the filename, temperature settings, and homing preferences.  
  It then invokes the shell command `make_restarted_file.sh` which creates a copy of the original G-code file with the necessary modifications to resume a print.

## Macros in logger.cfg

### UNLOG_FILE

- **Description:** Resets logging by specifying a new log file path.
- **How it works:**  
  Invokes the shell command `unlog.sh` to clear the dynamic log and update the static log file with the current file path.

### LOG_FILE

- **Description:** Records the printer's current position during a print.
- **How it works:**  
  Gathers the current printer movement parameters (position and speed) and uses the shell command `log.sh` to write these details to the dynamic log.

### LOG_FINISHED

- **Description:** Marks the completion of a print.
- **How it works:**  
  Calls the shell command `finished.sh` which writes a "Finished" status to the static log file, indicating that the logging for that print session has ended.
