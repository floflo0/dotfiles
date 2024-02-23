-- Use control+C to escape insert mode
vim.keymap.set('i', '<C-c>', '<esc>')

vim.keymap.set('n', '<A-k>', function() vim.cmd('wincmd k') end, { silent = true, desc = 'Window: focus up' })
vim.keymap.set('n', '<A-j>', function() vim.cmd('wincmd j') end, { silent = true, desc = 'Window: focus down' })
vim.keymap.set('n', '<A-h>', function() vim.cmd('wincmd h') end, { silent = true, desc = 'Window: focus left' })
vim.keymap.set('n', '<A-l>', function() vim.cmd('wincmd l') end, { silent = true, desc = 'Window: focus right' })

vim.keymap.set('n', '<A-K>', function() vim.cmd('wincmd K') end, { silent = true, desc = 'Window: move up' })
vim.keymap.set('n', '<A-J>', function() vim.cmd('wincmd J') end, { silent = true, desc = 'Window: move down' })
vim.keymap.set('n', '<A-H>', function() vim.cmd('wincmd H') end, { silent = true, desc = 'Window: move left' })
vim.keymap.set('n', '<A-L>', function() vim.cmd('wincmd L') end, { silent = true, desc = 'Window: move right' })

-- Resize window
vim.keymap.set('n', '<C-A-K>', function() vim.cmd('wincmd +') end, { silent = true, desc = 'Window: grow height' })
vim.keymap.set('n', '<C-A-J>', function() vim.cmd('wincmd -') end, { silent = true, desc = 'Window: shrink height' })
vim.keymap.set('n', '<C-A-H>', function() vim.cmd('wincmd <') end, { silent = true, desc = 'Window: shrink width' })
vim.keymap.set('n', '<C-A-L>', function() vim.cmd('wincmd >') end, { silent = true, desc = 'Window: grow widtg' })

vim.keymap.set('n', '<A-space>', function() vim.cmd('vsplit') end, { silent = true, desc = 'Vertical split' })

-- Open a terminal window
local SHELL = os.getenv('SHELL')
vim.keymap.set('n', '<A-CR>', function()
    vim.cmd('vsplit term://' .. SHELL )
    vim.cmd('norm i')
end, { desc = 'Open a terminal in a vertical split' })
vim.keymap.set('n', '<leader><A-CR>', function()
    vim.cmd('e term://' .. SHELL )
    vim.cmd('norm i')
end, { desc = 'Open a terminal in the current window' })

-- Move a line
vim.keymap.set('n', '<C-k>', ':m -2<CR>', { silent = true, desc = 'Move line up' })
vim.keymap.set('n', '<C-j>', ':m +1<CR>', { silent = true, desc = 'Move line down' })

vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = 'Go to next quickfix' })
vim.keymap.set('n', '<leader>cp', ':cprev<CR>', { desc = 'Go to previous quickfix' })

vim.keymap.set('n', '<leader>pv', function() vim.cmd('Ex') end, { desc = 'Open file explorer' })

vim.keymap.set('n', '<leader>l', function() vim.cmd('noh') end, { desc = 'Hide search highlights' })

-- Lsp
vim.keymap.set('n', 'K',           function() vim.lsp.buf.hover() end,         { desc = 'Lsp: hover' })
vim.keymap.set('n', '<leader>vd',  function() vim.diagnostic.open_float() end, { desc = 'Lsp: show diagnostic' })
vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end,   { desc = 'Lsp: show code actions' })
vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end,        { desc = 'Lsp: rename' })
