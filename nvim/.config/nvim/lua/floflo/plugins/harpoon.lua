return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require('harpoon').setup()

        local harpoon_ui = require('harpoon.ui')
        local harpoon_mark = require('harpoon.mark')
        local harpoon_utils = require('harpoon.utils')
        vim.keymap.set('n', '<leader>j', function()
            local name = harpoon_utils.normalize_path(
                vim.api.nvim_buf_get_name(0)
            )
            harpoon_mark.add_file()
            local status = harpoon_mark.status()
            vim.print('Harpoon: ' .. name .. ' (' .. status .. ')')
        end)
        vim.keymap.set('n', '<leader>n', function()
            harpoon_ui.toggle_quick_menu()
        end)

        -- Alt+é doesn't work in the terminal
        local keys = { '&', 'é', '"', "'", '(', '-', 'è', '_', 'ç', 'à' }
        for i = 1, 9 do
            vim.keymap.set('n', '<A-' .. keys[i] .. '>', function()
                harpoon_ui.nav_file(i)
            end)
        end
    end
}
