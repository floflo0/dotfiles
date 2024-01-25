-- Use control+C to escape insert mode
vim.keymap.set('i', '<C-c>', '<esc>')

-- Change window
vim.keymap.set('n', '<A-k>', function() vim.cmd('wincmd k') end, { silent = true })
vim.keymap.set('n', '<A-j>', function() vim.cmd('wincmd j') end, { silent = true })
vim.keymap.set('n', '<A-h>', function() vim.cmd('wincmd h') end, { silent = true })
vim.keymap.set('n', '<A-l>', function() vim.cmd('wincmd l') end, { silent = true })

-- Move window
vim.keymap.set('n', '<A-K>', function() vim.cmd('wincmd K') end, { silent = true })
vim.keymap.set('n', '<A-J>', function() vim.cmd('wincmd J') end, { silent = true })
vim.keymap.set('n', '<A-H>', function() vim.cmd('wincmd H') end, { silent = true })
vim.keymap.set('n', '<A-L>', function() vim.cmd('wincmd L') end, { silent = true })

-- Resize window
vim.keymap.set('n', '<C-A-K>', function() vim.cmd('wincmd +') end, { silent = true })
vim.keymap.set('n', '<C-A-J>', function() vim.cmd('wincmd -') end, { silent = true })
vim.keymap.set('n', '<C-A-H>', function() vim.cmd('wincmd <') end, { silent = true })
vim.keymap.set('n', '<C-A-L>', function() vim.cmd('wincmd >') end, { silent = true })

-- Vertical split
vim.keymap.set('n', '<A-SPACE>', function() vim.cmd('vsplit') end, { silent = true })

-- Open a terminal window
local SHELL = os.getenv('SHELL')
vim.keymap.set('n', '<A-CR>', function()
    vim.cmd('vsplit term://' .. SHELL )
    vim.cmd('norm i')
end)
vim.keymap.set('n', '<leader><A-CR>', function()
    vim.cmd('e term://' .. SHELL )
    vim.cmd('norm i')
end)

-- Move a line
vim.keymap.set('n', '<C-k>', ':m -2<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':m +1<CR>', { silent = true })

-- Go to next/prev quickfix
vim.keymap.set('n', '<leader>cn', ':cnext<CR>')
vim.keymap.set('n', '<leader>cp', ':cprev<CR>')

-- File explorer
vim.keymap.set('n', '<leader>pv', function() vim.cmd('Ex') end)

-- Disable highlight after a search
vim.keymap.set('n', '<leader>l', function() vim.cmd('noh') end, { silent = true })

-- Lsp
vim.keymap.set('n', 'K',           function() vim.lsp.buf.hover() end)
vim.keymap.set('n', '<leader>vd',  function() vim.diagnostic.open_float() end)
vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end)
