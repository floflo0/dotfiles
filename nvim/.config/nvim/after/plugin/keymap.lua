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
vim.keymap.set('n', '<leader>t', function() telescope.treesitter() end)
vim.keymap.set('n', '<leader>vrr', function() telescope.lsp_references() end)

vim.keymap.set('n', '<leader>m', function() telescope.man_pages() end)
vim.keymap.set('n', '<leader>h', function() telescope.help_tags() end)
vim.keymap.set('n', '<leader>b', function() telescope.builtin() end)

-- luasnip
local luasnip = require('luasnip')
luasnip.config.set_config({
  history = true,
})

vim.keymap.set('i', '<Tab>', function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        return '<Tab>'
    end
end, { silent = true, expr = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function() luasnip.jump(-1) end, { silent = true, noremap = true })

vim.keymap.set('s', '<Tab>', function() luasnip.jump(1) end, { silent = true, noremap = true })

vim.keymap.set({ 'i', 's' }, '<C-E>', function()
    if luasnip.choice_active() then
        luasnip.next_choice()
    else
        return '<C-E>'
    end
end, { silent = true, expr = true })

vim.keymap.set('s', '<Tab>', function() luasnip.jump(1) end, { silent = true, expr = true })

-- lsp
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)
vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end)
vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end)
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end)
vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end)
-- vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end)
vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end)
vim.keymap.set('i', '<C-H>', function() vim.lsp.buf.signature_help() end)
