local wibox = require("wibox")

--{{{ Firefox Button and Functionality
local firefox_button = wibox.widget {
	{
		{
			widget = wibox.widget.imagebox,
			image = "/usr/share/icons/Papirus/64x64/apps/firefox.svg",
			resize = true,
			opacity = 1,
		},
		margins = dpi(4),
		widget = wibox.container.margin
	},
	--bg = color.background_dark,
	shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 8) end,
	widget = wibox.container.background,
	forced_height = dpi(64),
	forced_width = dpi(64),
}

firefox_button:connect_signal("button::press", function(c)
	c:set_bg("#181926")
	awful.spawn.with_shell("firefox")
end)
firefox_button:connect_signal("button::release", function(c)
	c:set_bg("#1e2030")
end)

firefox_button:connect_signal("mouse::enter", function(c) c:set_bg("#24273a") end)
firefox_button:connect_signal("mouse::leave", function(c) c:set_bg("#1e2030") end)
--}}}
