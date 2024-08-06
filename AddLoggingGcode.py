#This is the post-processing script for Cura

from ..Script import Script

class AddLoggingGcode(Script):
    def _init_(self):
        super()._init_()

    def getSettingDataString(self):
        return """{
            "name": "Add logging Gcode",
            "key": "AddLoggingGcode",
            "metadata": {},
            "version": 2,
            "settings": {}
        }"""

    def execute(self, data):
        count = 0
        new_data = []
        for layer in data:
            lines = layer.split("\n")
            for line in lines:
                if count == 0:
                    new_data.append(line + "\n" + "UNLOG_FILE" + "\n" + "LOG_FILE" + "\n")
                else:
                    new_data.append(line + "\n" + "LOG_FILE" + "\n")
                count = 1
        return new_data
