return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
                multiwindow = true,
                max_lines = 5,
                min_window_height = 25,
                multiline_threshold = 3,
            },
        },
        'hiphish/rainbow-delimiters.nvim',
    },
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local treesitter = require('nvim-treesitter')
        treesitter.setup()
        treesitter.install({
            'bash',
            'c',
            'cmake',
            'comment',
            'cpp',
            'css',
            'dockerfile',
            'fish',
            'gitignore',
            'glsl',
            'go',
            'gomod',
            'html',
            'htmldjango',
            'ini',
            'java',
            'javascript',
            'jsdoc',
            'json',
            'json5',
            'kotlin',
            'lua',
            'luadoc',
            'luap',
            'make',
            'markdown',
            'markdown_inline',
            'nasm',
            'ocaml',
            'php',
            'phpdoc',
            'query',
            'regex',
            'requirements',
            'ruby',
            'rust',
            'sql',
            'toml',
            'typescript',
            'vim',
            'vimdoc',
            'vue',
            'xml',
            'yaml',
        })
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
            callback = function(args)
               pcall(vim.treesitter.start, args.buf)
            end
        })
    end,
    keys = {
        {
            '<C-l>',
            function()
                require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
            end,
            mode = 'n',
        },
        {
            '<C-h>',
            function()
                require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
            end,
            mode = 'n',
        },
        {
            '<leader>e',
            function()
                require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer')
            end,
            mode = { 'n', 'x', 'o' },
        },
        {
            '<leader>y',
            function()
                require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer')
            end,
            mode = { 'n', 'x', 'o' },
        },
    },
}
