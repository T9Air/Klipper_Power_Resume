#!/bin/bash

file_path=$(sed -n '1p' /home/$USER/Klipper_Power_Resume/log.txt)

linenumber=$(sed -n '2p' /home/$USER/Klipper_Power_Resume/log.txt)

linenumber=$((linenumber + 1))

x=$1
y=$2
z=$3

speed=$4
speed=$( speed * 60 )

truncate -s 0 /home/$USER/Klipper_Power_Resume/log.txt

echo $file_path > /home/$USER/Klipper_Power_Resume/log.txt

echo $linenumber >> /home/$USER/Klipper_Power_Resume/log.txt

echo $x >> /home/$USER/Klipper_Power_Resume/log.txt
echo $y >> /home/$USER/Klipper_Power_Resume/log.txt
echo $z >> /home/$USER/Klipper_Power_Resume/log.txt