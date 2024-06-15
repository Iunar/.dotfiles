
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- TODO: change the colors to not be magic

local icon_path = "/usr/share/icons/Papirus-Dark/128x128/apps/"

local function create_button(icon, command, size, radius, margins)
	local app = wibox.widget {
		{
			{
				widget = wibox.widget.imagebox,
				image = icon_path .. icon,
				resize = true,
				opacity = 1,
			},
			margins = dpi(margins),
			widget = wibox.container.margin
		},
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, radius)
		end,
		widget = wibox.container.background,
		forced_height = dpi(size),
		forced_width = dpi(size),
	}

	--{{{ Clicking action and effect
	app:connect_signal("button::press", function(c)
		c:set_bg("#181926")
		awful.spawn.with_shell(command)
	end)
	app:connect_signal("button::release", function(c)
		c:set_bg("#1e2030")
	end)
	--}}}

	--{{{ Hover effects
	app:connect_signal("mouse::enter", function(c) c:set_bg("#24273a") end)
	app:connect_signal("mouse::leave", function(c) c:set_bg("#1e2030") end)
	--}}}

	return app
end

-- Return
local _M = {
	-- (icon, command, size, radius, margins)
	firefox = create_button("firefox.svg", "firefox", 64, 8, 4),
	kitty = create_button("kitty.svg", "kitty", 64, 8, 4),
	thunar = create_button("Thunar.svg", "thunar", 64, 8, 4),
}

function _M:get()
	return _M
end

-- Metatable
return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
