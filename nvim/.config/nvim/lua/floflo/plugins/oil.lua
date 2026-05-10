local winblend
if vim.g.neovide then
    winblend = 80
else
    winblend = 0
end

return {
    'stevearc/oil.nvim',
    dependencies = {
        {
            'nvim-mini/mini.icons',
            opts = {},
        },
    },
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = { 'icon' },
        delete_to_trash = true,
        win_options = {
            number = false,
            relativenumber = false,
        },
        watch_for_changes = true,
        keymaps = {
            ['<C-p>'] = false,
        },
        view_options = {
            show_hidden = true,
        },
        confirmation = {
            border = 'rounded',
            win_options = {
                winblend = winblend,
            },
        },
    },
    keys = {
        {
            '<leader>x',
            function() require('oil').open() end,
            desc = 'Open file explorer',
        },
    },
}
