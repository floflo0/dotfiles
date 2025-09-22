return {
    'folke/zen-mode.nvim',
    config = true,
    keys = {
        {
            '<A-m>',
            function() require('zen-mode').toggle() end,
           silent = true,
           desc = 'Toggle zen-mode',
       },
    },
}
