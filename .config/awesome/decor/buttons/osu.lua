local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local osu_button = wibox.widget {
	{
		{
			{
				text = "osu!",
				widget = wibox.widget.textbox
			},
			left = 8,
			right = 8,
			top = 4,
			bottom = 4,
			widget = wibox.container.margin,
		},
		-- border_width doesnt work
		id = "osu_button_background",
		shape_border_width = dpi(3),
		visible = true,
		border_color = "#f38ba8",
		shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 4) end,
		widget = wibox.container.background,
	},
	widget = wibox.container.margin,
	top = 4,
	bottom = 4,
	left = 8,
	right = 8
}
-- 
osu_button:connect_signal("mouse::enter", function(c)
	c:get_children_by_id("osu_button_background")[1]:set_bg("#cad3f5")
	c:get_children_by_id("osu_button_background")[1]:set_fg("#181926")
end)
osu_button:connect_signal("mouse::leave", function(c)
	c:get_children_by_id("osu_button_background")[1]:set_bg("#181926")
	c:get_children_by_id("osu_button_background")[1]:set_fg("#cad3f5")
end)

osu_button:connect_signal("button::press", function(c, _, _, button)
	if button == 1 then
		awful.spawn.with_shell("/home/tyler/Documents/osu.AppImage")
	end
end)
