return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-telescope/telescope.nvim'
    },
    config = function()
        local neogit = require('neogit')
        neogit.setup({
            kind = 'split_above',
            popup = {
                kind = 'split_above',
            },
            integrations = {
                diffview = true,
                telescope = true
            },
            graph_style = 'unicode',
            mappings = {
                popup = {
                    ['l'] = false,
                    ['<leader>l'] = 'LogPopup',
                    ['v'] = false,
                    ['<leader>v'] = 'RevertPopup'
                }
            }
        })
        vim.keymap.set('n', '<leader>gs', neogit.open, { desc = 'Open Neogit' })
        vim.keymap.set('n', '<leader>gc', function()
            neogit.open({ 'commit' })
        end, { desc = 'Git commit' })
    end
}
