#!/bin/bash

linenumber=$(sed -n '1p' /home/$USER/Klipper_Power_Resume/log.txt)

linenumber=$((linenumber + 1))

x=$1
y=$2
z=$3