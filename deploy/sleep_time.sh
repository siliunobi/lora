#!/bin/bash

current_epoch=$(date +%s.%N)
#target_epoch=$(date -d "17:50:00.12345" +%s.%N)
target_epoch=$(date -d "$1" +%s.%N)

sleep_seconds=$(echo "$target_epoch - $current_epoch"|bc)
echo $sleep_seconds

#if [[ $(echo "$sleep_seconds" | bc) -ne $(echo "0" | bc) ]]
if [[ $(bc -l <<< "$sleep_seconds" > 0) -eq 0 ]]
then
	echo "Sleep is fine"
	echo $sleep_seconds
	sleep $sleep_seconds
	exit 0
else
	echo "Sleep time is negative"
	exit 1
fi
