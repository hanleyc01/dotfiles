--[[
-- Support for nvim telescope
-- Created 12/08/2025
--]]

return {
  {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "ff", require("telescope.builtin").find_files, mode = "n", desc = "Telescope find files" },
      { "fg", require("telescope.builtin").live_grep, mode = "n", desc = "Telescope grep" },
      { "fb", require("telescope.builtin").buffers, mode = "n", desc = "Telescope buffers" },
      { "fh", require("telescope.builtin").help_tags, mode = "n", desc = "Telescope help tags" }
    },
  }
}
