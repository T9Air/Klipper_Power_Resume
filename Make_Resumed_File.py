import os

def delete_lines(file1, file2, gcode):
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

    new_file = os.path.splitext(file2)[0] + "_restarted" + os.path.splitext(file2)[1]

    gcode = gcode + "\n" + gcode_position

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

file1 = "/home/$USER/Klipper_Power_Resume/log.txt"
file2 = "stopped file"
gcode = "M190 S60\nG28\nM109 S200"
delete_lines(file1, file2, gcode)
