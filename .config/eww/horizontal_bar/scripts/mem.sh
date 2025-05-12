#!/bin/bash

if [ "$1" == "total" ]; then
	echo $(cat /proc/meminfo | grep -Po '(?<=(MemTotal:(\s){,9}))[0-9]+(?=\skB)')
elif [ "$1" == "free" ]; then 
	echo $(cat /proc/meminfo | grep -Po '(?<=(MemFree:(\s){,9}))[0-9]+(?=\skB)')
elif [ "$1" == "available" ]; then 
	echo $(cat /proc/meminfo | grep -Po '(?<=(MemAvailable:(\s){,9}))[0-9]+(?=\skB)')
else
	echo "-1"
fi
# echo $(cat /proc/meminfo | grep -Po -m 1 '(?<=((MemTotal|MemFree|MemAvailable):(\s){,9}))[0-9]+(?=\skB)')

