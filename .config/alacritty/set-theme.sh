#!/bin/bash

if [ "$1" == "openbox" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/openbox/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/openbox/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
elif [ "$1" == "dwm" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/dwm/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/dwm/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
else
	echo "Not a preset"
fi
