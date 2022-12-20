require('floflo.set')
require('floflo.packer')
require('floflo.neovide')

local flofloGroup = vim.api.nvim_create_augroup('floflo', {})

vim.api.nvim_create_autocmd({'BufWritePre'}, {
    group = flofloGroup,
    pattern = '*',
    command = '%s/\\s\\+$//e',
})

local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})
