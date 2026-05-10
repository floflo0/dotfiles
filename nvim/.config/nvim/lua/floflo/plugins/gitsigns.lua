return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    opts = {
        numhl = true,
        linehl = false,
    },
    keys = {
        {
            '<leader>gd',
            function() require('gitsigns').preview_hunk() end,
            desc = 'Show local git diff',
        },
    },
}
