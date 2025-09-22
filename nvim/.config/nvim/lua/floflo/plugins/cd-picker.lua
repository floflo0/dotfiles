local CONFIG_PATH = vim.fn.stdpath('config')

return {
    dir = CONFIG_PATH .. '/cd-picker',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = {
        {
            '<leader>cd',
            function() require('cd-picker')() end,
            desc = 'Open cd picker',
        },
    },
}
