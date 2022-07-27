" plugins.vim

" Installer vim-plug
" yay -S vim-plug

" Colorscheme
" yay -S vim-dracula-git

" Installer les plugins
" :PlugInstall

" Dépendences:
" - ripgrep: pour telescope

call plug#begin('~/.vim/plugged')
" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" pour faire marcher l'autocompletion
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" git plugin
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Afficher les couleurs en css
Plug 'ap/vim-css-color'
call plug#end()

" theme de couleur
colorscheme dracula

" autocompletion
lua << EOF
  -- Setup nvim-cmp.
  local cmp = require('cmp')

  local source_mapping = {
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      path = "[Path]",
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),

  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = source_mapping[entry.source.name]
      return vim_item
    end,
  },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      -- { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  function CreateNoremap(type, opts)
    return function(lhs, rhs, bufnr)
      bufnr = bufnr or 0
      vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
    end
  end
  Nnoremap = CreateNoremap("n", { noremap = true })
  -- Inoremap = CreateNoremap("i", { noremap = true })

  -- Setup lspconfig.
  local function config(_config)
    return vim.tbl_deep_extend("force", {
      capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = function()
        Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
        Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
        -- Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
        Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
        -- Nnoremap("[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
        -- Nnoremap("]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
        Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
        Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
        Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
        -- Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
      end,
    }, _config or {})
  end

  local lspconfig = require('lspconfig')
  -- sudo pacman -S pyright
  lspconfig.pyright.setup(config())
  -- sudo pacman -S  jedi-language-server
  -- lspconfig.jedi_language_server.setup(config())
  -- lspconfig.pylsp.setup(config())
  -- sudo pacman -S bash-language-server
  lspconfig.bashls.setup(config())
  lspconfig.tsserver.setup(config())
  lspconfig.clangd.setup(config({
    cmd = { 'clangd', '-header-insertion=never' }
  }))
  lspconfig.rust_analyzer.setup(config())
  -- sudo npm i -g vscode-langservers-extracted
  lspconfig.cssls.setup(config())

  require('snippy').setup({
    mappings = {
      is = {
        ['<Tab>'] = 'expand_or_advance',
        ['<S-Tab>'] = 'previous',
      },
      nx = {
        ['<leader>x'] = 'cut_text',
      },
    },
  })
EOF

lua require("telescope").setup{}

" Ctr+P pour telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({no_ignore=true, find_command={'rg', '--files', '--hidden', '-g', '!.git', '-g', '!__pycache__', '-g', '!.mypy_cache', '-g', '!*.png', '-g', '!node_modules'}})<CR>
" nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gb :Git branch<CR>

