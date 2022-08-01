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

vim.keymap.set('n', '<leader>pv', ':Ex<CR>')

-- enlever le surlignement des mot après une recherche
vim.keymap.set('n', '<leader>l', ':noh<CR>', { silent = true })

-- neogit
vim.keymap.set('n', '<leader>gs', function()
    require('neogit').open()
end)
vim.keymap.set('n', '<leader>gc', function()
    require('neogit').open({ 'commit' })
end)

-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function() telescope.find_files() end)

vim.keymap.set('n', '<leader>s', function() telescope.grep_string() end)
vim.keymap.set('n', '<C-f>', function() telescope.live_grep() end)
vim.keymap.set('n', '<leader>d', function() telescope.diagnostics() end)

vim.keymap.set('n', '<leader>m', function() telescope.man_pages() end)
vim.keymap.set('n', '<leader>h', function() telescope.help_tags() end)
vim.keymap.set('n', '<leader>b', function() telescope.builtin() end)

-- luasnip
local luasnip = require('luasnip')
luasnip.config.set_config({
  history = true,
})

-- press <Tab> to expand or jump in a snippet. These can also be mapped separately
-- via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
vim.keymap.set('i', '<Tab>', function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        return '<Tab>'
    end
end, { silent = true, expr = true, noremap = true })
vim.keymap.set('s', '<Tab>', function() luasnip.jump(1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function() luasnip.jump(-1) end, { silent = true })

-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.keymap.set({ 'i', 's' }, '<C-E>', function()
    if luasnip.choice_active() then
        luasnip.next_choice()
    else
        return '<C-E>'
    end
end, { silent = true, expr = true })
