-- TODO: harpoon 2

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
        end, { desc = 'Harpoon: mark file' })
        vim.keymap.set('n', '<leader>o', harpoon_ui.toggle_quick_menu, {
            desc = 'Harpoon: toggle menu'
        })

        local keys = {
            { '<M-&>' },           -- Alt+1
            { '<M-é>', '<F25>' },  -- Alt+2
            { '<M-">' },           -- Alt+3
            { "<M-'>" },           -- Alt+4
            { '<M-(>' },           -- Alt+5
            { '<M-->' },           -- Alt+6
            { '<M-è>', '<F26>' },  -- Alt+7
            { '<M-_>' },           -- Alt+8
            { '<M-ç>', '<F27>' },  -- Alt+9
            { '<M-à>', '<F28>' }   -- Alt+0
        }
        for i = 1, #keys do
            for j = 1, #keys[i] do
                vim.keymap.set('n', keys[i][j], function()
                    harpoon_ui.nav_file(i)
                end, { desc = 'Harpoon: go to the ' .. i ..' marked file' })
            end
        end
    end
}
