--[[
-- Latex editing using VimTex
-- Created 09/29/2025
--]]

return {
	-- VimTex
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_general_viewer = "okular"
			vim.g.view_gneeral_options = "--unique file:@pdf#src:@line@tex"
		end,
	},
}
