--[[
+--------------------------------------------------------------------+
|                                                                    |
|   __ ___      _____  ___  ___  _ __ ___   _____      ___ __ ___    |
|  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \ \ /\ / / '_ ` _ \   |
| | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/\ V  V /| | | | | |  |
|  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___| \_/\_/ |_| |_| |_|  |
|                                                                    |
+--------------------------------------------------------------------+
NOTE: this is a modularized version of the default config and
the order of the require statements MATTERS
]]--

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Import error handling module
require("main.error_handling")

-- Display Settings
dofile("/home/tyler/.config/awesome/main/display-settings.lua")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/tyler/.config/awesome/theme.lua")

-- Glocal Rc.lua namespace
RC = {}

RC.primary_screen = screen[1]
RC.primary_screen_w = RC.primary_screen.geometry.width
RC.primary_screen_h = RC.primary_screen.geometry.height

RC.vars = require("main.user-variables")
modkey = RC.vars.modkey
terminal = RC.vars.terminal

-- temp
editor = "vim"
editor_cmd = "kitty -e vim"

-- Object representation of main directory
local main = {
	menu = require("main.menu"),
	layouts = require("main.layout"),
	rules = require("main.rules")
}

-- Object representation of bindings directory
local bindings = {
	globalkeys = require("bindings.global_keys"),
	clientkeys = require("bindings.clientkeys")
}

-- Object representation of decor directory
local decor = {
	tags = require("decor.tags"),
	apps = require("decor.apps")
}

-- Layouts
-- The default list of layouts
awful.layout.layouts = main.layouts()

-- Lancher 
RC.main_menu = awful.menu({ items = main.menu() })
RC.launcher = awful.widget.launcher(
{ menu = awful.menu({ items = RC.menu }) }
)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = decor.tags()

local tasklist_buttons = gears.table.join(
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
	else
		c:emit_signal(
		"request::activate",
		"tasklist",
		{raise = true}
		)
	end
end),
awful.button({ }, 3, function()
	awful.menu.client_list({ theme = { width = 250 } })
end),
awful.button({ }, 4, function ()
	awful.client.focus.byidx(1)
end),
awful.button({ }, 5, function ()
	awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8" }, s, awful.layout.layouts)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.noempty,
		buttons = taglist_buttons,
		widget_template = {
			--[[
			{ -- Margins
				{ -- Instance count
					id = "client_icon",
					widget = wibox.widget.imagebox
				},
				margins = 10,
				widget = wibox.container.margin
			},]]--
			{
				{
					id = "text_role",
					widget = wibox.widget.textbox
				},
				margins = 10,
				widget = wibox.container.margin
			},
			layout = wibox.layout.fixed.horizontal,
			create_callback = function(self, c, index, objects)
			end,
			update_callback = function(self, c, index, objects)
			end,
		},
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	--{{{ Calendar Button
	local month_calendar = awful.widget.calendar_popup.month {
		screen = s,
		date = os.date("*t"),
		position = "top_right",
		border_color = "#000000",
		border_width = 0,
	}

	local calendar_button = wibox.widget {
		{
			image = "/usr/share/icons/Papirus/32x32/apps/calendar.svg",
			widget = wibox.widget.imagebox
		},
		widget = wibox.container.margin,
		top = 4,
		bottom = 4,
		left = 5,
		right = 5
	}

	calendar_button:connect_signal("button::press", function(c, _, _, button) 
		if button == 1 then
			month_calendar:toggle()
		end
	end)
	--}}}

	--{{{ Osu Launcher
	local osu_button = wibox.widget {
		{
			image = "/home/tyler/.config/awesome/icons/osu_logo.svg",
			widget = wibox.widget.imagebox
		},
		widget = wibox.container.margin,
		top = 4,
		bottom = 4,
		left = 5,
		right = 5
	}
	osu_button:connect_signal("button::press", function(c, _, _, button)
		if button == 1 then
			awful.spawn.with_shell("/home/tyler/Documents/osu.AppImage")
		end
	end)
	--}}}

	--}}} Dock
	require("decor.dock")
	local bottom_dock_w = 850
	local bottom_dock_h = 64
	local bottom_dock = Create_dock(s, bottom_dock_w, bottom_dock_h, 8)
	local dock_apps = decor.apps()
	bottom_dock:setup {
		{
			dock_apps.firefox,
			dock_apps.thunar,
			dock_apps.kitty,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.background,
	}

	bottom_dock:struts{ bottom = (bottom_dock_h + 10) }

	awful.placement.bottom(bottom_dock, { margins = { bottom = 10 }, parent = awful.screen.focused() } )
	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })
	--}}}

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			RC.launcher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			osu_button,
			calendar_button,
			wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
		},
	}
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
awful.button({ }, 3, function () RC.main_menu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- Global Key bindings
globalkeys = bindings.globalkeys()

-- Keybindings
clientkeys = bindings.clientkeys()

-- ???
clientbuttons = gears.table.join(
awful.button({ }, 1, function (c)
	c:emit_signal("request::activate", "mouse_click", {raise = true})
end),
awful.button({ modkey }, 1, function (c)
	c:emit_signal("request::activate", "mouse_click", {raise = true})
	awful.mouse.client.move(c)
end),
awful.button({ modkey }, 3, function (c)
	c:emit_signal("request::activate", "mouse_click", {raise = true})
	awful.mouse.client.resize(c)
end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules()

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
	awful.button({ }, 1, function()
		c:emit_signal("request::activate", "titlebar", {raise = true})
		awful.mouse.client.move(c)
	end),
	awful.button({ }, 3, function()
		c:emit_signal("request::activate", "titlebar", {raise = true})
		awful.mouse.client.resize(c)
	end)
	)

	awful.titlebar(c) : setup {
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			--buttons = buttons,
			awful.titlebar.widget.floatingbutton (c),
			awful.titlebar.widget.maximizedbutton(c),
			layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
			awful.titlebar.widget.stickybutton   (c),
			awful.titlebar.widget.ontopbutton    (c),
			awful.titlebar.widget.closebutton    (c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
