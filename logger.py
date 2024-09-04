import subprocess

def log(filename, x_position, y_position, z_position):
    """
    This function logs the current line of the gcode, and the current position of the printer.

   Args:
        filename (str): The filepath of the log.
        x_position (float): The X position of the printer.
        y_position (float): The Y position of the printer.
        z_position (float): The Z position of the printer.
    """
#    try:
#        # Open the file for reading and writing
#        with open(filename, 'r+') as file:
#            # Read the current line number from the file
#           number = int(file.readline())
#            # Increment the line number
#            number += 1
#
#            # Convert position to strings for logging
#            x = str(x_position)
#            y = str(y_position)
#            z = str(z_position)
#
#            # Go to the beginning of the file and truncate any existing content
#            file.seek(0)
#            file.truncate()
#
#            # Write the updated line number back to the file
#            file.write(str(number))
#
#            # Log G0 movement command with current printer positions
#            # The G0 command is created over here in order to make it easier to create the restarted file
#            movement_command = "G0 X" + x + " Y" + y + " Z" + z
#
#            # Write the G0 command to a new line in the file
#            file.write("\n" + movement_command)
#
#    except FileNotFoundError:
#        # If the file doesn't exist, create it and write initial values
#        with open(filename, 'w') as file:
#            # Write '1' as the initial line number
#            file.write('1')
#
#            # Log and write the G0 command
#            movement_command = "G0 X" + x + " Y" + y + " Z" + z
#            file.write("\n" + movement_command)
#
    subprocess.run(["bash", "/home/USER/Klipper_Power_Resume/log.sh", x_position, y_position, z_position])

def clear_log(filename):
    """
    This function clears the log file and writes '0' to the first line.

    Args:
        filename (str): The filepathof the log.
    """
#    with open(filename, 'w') as file:
#        # Write '0' to the file, effectively resetting the line count
#        file.write('0')
    subprocess.run(["bash", "/home/USER/Klipper_Power_Resume/unlog.sh"])