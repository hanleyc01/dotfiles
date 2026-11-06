--[[
-- Latex support
-- 1/28/2026
--]]

return {
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      vim.vimtex_view_general_viewer = "skim"
    end
  },
}
