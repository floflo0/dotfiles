return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        'nvim-telescope/telescope-ui-select.nvim'
    },
    config = function()
        local winblend
        if vim.g.neovide then
            winblend = 50
        else
            winblend = 0
        end
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                winblend = winblend,
                prompt_prefix = ' ❯ '
            },
            pickers = {
                man_pages = { sections = { 'ALL' } }
            }
        })
        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
    end,
    keys = {
            {
                '<C-p>',
                function() require('telescope.builtin').find_files() end,
                desc = 'Find files',
            },
            {
                '<C-f>',
                function() require('telescope.builtin').live_grep() end,
                desc = 'Search string in the project',
            },
            {
                '<leader>s',
                function() require('telescope.builtin').grep_string() end,
                desc = 'Search the current string in the project',
            },
            {
                '<leader>t',
                function() require('telescope.builtin').treesitter() end,
                desc = 'List treesitter symbols',
            },
            {
                '<leader>d',
                function() require('telescope.builtin').diagnostics() end,
                desc = 'Lsp: list diagnostics',
            },
            {
                '<leader>w',
                function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
                desc = 'Lsp: list workspace symbols',
            },
            {
                '<leader>vrr',
                function() require('telescope.builtin').lsp_references() end,
                desc = 'Lsp: list references',
            },
            {
                'gd',
                function() require('telescope.builtin').lsp_definitions() end,
                desc = 'Lsp: go or list definitions',
            },
            {
                'gi',
                function() require('telescope.builtin').lsp_implementations() end,
                desc = 'Lsp: go or list implementations',
            },
            {
                '<leader>z',
                function() require('telescope.builtin').spell_suggest() end,
                desc = 'List spell suggestions',
            },
            {
                '<leader>q',
                function() require('telescope.builtin').quickfix() end,
                desc = 'List quickfix',
            },
            {
                '<leader>m',
                function() require('telescope.builtin').man_pages() end,
                desc = 'Man pages',
            },
            {
                '<leader>h',
                function() require('telescope.builtin').help_tags() end,
                desc = 'Search help',
            },
            {
                '<leader>k',
                function() require('telescope.builtin').keymaps() end,
                desc = 'Search in keymaps',
            },
            {
                '<leader>b',
                function() require('telescope.builtin').builtin() end,
                desc = 'Telescope: search builtins pickers',
            },
            {
                '<leader><Esc>',
                function() require('telescope.builtin').resume() end,
                desc = 'Telescope: open back the previous picker',
            },
    },
}
