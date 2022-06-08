" init.vim

" Set
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
set autoindent smartindent
" désactive les bip
set noerrorbells
" Scroll automatiquement a partir la ligne
set scrolloff=8
" ajoute une ligne colorer a 80 charactères
set colorcolumn=80
" affiche les espaces et les tabulations
set list
" utilise le clipboard du système
set clipboard=unnamedplus
" ne fait pas swapfile
set noswapfile
" ne fait pas de ficher backup (évite les file.txt~)
set nobackup
" sauvegarder l'historique des annulations dans des fichers
set undofile
" où mettre l'hisotrique des annulations
set undodir=~/.cache/nvim/undodir
" ajoute la colone de gauche pour les messages d'erreurs
set signcolumn=yes
" permet d'afficher les couleur
set termguicolors

" theme de couleur
colorscheme desert

" enlève la banière dans l'explorateur de fichier
let g:netrw_banner=0

let mapleader = " "

" retire les espaces en trop quand on enregistre
autocmd BufWritePre * %s/\s\+$//e

" Command
" command pour renommer les fichiers
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

" vfind command
command! -nargs=1 -complete=file_in_path Vfin  vert sfind <args>
command! -nargs=1 -complete=file_in_path Vfind vert sfind <args>

" Keybings
" controler la gestion des fenetres avec Alt
" changer de fenêtre
nnoremap <silent> <A-k> :wincmd k<CR>
nnoremap <silent> <A-j> :wincmd j<CR>
nnoremap <silent> <A-h> :wincmd h<CR>
nnoremap <silent> <A-l> :wincmd l<CR>
" move windows
nnoremap <silent> <A-K> :wincmd K<CR>
nnoremap <silent> <A-J> :wincmd J<CR>
nnoremap <silent> <A-H> :wincmd H<CR>
nnoremap <silent> <A-L> :wincmd L<CR>
" redimensionner les fenêtres
nnoremap <silent> <C-A-K> :wincmd +<CR>
nnoremap <silent> <C-A-J> :wincmd -<CR>
nnoremap <silent> <C-A-H> :wincmd <<CR>
nnoremap <silent> <C-A-L> :wincmd ><CR>

" Alt-Enter open terminal in new window
nnoremap <silent> <A-t> :terminal<CR> :norm i<CR>
nnoremap <silent> <A-CR> :vsplit<CR> :terminal<CR> :wincmd L<CR> :norm i<CR>

nnoremap <silent> <A-SPACE> :vsplit<CR> :wincmd l<CR>

nnoremap <C-k> :m -2<CR>
nnoremap <C-j> :m +1<CR>

nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>

noremap <leader>r :!!<CR>
noremap <leader>m :mak<CR>
noremap <leader>M :mak!<CR>

" use Control-c to espcace modes
inoremap <C-c> <esc>

" Plugins
source ~/.config/nvim/plugins.vim

