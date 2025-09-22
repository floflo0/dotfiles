-- TODO: harpoon 2

return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = true,
    keys = {
        {
            '<leader>j',
            function()
                local name = require('harpoon.utils').normalize_path(
                    vim.api.nvim_buf_get_name(0)
                )
                local harpoon_mark = require('harpoon.mark')
                harpoon_mark.add_file()
                local status = harpoon_mark.status()
                vim.print('Harpoon: ' .. name .. ' (' .. status .. ')')
            end,
            desc = 'Harpoon: mark file',
        },
        {
            '<leader>o',
            function() require('harpoon.ui').toggle_quick_menu() end,
            desc = 'Harpoon: toggle menu',
        },
        {
            '<M-&>',  -- Alt+1
            function() require('harpoon.ui').nav_file(1) end,
            desc = 'Harpoon: go to the 1 marked file',
        },
        {
            '<M-é>',  -- Alt+2
            function() require('harpoon.ui').nav_file(2) end,
            desc = 'Harpoon: go to the 2 marked file',
        },
        {
            '<F25>',  -- Alt+2
            function() require('harpoon.ui').nav_file(2) end,
            desc = 'Harpoon: go to the 2 marked file',
        },
        {
            '<M-">',  -- Alt+3
            function() require('harpoon.ui').nav_file(3) end,
            desc = 'Harpoon: go to the 3 marked file',
        },
        {
            "<M-'>",  -- Alt+4
            function() require('harpoon.ui').nav_file(4) end,
            desc = 'Harpoon: go to the 4 marked file',
        },
        {
            "<M-(>",  -- Alt+5
            function() require('harpoon.ui').nav_file(5) end,
            desc = 'Harpoon: go to the 5 marked file',
        },
        {
            "<M-->",  -- Alt+6
            function() require('harpoon.ui').nav_file(6) end,
            desc = 'Harpoon: go to the 6 marked file',
        },
        {
            "<M-è>",  -- Alt+7
            function() require('harpoon.ui').nav_file(7) end,
            desc = 'Harpoon: go to the 7 marked file',
        },
        {
            "<F26>",  -- Alt+7
            function() require('harpoon.ui').nav_file(7) end,
            desc = 'Harpoon: go to the 7 marked file',
        },
        {
            "<M-_>",  -- Alt+8
            function() require('harpoon.ui').nav_file(8) end,
            desc = 'Harpoon: go to the 8 marked file',
        },
        {
            "<M-ç>",  -- Alt+9
            function() require('harpoon.ui').nav_file(9) end,
            desc = 'Harpoon: go to the 9 marked file',
        },
        {
            "<F27>",  -- Alt+9
            function() require('harpoon.ui').nav_file(9) end,
            desc = 'Harpoon: go to the 9 marked file',
        },
        {
            "<M-à>",  -- Alt+0
            function() require('harpoon.ui').nav_file(10) end,
            desc = 'Harpoon: go to the 10 marked file',
        },
        {
            "<F28>",  -- Alt+0
            function() require('harpoon.ui').nav_file(10) end,
            desc = 'Harpoon: go to the 10 marked file',
        },
    },
}
