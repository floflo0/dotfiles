return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = { numhl = true },
    keys = {
        {
            '<leader>gd',
            function() require('gitsigns').preview_hunk() end,
            desc = 'Show local git diff',
        },
    },
}
