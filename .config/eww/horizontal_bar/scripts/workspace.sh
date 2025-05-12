#!/bin/bash

workspaces() {

	inactive_icon=" ";
	active_icon=" ";

	wsc1="inactive_workspace"
	wsc2="inactive_workspace"
	wsc3="inactive_workspace"
	wsc4="inactive_workspace"
	wsc5="inactive_workspace"
	wsc6="inactive_workspace"

	wsi1="$inactive_icon"
	wsi2="$inactive_icon"
	wsi3="$inactive_icon"
	wsi4="$inactive_icon"
	wsi5="$inactive_icon"
	wsi6="$inactive_icon"

	if [[ ${1:0:9} == "workspace" ]]; then 
		active_workspace=${event: -1}
	fi

	if [ "$active_workspace" == "1" ]; then
		wsc1="active_workspace"
		wsi1="$active_icon"
	elif [ "$active_workspace" == "2" ]; then
		wsc2="active_workspace"
		wsi2="$active_icon"
	elif [ "$active_workspace" == "3" ]; then
		wsc3="active_workspace"
		wsi3="$active_icon"
	elif [ "$active_workspace" == "4" ]; then
		wsc4="active_workspace"
		wsi4="$active_icon"
	elif [ "$active_workspace" == "5" ]; then
		wsc5="active_workspace"
		wsi5="$active_icon"
	elif [ "$active_workspace" == "6" ]; then
		wsc6="active_workspace"
		wsi6="$active_icon"
	fi
	
	echo "(box :class \"workspaces\" :orientation \"v\" (button :onclick \"hyprctl dispatch workspace 1\" :class \"$wsc1\" \"$wsi1\") (button :onclick \"hyprctl dispatch workspace 2\" :class \"$wsc2\" \"$wsi2\") (button :onclick \"hyprctl dispatch workspace 3\" :class \"$wsc3\" \"$wsi3\") (button :onclick \"hyprctl dispatch workspace 4\" :class \"$wsc4\" \"$wsi4\") (button :onclick \"hyprctl dispatch workspace 5\" :class \"$wsc5\" \"$wsi5\") (button :onclick \"hyprctl dispatch workspace 6\" :class \"$wsc6\" \"$wsi6\"))"
}

# Connect to hyprland socket and read events
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r event; do
	workspaces $event
done

# echo "(box\
	# :orientation \"v\"\
	# (button :onclick \"hyprctl dispatch workspace 1\" :class \"$wsc1\" \"1\")\
	# (button :onclick \"hyprctl dispatch workspace 2\" :class \"$wsc2\" \"2\")\
	# (button :onclick \"hyprctl dispatch workspace 3\" :class \"$wsc3\" \"3\")\
	# (button :onclick \"hyprctl dispatch workspace 4\" :class \"$wsc4\" \"4\")\
	# (button :onclick \"hyprctl dispatch workspace 5\" :class \"$wsc5\" \"5\")\
	# (button :onclick \"hyprctl dispatch workspace 6\" :class \"$wsc6\" \"6\"))"
