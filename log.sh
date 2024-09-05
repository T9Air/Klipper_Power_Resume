#!/bin/bash

linenumber=$(sed -n '1p' /home/$USER/Klipper_Power_Resume/log.txt)

linenumber=$((linenumber + 1))

x=$1
y=$2
z=$3

echo $linenumber > /home/$USER/Klipper_Power_Resume/log.txt

movement_command="G0 X${x} Y${y} Z${z}"

echo $movement_command >> /home/$USER/Klipper_Power_Resume/log.txt