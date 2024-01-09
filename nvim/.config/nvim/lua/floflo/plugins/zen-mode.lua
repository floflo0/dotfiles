return {
    'folke/zen-mode.nvim',
    config = function()
        local zenMode = require('zen-mode')
        zenMode.setup()

        vim.keymap.set('n', '<A-m>', function()
            zenMode.toggle()
        end, { silent = true })
    end,
}
