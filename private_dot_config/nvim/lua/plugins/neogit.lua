--[[
-- support for neogit.nvim and nvim-telescope
-- created 12/08/2025
--]]

return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
    },
    cmd = "Neogit",
    keys = {
      { "gG", "<cmd>Neogit<cr>", mode = "n", desc = "Show Neogit UI" }
    }
  }
}
