#!/bin/bash

log_path="/home/$USER/Klipper_Power_Resume/log.txt"

file_path=$(sed -n '1p' $log_path)

linenumber=$(sed -n '2p' $log_path)

linenumber=$((linenumber + 1))

x=$1
y=$2
z=$3

speed=$4
speed=$( speed * 60 )

truncate -s 0 $log_path

echo $file_path > $log_path

echo $linenumber >> $log_path

echo $x >> $log_path
echo $y >> $log_path
echo $z >> $log_path
echo $speed >> $log_path