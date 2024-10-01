#!/bin/bash

log_path="/home/$USER/Klipper_Power_Resume/dynamic_log.txt"

linenumber=$(sed -n '1p' $log_path)

linenumber=$((linenumber + 1))

x=$1
y=$2
z=$3

truncate -s 0 $log_path

echo $linenumber > $log_path

echo $x >> $log_path
echo $y >> $log_path
echo $z >> $log_path