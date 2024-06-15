
-- Standard awesome library
local awful = require("awful")

-- {{{ Menu
-- Create a launcher widget and a main menu

local _M = {}
local M = {}

M.session = {
   { "restart", "reboot" },
   { "shutdown", "shutdown -h now"},
}
M.awesome = {
   { "restart awesome", awesome.restart },
   { "quit awesome", function() awesome.quit() end },
}


function _M:get()
	local menu_final = {
		{ "awesome", M.awesome },
		{ "session", M.session },
	}
	return menu_final
end


-- When you require this module, it will return an object that when called will return the output of the _M:get() function
return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
