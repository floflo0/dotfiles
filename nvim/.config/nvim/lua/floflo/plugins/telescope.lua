local winblend
if vim.g.neovide then
    winblend = 50
else
    winblend = 0
end

return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                winblend = winblend,
            }
        })
        telescope.load_extension('fzf')

        local telescope_builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>',       function() telescope_builtin.find_files() end)
        vim.keymap.set('n', '<leader>s',   function() telescope_builtin.grep_string() end)
        vim.keymap.set('n', '<C-f>',       function() telescope_builtin.live_grep() end)
        vim.keymap.set('n', '<leader>d',   function() telescope_builtin.diagnostics() end)
        vim.keymap.set('n', '<leader>t',   function() telescope_builtin.treesitter() end)
        vim.keymap.set('n', '<leader>w',   function() telescope_builtin.lsp_workspace_symbols() end)
        vim.keymap.set('n', '<leader>vrr', function() telescope_builtin.lsp_references() end)
        vim.keymap.set('n', 'gd',          function() telescope_builtin.lsp_definitions() end)
        vim.keymap.set('n', 'gi',          function() telescope_builtin.lsp_implementations() end)
        vim.keymap.set('n', '<leader>z',   function() telescope_builtin.spell_suggest() end)
        vim.keymap.set('n', '<leader>q',   function() telescope_builtin.quickfix() end)
        vim.keymap.set('n', '<leader>m',   function() telescope_builtin.man_pages({ sections = { 'ALL' } }) end)
        vim.keymap.set('n', '<leader>h',   function() telescope_builtin.help_tags() end)
        vim.keymap.set('n', '<leader>b',   function() telescope_builtin.builtin() end)
    end
}
