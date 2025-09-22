return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-telescope/telescope.nvim'
    },
    opts = {
        kind = 'split_above',
        popup = {
            kind = 'split_above',
        },
        integrations = {
            diffview = true,
            telescope = true,
        },
        graph_style = 'unicode',
        mappings = {
            popup = {
                ['l'] = false,
                ['<leader>l'] = 'LogPopup',
                ['v'] = false,
                ['<leader>v'] = 'RevertPopup',
            },
        },
    },
    keys = {
        {
            '<leader>gs',
            function() require('neogit').open() end,
            desc = 'Open Neogit'
        },
    },
}
