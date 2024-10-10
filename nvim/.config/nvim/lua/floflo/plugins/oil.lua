local winblend
if vim.g.neovide then
    winblend = 50
else
    winblend = 0
end

return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup({
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
            dependencies = { { 'echasnovski/mini.icons', opts = {} } },
        })

        vim.keymap.set('n', '<leader>x', vim.cmd.Oil, { desc = 'Open file explorer' })
    end,
}
