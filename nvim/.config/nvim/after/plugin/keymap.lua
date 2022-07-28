-- controler la gestion des fenêtres avec Alt
-- changer de fenêtre
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>', { silent = true })
-- bouger les fenêtres
vim.keymap.set('n', '<A-K>', ':wincmd K<CR>', { silent = true })
vim.keymap.set('n', '<A-J>', ':wincmd J<CR>', { silent = true })
vim.keymap.set('n', '<A-H>', ':wincmd H<CR>', { silent = true })
vim.keymap.set('n', '<A-L>', ':wincmd L<CR>', { silent = true })
-- redimensionner les fenêtres
vim.keymap.set('n', '<C-A-K>', ':wincmd +<CR>', { silent = true })
vim.keymap.set('n', '<C-A-J>', ':wincmd -<CR>', { silent = true })
vim.keymap.set('n', '<C-A-H>', ':wincmd <<CR>', { silent = true })
vim.keymap.set('n', '<C-A-L>', ':wincmd ><CR>', { silent = true })

-- Alt-Enter open terminal in new window
vim.keymap.set('n', '<A-CR>', ':vsplit term://$SHELL<CR> :norm i<CR>')

vim.keymap.set('n', '<A-SPACE>', ':vsplit<CR>', { silent = true })

vim.keymap.set('n', '<C-k>', ':m -2<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':m +1<CR>', { silent = true })
--
vim.keymap.set('n', '<leader>cn', ':cnext<CR>')
vim.keymap.set('n', '<leader>cp', ':cprev<CR>')

-- use Control-c to espcace insert mode
vim.keymap.set('i', '<C-c>', '<esc>')

vim.keymap.set('n', "<leader>pv", ":Ex<CR>")

-- enlever le surlignement des mot après une recherche
vim.keymap.set('n', '<leader>h', ':noh<CR>', { silent = true })

vim.keymap.set('n', '<leader>gs', function()
    require('neogit').open()
end)
vim.keymap.set('n', '<leader>gc', function()
    require('neogit').open({ 'commit' })
end)

vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files() end)

vim.keymap.set('n', '<leader>s', function() require('telescope.builtin').grep_string() end)
vim.keymap.set('n', '<C-f>', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<leader>d', function() require('telescope.builtin').diagnostics() end)

vim.keymap.set('n', '<leader>m', function() require('telescope.builtin').man_pages() end)
vim.keymap.set('n', '<leader>h', function() require('telescope.builtin').help_tags() end)
