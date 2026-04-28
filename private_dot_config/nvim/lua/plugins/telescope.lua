--[[
-- Support for nvim telescope
-- Created 12/08/2025
--]]

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "ff", function() require("telescope.builtin").find_files() end, mode = "n", desc = "Telescope find files" },
			{ "fg", function() require("telescope.builtin").live_grep() end, mode = "n", desc = "Telescope grep" },
			{ "fb", function() require("telescope.builtin").buffers() end, mode = "n", desc = "Telescope buffers" },
			{ "fh", function() require("telescope.builtin").help_tags() end, mode = "n", desc = "Telescope help tags" },
		},
	},
}
