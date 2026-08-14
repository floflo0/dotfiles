return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            default_integrations = true,
            auto_integrations = true,
            integrations = {
                blink_cmp = {
                    enabled = true,
                    style = 'bordered',
                },
                gitsigns = true,
                rainbow_delimiters = true,
                telescope = true,
                treesitter_context = true,
                illuminate = {
                    enabled = true,
                    lsp = true,
                },
                indent_blankline = {
                    enabled = true,
                    scope_color = "",
                    colored_indent_levels = false,
                },

                fidget = true,
                harpoon = true,
                noice = true,
                notify = true,
            },
        })

        vim.cmd.colorscheme('catppuccin-macchiato')

        local palette = require('catppuccin.palettes').get_palette('macchiato')
        -- vim.print(palette)

        vim.api.nvim_set_hl(0, 'HarpoonWindow', { link = 'TelescopeWindow' })
        vim.api.nvim_set_hl(0, 'HarpoonBorder', { link = 'TelescopeBorder' })
        vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { link = 'NormalFloat' })
        vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })

        vim.api.nvim_set_hl(0, 'FloatBorder', {
            foreground = palette.blue,
            background = 'none',
        })
        vim.api.nvim_set_hl(0, 'FloatTitle', {
            foreground = palette.blue,
            background = 'none',
        })

        vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {
            underline = true,
            special = require('catppuccin.palettes').get_palette('macchiato').subtext0
        })
        vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
            background = 'none',
        })
    end,
}
