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
            },
            pickers = {
                man_pages = { sections = { 'ALL' } }
            }
        })
        telescope.load_extension('fzf')

        local telescope_builtin = require('telescope.builtin')
       vim.keymap.set('n', '<C-p>',       telescope_builtin.find_files,                    { desc = 'Find files' })
       vim.keymap.set('n', '<C-f>',       telescope_builtin.live_grep,                     { desc = 'Search string in the project' })
       vim.keymap.set('n', '<leader>s',   telescope_builtin.grep_string,                   { desc = 'Search the current string in the project' })
       vim.keymap.set('n', '<leader>t',   telescope_builtin.treesitter,                    { desc = 'List treesitter symbols' })
       vim.keymap.set('n', '<leader>d',   telescope_builtin.diagnostics,                   { desc = 'Lsp: list diagnostics' })
       vim.keymap.set('n', '<leader>w',   telescope_builtin.lsp_dynamic_workspace_symbols, { desc = 'Lsp: list workspace symbols' })
       vim.keymap.set('n', '<leader>vrr', telescope_builtin.lsp_references,                { desc = 'Lsp: list references' })
       vim.keymap.set('n', 'gd',          telescope_builtin.lsp_definitions,               { desc = 'Lsp: go or list definitions' })
       vim.keymap.set('n', 'gi',          telescope_builtin.lsp_implementations,           { desc = 'Lsp: go or list implementations' })
       vim.keymap.set('n', '<leader>z',   telescope_builtin.spell_suggest,                 { desc = 'List spell suggestions' })
       vim.keymap.set('n', '<leader>q',   telescope_builtin.quickfix,                      { desc = 'List quickfix' })
       vim.keymap.set('n', '<leader>m',   telescope_builtin.man_pages,                     { desc = 'Man pages' })
       vim.keymap.set('n', '<leader>h',   telescope_builtin.help_tags,                     { desc = 'Search help' })
       vim.keymap.set('n', '<leader>k',   telescope_builtin.keymaps,                       { desc = 'Search in keymaps' })
       vim.keymap.set('n', '<leader>b',   telescope_builtin.builtin,                       { desc = 'Telescope: search builtins pickers' })
       vim.keymap.set('n', '<leader>r',   telescope_builtin.resume,                        { desc = 'Telescope: open back the previous picker' })
    end
}
