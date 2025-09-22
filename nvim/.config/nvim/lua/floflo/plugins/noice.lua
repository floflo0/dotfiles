return {
    'folke/noice.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify'
    },
    event = 'VeryLazy',
    opts = {
        cmdline = {
            enabled = true,
            view = 'cmdline_popup',
            opts = {},
            ---@type table<string, CmdlineFormat>
            format = {
                -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                -- view: (default is cmdline view)
                -- opts: any options passed to the view
                -- icon_hl_group: optional hl_group for the icon
                -- title: set to anything or empty string to hide
                cmdline = { pattern = '^:', icon = ':', lang = 'vim', title = ' Command ' },
                search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
                search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
                lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
                help = { pattern = '^:%s*he?l?p?%s+', icon = '?' },
                filter = { pattern = '^:%s*!', icon = '❯', lang = 'fish', title = ' Shell Command ' },
                input = { view = 'cmdline_input', icon = '󰥻 ' },
            },
        },
        messages = {
            -- NOTE: If you enable messages, then the cmdline is enabled automatically.
            -- This is a current Neovim limitation.
            enabled = false, -- enables the Noice messages UI
            view = 'split', -- default view for messages
            view_error = 'notify', -- view for errors
            view_warn = 'notify', -- view for warnings
            view_history = 'messages', -- view for :messages
            view_search = 'cmdline', -- view for search count messages. Set to `false` to disable
        },
        lsp = {
            progress = {
                enabled = false,
            },
            signature = {
                enabled = false,
            },
        },
    },
}
