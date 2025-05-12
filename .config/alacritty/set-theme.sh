#!/bin/bash

if [ "$1" == "openbox" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/openbox/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/openbox/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
elif [ "$1" == "generic" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/generic/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/generic/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
elif [ "$1" == "dwm" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/dwm/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/dwm/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
elif [ "$1" == "catppuccin_mocha" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/catppuccin_mocha/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/catppuccin_mocha/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
elif [ "$1" == "autumn" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/autumn/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/autumn/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
elif [ "$1" == "softlight" ]; then
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/soft_light/alacritty.toml $XDG_CONFIG_HOME/alacritty/alacritty.toml
	ln -sf $XDG_CONFIG_HOME/alacritty/presets/soft_light/theme.toml $XDG_CONFIG_HOME/alacritty/theme.toml
else
	echo "Not a preset"
fi
