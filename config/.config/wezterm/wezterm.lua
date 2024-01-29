local wezterm = require("wezterm")

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
	local names = { name, "Noto Color Emoji", "JetBrains Mono" }
	return wezterm.font_with_fallback(names, params)
end

local colors = {

	-- Bew colors
	background = "#191919",
	foreground = "#eeeeee",

	cursor_bg = "#eeeeee",
	cursor_fg = "#202020",
	cursor_border = "#eeeeee", -- same as cursor_bg

	ansi = {
		"#2F2F2F", -- black
		"#ff6565", -- red
		"#4CAF50", -- green
		"#eab93d", -- yellow
		"#5788FF", -- blue
		"#ce5c00", -- orange (magentas usually)
		"#89b6e2", -- cyan
		"#cccccc", -- white
	},

	brights = {
		"#555753", -- black
		"#ff6565", -- red
		"#4CAF50", -- green
		"#ffc123", -- yellow
		"#2C82F2", -- blue
		"#f57900", -- orange (magentas usually)
		"#89b6e2", -- cyan
		"#fafafa", -- white
	},
}

local keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

local font_rules = {
	{
		italic = true,
		font = font_with_fallback("0xProto Nerd Font"),
	},
	{
		italic = true,
		intensity = "Bold",
		font = font_with_fallback("0xProto Nerd Font Mono"),
	},
	{
		intensity = "Bold",
		font = font_with_fallback("0xProto Nerd Font Propo"),
	},
}

return {

	font_size = 16,
	font_rules = font_rules,
	keys = keys,
	-- Smart tab bar [distraction-free mode]
	hide_tab_bar_if_only_one_tab = true,

	-- Color scheme
	colors = colors,
	color_scheme_dirs = { "$HOME/.config/wezterm/colors" },
	-- color_scheme = ""
	-- https://wezfurlong.org/wezterm/config/appearance.html
	--
	-- Dracula
	-- https://draculatheme.com
}
