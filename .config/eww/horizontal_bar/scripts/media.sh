#!/bin/bash

# No player could handle this command

title=$(playerctl metadata | grep -Po '(?<=:title((\s){,15})).*' | sed 's/^[ \t]*//g')
artist=$(playerctl metadata | grep -Po '(?<=:artist((\s){,15})).*' | sed 's/^[ \t]*//g')

if [ "$artist" != "" ] && [ "$title" != "" ]; then
	echo "$artist - $title"
else
	echo "󰝛"
fi
