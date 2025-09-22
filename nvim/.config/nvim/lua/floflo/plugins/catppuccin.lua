return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            integrations = {
                fidget = true,
                harpoon = true,
                neogit = true,
                noice = true,
                notify = true,
                which_key = true,
            },
        })

        vim.cmd.colorscheme('catppuccin-macchiato')

        vim.api.nvim_set_hl(0, 'HarpoonWindow', { link = 'TelescopeWindow' })
        vim.api.nvim_set_hl(0, 'HarpoonBorder', { link = 'TelescopeBorder' })

        vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {
            underline = true,
            special = require('catppuccin.palettes').get_palette('macchiato').subtext0
        })
        vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
            background = 'none',
        })
    end,
}
