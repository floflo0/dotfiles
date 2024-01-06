return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
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
                'jsonc',
                'lua',
                'luadoc',
                'luap',
                'make',
                'markdown',
                'markdown_inline',
                'nasm',
                'php',
                'phpdoc',
                'query',
                'regex',
                'requirements',
                'rust',
                'sql',
                'toml',
                'typescript',
                'vim',
                'vimdoc',
                'vue',
                'xml',
                'yaml'
            },
            ignore_install = {},

            sync_install = false,

            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<c-backspace>',
                },
            },

            modules = {}
        })
    end
}
