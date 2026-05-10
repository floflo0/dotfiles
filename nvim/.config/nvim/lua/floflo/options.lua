vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = '↳ '

-- Show spaces and tabs
vim.opt.list = true
vim.opt.listchars = 'tab:» ,trail:-,eol:↵'

vim.opt.hlsearch = true

vim.opt.ignorecase = true  -- Ignore case when searching...
vim.opt.smartcase = true   -- ... unless there is a capital letter in the query

-- Recursive search for :find
vim.opt.path:append('**')
vim.opt.path:append('/usr/include')
vim.opt.path:append('/usr/local/include')

vim.opt.wildignore:append('*.pyc')
vim.opt.wildignore:append('**/.git/*')

local tab = 4
vim.opt.tabstop = tab
vim.opt.softtabstop = tab
vim.opt.shiftwidth = tab
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.scrolloff = 8

vim.opt.textwidth = 80
vim.opt.colorcolumn = '80'

-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'

-- Left column for error messages
vim.opt.signcolumn = 'yes'

vim.opt.cursorline = true
--  Only have it on in the active buffer
local group = vim.api.nvim_create_augroup('CursorLineControl', { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = function() vim.opt_local.cursorline = value end
    })
end
set_cursorline('WinLeave', false)
set_cursorline('WinEnter', true)
set_cursorline('FileType', false, 'TelescopePrompt')

vim.opt.formatoptions = vim.opt.formatoptions
    - 'a' -- Auto formatting is BAD.
    - 't' -- Don't auto format my code. I got linters for that.
    + 'q' -- Allow formatting comments with gq
    + 'n' -- Indent past the formatlistpat, not underneath it.
    + 'j' -- Auto-remove comments if possible.
    + 'c' -- In general, I like it when comments respect textwidth
    - 'o' -- O and o, don't continue comments
    + 'r' -- But do continue when pressing enter.
    + '2'
    + '/'

-- Floating window transparency
vim.opt.pumblend = 0
vim.opt.winblend = 0

vim.opt.termguicolors = true

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.netrw_banner = 0

vim.opt.showmode = false

-- Disable intro message
vim.opt.shortmess:append('I')

vim.opt.spelllang = 'fr'

-- Don't change my keymaps in sql files
vim.g.omni_sql_no_default_maps = true

vim.o.winborder = 'rounded'

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    severity_sort = true
})

vim.opt.makeprg = 'make -j $(nproc)'

vim.lsp.log.set_level(vim.log.levels.OFF)
vim.lsp.document_color.enable(true, {}, {
    style = 'virtual',
})

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.updatetime = 300

vim.opt.timeoutlen = 300
