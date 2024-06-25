from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

everforest_dark = {
    "bg_dim": "#232A2E",
    "bg0": "#2D353B",
    "bg1": "#343F44",
    "bg2": "#3D484D",
    "bg3": "#475258",
    "bg4": "#4F585E",
    "bg5": "#56635f",
    "bg_visual": "#543A48",
    "bg_red": "#514045",
    "bg_green": "#425047",
    "bg_blue": "#3A515D",
    "bg_yellow": "#4D4C43",
    "fg": "#D3C6AA",
    "red": "#E67E80",
    "orange": "#E69875",
    "yellow": "#DBBC7F",
    "green": "#A7C080",
    "aqua": "#83C092",
    "blue": "#7FBBB3",
    "purple": "#D699B6",
    "grey0": "#7A8478",
    "grey1": "#859289",
    "grey2": "#9DA9A0",
    "statusline1": "#A7C080",
    "statusline2": "#D3C6AA",
    "statusline3": "#E67E80"
}

mod = "mod4"
terminal = "kitty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Launch Rofi"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


# Groups and Icons
groups = [
    Group(name="1", label=" Term", screen_affinity = 0), 
    Group(name="2", label="󰈹 Browser", screen_affinity = 0),
    Group(name="3", label="󰎇 Beeps", screen_affinity = 0),
    Group(name="4", label=" Steam", screen_affinity = 0),
    Group(name="5", label="5", screen_affinity = 1),
    Group(name="6", label="6", screen_affinity = 2),
]


# Multiple Monitors ################################################################################################
def go_to_group(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 2:
            qtile.groups_map[name].toscreen()
            return

        if name in '1234':
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        elif name is '5':
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()
        else:
            qtile.focus_screen(2)
            qtile.groups_map[name].toscreen()

    return _inner

for i in groups:
    keys.append(Key([mod], i.name, lazy.function(go_to_group(i.name))))


def go_to_group_and_move_window(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 2:
            qtile.current_window.togroup(name, switch_group=True)
            return

        if name in '1234':
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        elif name is '5':
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()
        else:
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(2)
            qtile.groups_map[name].toscreen()

    return _inner

for i in groups:
    keys.append(Key([mod, "shift"], i.name, lazy.function(go_to_group_and_move_window(i.name))))

##################################################################################################



# ScratchPad
groups.append(ScratchPad('scratchpad', [
    DropDown('term', 'kitty', width = 0.9, height=0.8, x=0.05, y=0.1),
    DropDown('term-file-mgr', 'kitty -e ranger', width = 0.9, height=0.8, x=0.05, y=0.1),
    DropDown('audio', 'pavucontrol', width = 0.9, height=0.8, x=0.05, y=0.1),
    DropDown('music', 'kitty -e spotify_player', width = 0.8, height=0.8, x=0.1, y=0.1),
]))
keys.extend([
    Key([mod], 'x', lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod], 'w', lazy.group['scratchpad'].dropdown_toggle('term-file-mgr')),
    Key([mod], 'm', lazy.group['scratchpad'].dropdown_toggle('music')),
    Key([mod], 'a', lazy.group['scratchpad'].dropdown_toggle('audio')),
])
############

layouts = [
    layout.Spiral(font="Mononoki Nerd Font", margin=8, border_focus=everforest_dark["green"], border_normal=everforest_dark["bg_green"], border_width=2),
    layout.Floating(),
]

widget_defaults = dict(
    font="Mononoki Nerd Font",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font="Mononoki Nerd Font",
                    fontsize=22,

                    visible_groups=['1', '2', '3', '4'],

                    active = everforest_dark["fg"],
                    inactive = everforest_dark["fg"],
                    this_current_screen_border = everforest_dark["bg1"],
                    rounded=False,
                    highlight_method="block",

                    padding_y=4,
                    padding_x=6,
                    margin_y=4,
                    margin_x=0,

                    urgent_alert_method="outline",
                    urgent_border=everforest_dark["red"],
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("| "),
                widget.CheckUpdates(distro="Arch", no_update_string='No updates', execute="sudo xbps-install -Su"),
                widget.Systray(),
                widget.Clock(format=" | %I:%M %p | "),
                #widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.CurrentLayout(),
                widget.TextBox(" | "),
            ],
            34,
            margin = 0,
            background=everforest_dark["bg_dim"],
            border_width = 0,
            border_color = "#000000",
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font="Mononoki Nerd Font",
                    fontsize=22,

                    visible_groups=['5'],

                    active = everforest_dark["fg"],
                    inactive = everforest_dark["fg"],
                    this_current_screen_border = everforest_dark["bg1"],
                    rounded=False,
                    highlight_method="block",

                    padding_y=4,
                    padding_x=6,
                    margin_y=4,
                    margin_x=0,

                    urgent_alert_method="outline",
                    urgent_border=everforest_dark["red"],
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("| "),
                widget.CheckUpdates(distro="Void", no_update_string='No updates', execute="sudo xbps-install -Su"),
                widget.Systray(),
                widget.Clock(format=" | %I:%M %p | "),
                #widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.CurrentLayout(),
                widget.TextBox(" | "),
            ],
            34,
            margin = 0,
            background=everforest_dark["bg_dim"],
            border_width = 0,
            border_color = "#000000",
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font="Mononoki Nerd Font",
                    fontsize=22,

                    visible_groups=['6'],

                    active = everforest_dark["fg"],
                    inactive = everforest_dark["fg"],
                    this_current_screen_border = everforest_dark["bg1"],
                    rounded=False,
                    highlight_method="block",

                    padding_y=4,
                    padding_x=6,
                    margin_y=4,
                    margin_x=0,

                    urgent_alert_method="outline",
                    urgent_border=everforest_dark["red"],
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("| "),
                widget.CheckUpdates(distro="Void", no_update_string='No updates', execute="sudo xbps-install -Su"),
                widget.Systray(),
                widget.Clock(format=" | %I:%M %p | "),
                #widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.CurrentLayout(),
                widget.TextBox(" | "),
            ],
            34,
            margin = 0,
            background=everforest_dark["bg_dim"],
            border_width = 0,
            border_color = "#000000",
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = True
floating_layout = layout.Floating(
    border_focus=everforest_dark["green"],
    border_normal=everforest_dark["bg_green"],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
