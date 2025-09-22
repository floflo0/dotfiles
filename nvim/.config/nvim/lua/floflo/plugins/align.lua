return {
    'Vonr/align.nvim',
    keys = {
        {
            '<leader>a',
            function() require('align').align_to_string({ preview = true }) end,
            mode = 'x',
            desc = 'Align',
            noremap = true,
            silent = true,
        },
    },
}
