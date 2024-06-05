return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {
                desc = 'Toggle Undotree'
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        config = true
    },
    {
        'Vonr/align.nvim',
        lazy = true,
        init = function()
            local align = require('align')
            vim.keymap.set('x', '<leader>a', function()
                align.align_to_string({ preview = true })
            end, { noremap = true, silent = true, desc = 'Align' })
        end
    },
    {
        'j-hui/fidget.nvim',
        opts = {
            notification = {
                window = {
                    winblend = 0
                }
            }
        }
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            scope = {
                enabled = true,
                show_start = false,
                show_end = false
            }
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require('gitsigns')
            gitsigns.setup({
                numhl = true
            })

            vim.keymap.set('n', '<leader>gd', gitsigns.preview_hunk, {
                desc = 'Show local git diff'
            })
        end
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = true
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true
    },
    {
        'RRethy/vim-illuminate',
        event = 'VeryLazy'
    },
    {
        'tpope/vim-surround',
        event = 'VeryLazy'
    }
}
