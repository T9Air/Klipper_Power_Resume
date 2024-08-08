# This is the post-processing script for Cura

from ..Script import Script

class AddLoggingGcode(Script):
    def __init__(self):
        super().__init__()

    def getSettingDataString(self):
        return """{
            "name": "Add logging Gcode",
            "key": "AddLoggingGcode",
            "metadata": {},
            "version": 2,
            "settings": {}
        }"""

    def execute(self, data):
        # Initialize a counter to keep track of the first line of the file
        count = 0
        # Create an empty list to store the new G-code lines with added logging commands
        new_data = []

        # Process each line of the file
        for gcode in data:
            # Split the file into individual lines
            lines = gcode.split("\n")

            # Process each line
            for line in lines:
                # Check if it's the first line of the file
                if count == 0:
                    # Add "UNLOG_FILE" and "LOG_FILE" after the first line
                    new_data.append(line + "\n" + "UNLOG_FILE" + "\n" + "LOG_FILE" + "\n")
                else:
                    # Add "LOG_FILE" after the subsequent lines
                    new_data.append(line + "\n" + "LOG_FILE" + "\n")
                # Set the counter to 1 to indicate it's no longer the first line
                count = 1

        # Return the modified G-code data with added logging & unlogging commands
        return new_data