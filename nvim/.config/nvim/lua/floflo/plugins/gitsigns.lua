return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    opts = {
        numhl = true,
        linehl = false,
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 500,
        },
        current_line_blame_formatter = ' <summary> - <author>, <author_time:%R>',
    },
    keys = {
        {
            '<leader>gd',
            function() require('gitsigns').preview_hunk() end,
            desc = 'Show local git diff',
        },
    },
}
