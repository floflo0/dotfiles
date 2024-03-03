return {
    'folke/zen-mode.nvim',
    config = function()
        local zenMode = require('zen-mode')
        zenMode.setup()

        vim.keymap.set('n', '<A-m>', zenMode.toggle, {
            silent = true,
            desc = 'Toggle zen-mode'
        })
    end,
}
