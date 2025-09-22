return {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
        notification = {
            window = {
                winblend = 0,
                border = 'rounded',
                x_padding = 1,
                y_padding = 1,
            },
        },
    },
}
