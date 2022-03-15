" init.vim

" permet de charger les ficher de configuration .nvimrc dans les dossier
set exrc

" active l'utilisation de la souris
set mouse=a
" couper les lignes trop long
set linebreak
" affiche les numéros de lignes
set number
" affiche les numéros de lignes relatifs
set relativenumber

" permet de ne pas garder surligner la recherche
set nohlsearch
" desactiver le saut du curseur vers la parenthèse corresspondante
set noshowmatch

" pour que :find cherche récursivement dans les dossiers
set path+=**
" ignorer certains dossiers/fichiers
set wildignore+=*.pyc
set wildignore+=**/.git/*

" espcace pour les tabulations
set expandtab
" longueur des tabulations
set tabstop=4 softtabstop=4
" nombre d'espcace pour l'auto indentation
set shiftwidth=4
" indent la nouvel ligne en fonction de la précédente
set autoindent
set smartindent

" désactive les bip
set noerrorbells

" Scroll automatiquement a partir la ligne
set scrolloff=8

" ajoute une ligne colorer a 80 charactères
set colorcolumn=80
" affiche les espaces et les tabulations
set list
" utilise le clipboard du system
set clipboard=unnamedplus

" ???
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" ajoute la colone de gauche pour les messages d'erreurs
set signcolumn=yes

" permet d'afficher les couleur
set termguicolors

" enlève la banière dans l'explorateur de fichier
let g:netrw_banner=0

call plug#begin('~/.vim/plugged')
" Fermer automatiquement les parentheses
" Plug 'jiangmiao/auto-pairs'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" pour faire marcher l'autocompletion
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'

" git plugin
Plug 'tpope/vim-fugitive'

" theme de couleur
Plug 'romgrk/doom-one.vim'

call plug#end()


" theme de couleur
let g:doom_one_terminal_colors = v:true
colorscheme doom-one

" autocompletion
lua << EOF
local cmp = require('cmp')

 cmp.setup({
     snippet = {
         expand = function(args)
           require'snippy'.expand_snippet(args.body)
         end,
     },
     mapping = {
       ['<C-d>'] = cmp.mapping.scroll_docs(-4),
       ['<C-f>'] = cmp.mapping.scroll_docs(4),
       ['<C-Space>'] = cmp.mapping.complete(),
       ['<C-e>'] = cmp.mapping.close(),
       ['<CR>'] = cmp.mapping.confirm({ select = true }),
     },
     sources = {
       { name = 'nvim_lsp' }, { name = 'snippy' }, { name = 'buffer' },
     }
   })

local function config(_config)
     return vim.tbl_deep_extend("force", {
         capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
     }, _config or {})
end

local lspconfig = require('lspconfig')

lspconfig.pyright.setup(config())
lspconfig.pylsp.setup(config())
lspconfig.bashls.setup(config())
lspconfig.tsserver.setup(config())
lspconfig.clangd.setup(config())
EOF

" retire les espaces en trop quand on enregistre
autocmd BufWritePre * %s/\s\+$//e

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

command! -nargs=* Rename call RenameFile()

