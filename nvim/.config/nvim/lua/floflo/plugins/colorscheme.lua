local COLORSCHEMES = {
    'dracula',
    'onedark',
    'rose-pine',
    'catppuccin',
    'catppuccin-macchiato',
    'tokyonight',
    'gruvbox'
}

math.randomseed(os.time())

local function include(array, value)
    for _, el in pairs(array) do
        if el == value then
            return true
        end
    end
    return false
end

local getRandomColorscheme = function()
    return COLORSCHEMES[math.random(#COLORSCHEMES)]
end

local function setColorscheme(colorscheme)
    vim.cmd.colorscheme(colorscheme)

    if vim.g.neovide then
        vim.cmd.TransparentDisable()

        vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'MsgArea',    { bg = 'none' })
    else
        vim.cmd.TransparentEnable()

        local group = vim.api.nvim_create_augroup('HarpoonBlend', {})
        vim.api.nvim_create_autocmd({ 'FileType' },{
            group = group,
            pattern = 'harpoon',
            callback = function()
                local win = vim.api.nvim_get_current_win()
                -- NOTE: The borders are in an other window
                vim.api.nvim_win_call(win + 1, function()
                    vim.opt_local.winblend = 0
                end)
                vim.opt_local.winblend = 0
            end
        })
    end

    vim.api.nvim_set_hl(0, 'HarpoonWindow', { link = 'TelescopeWindow' })
    vim.api.nvim_set_hl(0, 'HarpoonBorder', { link = 'TelescopeBorder' })

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
                    ColorColumn = { bg = 'overlay' }
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
        local extra_groups = {}
        if not vim.g.neovide then
            extra_groups[#extra_groups + 1] = 'NormalFloat'
        end
        require('transparent').setup({
            extra_groups = extra_groups,
            exclude_groups = { 'CursorLine' }
        })

        vim.api.nvim_create_user_command('SetColorscheme', function(command)
            if not include(COLORSCHEMES, command.args) then
                vim.api.nvim_err_writeln(
                    'error: ' .. command.args .. ' is not a valid colorscheme'
                )
                return
            end
            setColorscheme(command.args)
        end, {
            bang = false,
            nargs = 1,
            desc = 'Change the colorscheme of neovim',
            complete = function ()
                return COLORSCHEMES
            end
        })

        -- setColorscheme(getRandomColorscheme())
        -- setColorscheme('catppuccin')
        setColorscheme('catppuccin-macchiato')
        -- setColorscheme('gruvbox')
        -- setColorscheme('rose-pine')
        -- setColorscheme('dracula')
    end
}
