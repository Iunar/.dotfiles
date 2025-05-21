#!/bin/bash

ln -sf ~/.cache/wal/colors.Xresources ~/.Xresources
cat ~/.Xresources ~/.cache/wal/xrdb_extra | xrdb -merge
xdotool key super+ctrl+backslash # xrdb refresh keybind
