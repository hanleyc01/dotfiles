--[[
-- nvim-tree 
-- created 12/1/2025
--]]

return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
		keys = {
			{ "<localleader>mt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
			{ "<localleader>mf", "<cmd>NvimTreeFocus<cr>", desc = "Focus NvimTree" },
		},
	},
}
