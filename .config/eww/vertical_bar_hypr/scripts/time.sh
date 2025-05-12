#!/bin/bash

if [ "$1" == "H" ]; then
	echo "$(date +%H)"
elif [ "$1" == "M"  ]; then
	echo "$(date +%M)"
elif [ "$1" == "S"  ]; then
	echo "$(date +%S)"
else
	echo "-1"
fi
