-- affiche les numéros de lignes
vim.opt.number = true
-- affiche les numéros de lignes relatifs
vim.opt.relativenumber = true

-- active l'utilisation de la souris
vim.opt.mouse = "a"

-- couper les lignes trop longues par mot
vim.opt.linebreak = true

-- permet de ne pas garder surligné les résultats de recherche
vim.opt.hlsearch = false

-- pour que :find recherche récursivement dans les dossiers
print(vim.opt.path)
vim.opt.path:append("**")
print(vim.opt.path)

-- ignorer certains dossiers/fichiers
vim.opt.wildignore:append("*.pyc")
vim.opt.wildignore:append("**/.git/*")

-- longueur des tabulations
local tab = 4
vim.opt.tabstop = tab
vim.opt.softtabstop = tab
vim.opt.shiftwidth = tab
vim.opt.expandtab = true
vim.opt.smartindent = true

-- scroll de la fençetre à partir de n lignes du bord
vim.opt.scrolloff = 8

-- ajoute une ligne colorée à 80 caractères
vim.opt.colorcolumn = "80"

-- affiche les espaces et les tabulations
vim.opt.list = true
-- TODO: change tab char

-- utilise le clipboard du système
vim.opt.clipboard = "unnamedplus"

vim.opt.swapfile = false
vim.opt.backup = false
-- sauvegarder l'historique des annulations dans un ficher
vim.opt.undofile = true
-- où mettre l'historique des annulations
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"

-- ajoute la colone de gauche pour les messages d'erreurs
vim.opt.signcolumn = "yes"

-- permet d'afficher les couleur
vim.opt.termguicolors = true

vim.g.mapleader = " "

-- enlève la banière dans l'explorateur de fichier
vim.g.netrw_banner = 0
