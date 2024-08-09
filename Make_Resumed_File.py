import os

# Delete lines from a g-code file based on information in the log, add some start g-code, and creates a new g-code file
def delete_lines(file1, file2, gcode):
    # Try to open and process the files, catching potential errors
    try:
        # Open the log to get the data
        with open(file1, 'r') as f1:
            # Read all lines from the lag
            Logs = f1.readlines()
            # Calculate the number of lines to delete based on the first line of the log
            lines_to_delete = (int(Logs[0]) * 2)
            # Get the printer position from the second line of the log
            gcode_position = str(Logs[1])

        # Open the g-code file
        with open(file2, 'r') as f2:
            # Read all lines from the g-code file
            lines = f2.readlines()

        # Check if the number of lines to delete is more than the total number of lines
        if lines_to_delete > len(lines):
            # Print an error message if there are too many lines to delete
            print("Error: Number of lines to delete exceeds the number of lines in the file.")
            return  # Exit the function

        # Get the remaining lines after deleting the specified number of lines
        new_lines = lines[lines_to_delete:]

        # Create a new file name with a "_restarted" suffix
        new_file = os.path.splitext(file2)[0] + "_restarted" + os.path.splitext(file2)[1]

        # Add the move to last printer position to the start g-code
        gcode = gcode + "\n" + gcode_position

        # Combine the start g-code and remaining lines into a new list
        combined_lines = [gcode + "\n"] + new_lines

        # Write the combined lines to the new g-code file
        with open(new_file, 'w') as f3:
            f3.writelines(combined_lines)

        # Print a success message indicating the number of deleted lines, original file, and new file
        print(f"Deleted {lines_to_delete} lines from {file2}, added G-code, and created {new_file}")

    # Handle potential file not found errors
    except FileNotFoundError:
        print("Error: File not found.")
    # Handle potential value errors (e.g., invalid number in file1)
    except ValueError:
        print("Error: Invalid value in file1.")
    # Handle any other potential errors
    except Exception as e:
        print(f"An error occurred: {e}")

# Specify the log and g-code file paths and start g-code
file1 = "/home/$USER/Klipper_Power_Resume/log.txt"
file2 = "stopped file"
gcode = "M190 S60\nG28\nM109 S200"

# Call the function to delete lines, add start g-code, and create a new g-code file
delete_lines(file1, file2, gcode)

