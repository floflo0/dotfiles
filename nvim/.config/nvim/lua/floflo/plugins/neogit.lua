return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
    },
    config = function()
        local neogit = require('neogit')
        neogit.setup({
            disable_context_highlighting = true,
            kind = 'split_above',
            popup = {
                kind = 'split_above',
            },
            integrations = { diffview = true },
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
        vim.keymap.set('n', '<leader>gs', function() neogit.open() end)
        vim.keymap.set('n', '<leader>gc', function() neogit.open({ 'commit' }) end)
    end
}
