--[[
-- plugin development for `mary.nvim`, which allows for llm interaction from nvim
-- created 11/30/2025
--]]

return {
	{
		dir = "~/Github-Projects/mary.nvim",
		dev = true,
		config = function()
			local mary = require("mary")
			mary.setup({
				model = "test_model",
			})
		end,
		keys = {
			{ "msq", "<cmd>'<,'>MarySendQuery<cr>", mode = "x" },
		},
	},
}
