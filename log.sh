#!/bin/bash

linenumber=$(sed -n '1p' /home/$USER/Klipper_Power_Resume/log.txt)

linenumber=$((linenumber + 1))

x=$1
y=$2
z=$3

truncate -s 0 /home/$USER/Klipper_Power_Resume/log.txt

echo $linenumber > /home/$USER/Klipper_Power_Resume/log.txt

echo $x >> /home/$USER/Klipper_Power_Resume/log.txt
echo $y >> /home/$USER/Klipper_Power_Resume/log.txt
echo $z >> /home/$USER/Klipper_Power_Resume/log.txt