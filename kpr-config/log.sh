#!/bin/bash

printer_path = "$(dirname "$(dirname "$(dirname "$(reallink -f "$0")")")")"

log_path="$printer_path/config/kpr-config/dynamic_log.txt"

byte=$1
x=$2
y=$3
z=$4
e=$5
speed=$6

truncate -s 0 $log_path

echo $byte > $log_path
echo $x >> $log_path
echo $y >> $log_path
echo $z >> $log_path
echo $e >> $log_path
echo $speed >> $log_path
