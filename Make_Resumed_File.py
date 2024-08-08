import os

def delete_lines(file1, file2, gcode):
  """
  Deletes a specified number of lines from a file based on a value in another file,
  adds provided G-code to the beginning of the remaining content,
  and creates a copy with "_restarted" appended to the filename.

  Args:
    file1: The file containing the number of lines to delete.
    file2: The file to delete lines from and add G-code to.
    gcode: The G-code string to add to the beginning of the file.
  """

  try:
    with open(file1, 'r') as f1:
      Logs = f1.readlines()
      lines_to_delete = (int(Logs[0]) * 2) + 1
      gcode_position = str(Logs[1])
      
    with open(file2, 'r') as f2:
      lines = f2.readlines()

    if lines_to_delete > len(lines):
      print("Error: Number of lines to delete exceeds the number of lines in the file.")
      return

    new_lines = lines[lines_to_delete:]

    # Create a new filename with "_restarted" appended
    new_file = os.path.splitext(file2)[0] + "_restarted" + os.path.splitext(file2)[1]

    gcode = gcode + "\n" + gcode_position

    # Combine G-code with remaining lines
    combined_lines = [gcode + "\n"] + new_lines

    with open(new_file, 'w') as f3:
      f3.writelines(combined_lines)

    print(f"Deleted {lines_to_delete} lines from {file2}, added G-code, and created {new_file}")

  except FileNotFoundError:
    print("Error: File not found.")
  except ValueError:
    print("Error: Invalid value in file1.")
  except Exception as e:
    print(f"An error occurred: {e}")

# Example usage:
file1 = "logfile" ###This will be replaced###
file2 = "stopped file" ###This will be replaced###
gcode = "M190 S60\nG28\nM109 S200"
delete_lines(file1, file2, gcode)
