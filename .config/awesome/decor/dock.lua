
local wibox = require("wibox")
local gears = require("gears")

function Create_dock(screen, w, h, radius)
	local dock = wibox {
		screen = screen, -- primary display
		type = "dock",
		ontop = false,
		visible = true,

		width = w,
		height = h,

		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, radius)
		end,
	}

	return dock
end
