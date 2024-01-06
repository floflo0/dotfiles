local COLORSCHEMES = { 'dracula', 'onedark', 'rose-pine', 'catppuccin',
                       'catppuccin-macchiato', 'tokyonight', 'gruvbox' }

math.randomseed(os.time())

local getRandomColorscheme = function ()
    return COLORSCHEMES[math.random(#COLORSCHEMES)]
end

function SetColorscheme(colorscheme)
    vim.cmd.colorscheme(colorscheme)

    if vim.g.neovide then
        vim.cmd('TransparentDisable')

        vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'MsgArea', { bg = 'none' })
    else
        vim.cmd('TransparentEnable')
    end

    vim.print(colorscheme)
end

return {
    'xiyaowong/transparent.nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
        'gruvbox-community/gruvbox',
        'navarasu/onedark.nvim',
        {
            'dracula/vim',
            name = 'dracula'
        },
        {
            'rose-pine/neovim',
            name = 'rose-pine',
            opts = {
                variant = 'moon',
                dark_variant = 'moon',
                disable_float_background = true,
                highlight_groups = {
                    ColorColumn = { bg = 'overlay' },
                }
            }
        },
        {
            'catppuccin/nvim',
            name = 'catppuccin',
            config = true
        },
        {
            'folke/tokyonight.nvim',
            opts = {
                on_colors = function(colors)
                    colors.bg_float = 'none'
                end
            }
        }
    },
    config = function()
        require('transparent').setup({
            exclude_groups = { 'CursorLine' }
        })
        SetColorscheme(getRandomColorscheme())
        -- SetColorscheme('catppuccin')
        -- SetColorscheme('gruvbox')
        -- SetColorscheme('rose-pine')
        -- SetColorscheme('dracula')
    end
}
