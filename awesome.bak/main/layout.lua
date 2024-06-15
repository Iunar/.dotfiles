local awful = require("awful")

local _M = {}

function _M:get()

	local layouts = {
	    awful.layout.suit.spiral,  -- 1 -> 8
	    awful.layout.suit.spiral,
	    awful.layout.suit.spiral,
	    awful.layout.suit.spiral,
	    awful.layout.suit.floating,
	    awful.layout.suit.floating,
	    awful.layout.suit.floating,
	    awful.layout.suit.floating
	}

	return layouts
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
