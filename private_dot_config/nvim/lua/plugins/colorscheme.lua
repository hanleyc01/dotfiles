-- Set the colorscheme depending on the time of day.
local function callback()
    local current_hour = os.date("*t").hour
    local is_nighttime = current_hour >= 15 or current_hour < 6
    if is_nighttime then
        vim.cmd([[colorscheme tokyonight-storm]])
    else
        vim.cmd([[colorscheme tokyonight-day]])
    end
end

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        init = callback,
    }
}
