def increment_number(filename):
  try:
    with open(filename, 'r+') as file:
      number = int(file.read() or 0)
      number += 1
      file.seek(0)
      file.truncate()
      file.write(str(number))
  except FileNotFoundError:
    with open(filename, 'w') as file:
      file.write('1')

def clear_file(filename):
  with open(filename,'r+') as file:
    file.truncate(0)