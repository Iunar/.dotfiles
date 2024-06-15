
local awful = require("awful")

awful.spawn("xrandr --output DP-0 --mode 2560x1440 --rate 120.00")
awful.spawn("xrandr --output DP-2 --primary --mode 2560x1440 --rate 120.00 --right-of DP-0")
awful.spawn("xrandr --output HDMI-0 --above DP-2")

-- Disable turing off screen
awful.spawn("xset s off")
awful.spawn("xset -dpms")
awful.spawn("xset s noblank")
