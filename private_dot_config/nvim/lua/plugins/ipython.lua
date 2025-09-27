--[[
-- IPython development and interaction.
-- created 09/27/2025
-- + depends on `molten-nvim`, see docs for more information:
--   it works via quarto docs; this should make it a bit more agile
--   for editing ipython files in terminal (rather than using `vscodium`.
--
-- + editing notebooks via quarto is also provided
--]]

return {
    -- molten.nvim
    {
        "benlubas/molten-nvim",
        version = "^2.0.0",
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_wrap_output = true -- wrap output
            vim.g.molten_virt_text_output =true -- output as virtual text
            vim.g.molten_virt_lines_off_by_1 = true

            -- setup keybindings
            vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
            vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })

            vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
            vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
            vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
            vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

            -- if you work with html outputs:
            vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })
        end
    },

    -- image display in terminal
    {
        "3rd/image.nvim",
        opts = {
            backend = "kitty",
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },

    -- quarto
    {
    }
}
