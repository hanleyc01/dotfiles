--[[
-- Colortheme customization
-- Created 9/27/2025
-- + added daytime/nighttime cycle, which is modular
--]]

--- Set the colorscheme depending on the time of day.
--- @param daytime_name string Name of the colorscheme to use during the day.
--- @param nighttime_name string Name of the colorscheme to use during the night.
local function callback(daytime_name, nighttime_name)
	return function()
		local current_hour = os.date("*t").hour
		local is_nighttime = current_hour >= 14 or current_hour < 6
		if is_nighttime then
			vim.cmd("colorscheme " .. nighttime_name)
		else
			vim.cmd("colorscheme " .. daytime_name)
		end
	end
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		init = callback("tokyonight-day", "tokyonight-storm"),
	},
}
