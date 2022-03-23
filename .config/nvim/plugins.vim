" plugins.vim

" Installer vim-plug
" $ yay -S vim-plug

" Installer les plugins
" :PlugInstall

" Dépendences:
" - ripgrep: pour telescope

call plug#begin('~/.vim/plugged')
" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" pour faire marcher l'autocompletion
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'

" theme de couleur
Plug 'romgrk/doom-one.vim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" git plugin
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

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
           require('snippy').expand_snippet(args.body)
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

local telescope = require("telescope")
telescope.setup{}
EOF

" Ctr+P pour telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({no_ignore=true, find_command={'rg', '--files', '--hidden', '-g', '!.git', '-g', '!__pycache__', '-g', '!.mypy_cache', '-g', '!*.png'}})<CR>

nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :Git commit<CR>
