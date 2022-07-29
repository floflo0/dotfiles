-- affiche les numéros de lignes
vim.opt.number = true
-- affiche les numéros de lignes relatifs
vim.opt.relativenumber = true

-- active l'utilisation de la souris
vim.opt.mouse = 'a'

-- couper les lignes trop longues par mot
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = '↳ '

-- affiche les espaces et les tabulations
vim.opt.list = true

vim.opt.listchars = 'tab:» ,trail:-,eol:↵'

-- permet de ne pas garder surligné les résultats de recherche
vim.opt.hlsearch = false

vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query

vim.opt.splitright = true
vim.opt.splitbelow = true

-- pour que :find recherche récursivement dans les dossiers
vim.opt.path:append('**')

-- ignorer certains dossiers/fichiers
vim.opt.wildignore:append('*.pyc')
vim.opt.wildignore:append('**/.git/*')

-- longueur des tabulations
local tab = 4
vim.opt.tabstop = tab
vim.opt.softtabstop = tab
vim.opt.shiftwidth = tab
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- scroll de la fençetre à partir de n lignes du bord
vim.opt.scrolloff = 8

-- ajoute une ligne colorée à 80 caractères
vim.opt.textwidth = 80
vim.opt.colorcolumn = '80'

-- utilise le clipboard du système
vim.opt.clipboard = 'unnamedplus'

vim.opt.swapfile = false
vim.opt.backup = false
-- sauvegarder l'historique des annulations dans un ficher
vim.opt.undofile = true
-- où mettre l'historique des annulations
vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'

-- ajoute la colone de gauche pour les messages d'erreurs
vim.opt.signcolumn = 'yes'

-- surligne la ligne du curseur
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

-- transparence
vim.opt.pumblend = 15

-- permet d'afficher les couleur
vim.opt.termguicolors = true

vim.g.mapleader = ' '

-- enlève la banière dans l'explorateur de fichier
vim.g.netrw_banner = 0
