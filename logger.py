def increment_number(filename, x_position, y_position, z_position):
  try:
    with open(filename, 'r+') as file:
      number = int(file.read() or 0)
      number += 1
      file.seek(0)
      file.truncate()
      file.write(str(number))
      file.write("\n" + "G0 X" + x_position + " Y" + y_position + " Z" + z_position)
  except FileNotFoundError:
    with open(filename, 'w') as file:
      file.write('1')
      file.write("\n" + "G0 X" + x_position + " Y" + y_position + " Z" + z_position)      

def clear_file(filename):
  with open(filename,'r+') as file:
    file.truncate(0)