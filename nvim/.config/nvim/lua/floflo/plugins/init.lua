return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
    {
        'numToStr/Comment.nvim',
        config = true
    },
    {
        'Vonr/align.nvim',
        init = function()
            local align = require('align')
            vim.keymap.set('x', '<leader>a', function()
                align.align_to_string({ preview = true })
            end, { noremap = true, silent = true })
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
    }
}
