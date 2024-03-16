-- Use control+C to escape insert mode
vim.keymap.set('i', '<C-c>', '<esc>')

vim.keymap.set('n', '<A-k>', function() vim.cmd.wincmd('k') end, { silent = true, desc = 'Window: focus up' })
vim.keymap.set('n', '<A-j>', function() vim.cmd.wincmd('j') end, { silent = true, desc = 'Window: focus down' })
vim.keymap.set('n', '<A-h>', function() vim.cmd.wincmd('h') end, { silent = true, desc = 'Window: focus left' })
vim.keymap.set('n', '<A-l>', function() vim.cmd.wincmd('l') end, { silent = true, desc = 'Window: focus right' })

vim.keymap.set('n', '<A-K>', function() vim.cmd.wincmd('K') end, { silent = true, desc = 'Window: move up' })
vim.keymap.set('n', '<A-J>', function() vim.cmd.wincmd('J') end, { silent = true, desc = 'Window: move down' })
vim.keymap.set('n', '<A-H>', function() vim.cmd.wincmd('H') end, { silent = true, desc = 'Window: move left' })
vim.keymap.set('n', '<A-L>', function() vim.cmd.wincmd('L') end, { silent = true, desc = 'Window: move right' })

-- Resize window
vim.keymap.set('n', '<C-A-K>', function() vim.cmd.wincmd('+') end, { silent = true, desc = 'Window: grow height' })
vim.keymap.set('n', '<C-A-J>', function() vim.cmd.wincmd('-') end, { silent = true, desc = 'Window: shrink height' })
vim.keymap.set('n', '<C-A-H>', function() vim.cmd.wincmd('<') end, { silent = true, desc = 'Window: shrink width' })
vim.keymap.set('n', '<C-A-L>', function() vim.cmd.wincmd('>') end, { silent = true, desc = 'Window: grow widtg' })

vim.keymap.set('n', '<A-space>', vim.cmd.vsplit, { silent = true, desc = 'Vertical split' })

local SHELL = os.getenv('SHELL')
vim.keymap.set('n', '<A-CR>', function()
    vim.cmd.vsplit('term://' .. SHELL)
    vim.cmd.normal('i')
end, { desc = 'Terminal: open a terminal in a vertical split' })
vim.keymap.set('n', '<leader><A-CR>', function()
    vim.cmd.edit('term://' .. SHELL)
    vim.cmd.norm('i')
end, { desc = 'Terminal: open a terminal in the current window' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Terminal: escape the terminal' })

vim.keymap.set('n', '<C-k>', function() vim.cmd.move('-2<CR>') end, { silent = true, desc = 'Move line up' })
vim.keymap.set('n', '<C-j>', function() vim.cmd.move('+1<CR>') end, { silent = true, desc = 'Move line down' })

-- Display only the error message instead of the entire traceback
local function safe_call(func)
    return function()
        local status, error = pcall(func)
        if not status then
            vim.api.nvim_err_writeln(error)
        end
    end
end
vim.keymap.set('n', '<leader>n', safe_call(vim.cmd.cnext), { desc = 'Go to next quickfix' })
vim.keymap.set('n', '<leader>p', safe_call(vim.cmd.cprev), { desc = 'Go to previous quickfix' })

vim.keymap.set('n', '<leader>x', vim.cmd.Ex, { desc = 'Open file explorer' })

vim.keymap.set('n', '<leader>l', vim.cmd.nohlsearch, { desc = 'Hide search highlights' })

-- Lsp
vim.keymap.set('n', 'K',           vim.lsp.buf.hover,         { desc = 'Lsp: hover' })
vim.keymap.set('n', '<leader>vd',  vim.diagnostic.open_float, { desc = 'Lsp: show diagnostic' })
vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action,   { desc = 'Lsp: show code actions' })
vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename,        { desc = 'Lsp: rename' })
vim.keymap.set('n', 'gD',          vim.lsp.buf.declaration,   { desc = 'Lsp: go to declaration' })
