return {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
        float_diff = false,
        layout = 'left_left_bottom',
    },
    keys = {
        {
            '<leader>u',
            function() require('undotree').toggle() end,
            desc = 'Toggle Undotree',
        },
    },
}
