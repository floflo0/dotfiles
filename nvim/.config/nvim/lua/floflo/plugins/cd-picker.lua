local CONFIG_PATH = vim.fn.stdpath('config')

return {
    dir = CONFIG_PATH .. '/cd-picker',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    lazy = true,
    event = 'VeryLazy',
    config = function()
        local cd_picker = require('cd-picker')

        vim.keymap.set('n', '<leader>cd', cd_picker, { desc = 'Open cd picker' })
    end
}
