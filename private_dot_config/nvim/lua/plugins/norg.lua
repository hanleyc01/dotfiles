--[[
-- Neorg support for nvim
-- Created 06/19/2026
--]]

return {
  {
    "nvim-neorg/neorg",
    ft = "norg", -- lazy load on filetype
    cmd = "Neorg", -- lazy load on command, allows you to autocomplete :Neorg regardless of whether it's loaded yet
    priority = 30, -- treesitter is on default priority of 50, neorg should load after it.
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
        },
      }
    end,
  }
}
