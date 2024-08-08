def increment_number(filename, x_position, y_position, z_position):
  try:
    with open(filename, 'r+') as file:
      number = int(file.readline())
      number += 1
      x = str(x_position)
      y = str(y_position)
      z = str(z_position)
      file.seek(0)
      file.truncate()
      file.write(str(number))
      file.write("\n" + "G0 X" + x + " Y" + y + " Z" + z)
  except FileNotFoundError:
    with open(filename, 'w') as file:
      file.write('1')
      file.write("\n" + "G0 X" + x + " Y" + y + " Z" + z)      

def clear_file(filename):
  with open(filename,'w') as file:
    file.write('0')