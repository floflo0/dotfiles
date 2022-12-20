-- Setup nvim-cmp.
local cmp = require('cmp')
-- lsp want this check
if cmp == nil then
    vim.api.nvim_err_writeln('Error: cmp is nil')
    return
end
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
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
        -- Accept currently selected item. Set `select` to `false` to only
        -- confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            menu = ({
                nvim_lua = '[Lua]',
                nvim_lsp = '[Lsp]',
                nvim_lsp_document_symbol = '[Lsp]',
                nvim_lsp_signature_help = '[Help]',
                luasnip = '[LuaSnip]',
                path = '[Path]',
                buffer = '[Buffer]',
                cmdline = '[Cmd]'
            })
        }),
    },

    sources = cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        -- { name = 'vsnip' }, -- For vsnip users.
        --
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.

        { name = 'path' }
    }, {
        { name = 'buffer', keyword_length = 5 }
    }),

    experimental = {
        ghost_text = true
    }
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
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = 'buffer' },
    })
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Setup lspconfig.
local function config(_config)
    return vim.tbl_deep_extend('force', {
        capabilities = cmp_nvim_lsp.default_capabilities(),
        on_attach = function()
        end,
    }, _config or {})
end

local lspconfig = require('lspconfig')

-- $ sudo pacman -S pyright
-- lspconfig.pyright.setup(config())

-- $ sudo pacman -S jedi-language-server
-- lspconfig.jedi_language_server.setup(config())

-- archlinux
-- $ sudo pacman -S python-lsp-server
-- $ yay -S python-pylsp-mypy python-pylsp-rope
-- ubuntu
-- $ sudo pip install python-lsp-server pylsp-mypy pylsp-rope
lspconfig.pylsp.setup(config({
    settings = {
        pylsp = {
            plugins = {
                pylint = {
                    enabled = true,
                    executable = 'pylint'
                },
                rope_completion = { enabled = true },
                rope = { ropeFolder = nil },
                pycodestyle = { enabled = false }
            }
        }
    }
}))

-- archlinux
-- $ sudo pacman -S bash-language-server
-- ubuntu
-- $ sudo npm install -g bash-language-server
lspconfig.bashls.setup(config())

-- archlinux
-- $ sudo pacman -S typescipt
-- $ sudo npm install -g typescript-language-server
lspconfig.tsserver.setup(config())

-- archlinux
-- $ sudo pacman -S clang
-- ubuntu
-- $ sudo apt install clangd
lspconfig.clangd.setup(config({
    cmd = { 'clangd', '-header-insertion=never' }
}))

-- $ sudo pacman -S rust-analyzer
lspconfig.rust_analyzer.setup(config())

-- $ sudo npm i -g vscode-langservers-extracted
lspconfig.html.setup(config())
lspconfig.cssls.setup(config())

-- $ sudo pacman -S lua-language-server
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- sudo npm install -g intelephense
lspconfig.intelephense.setup(config())

local snippets_paths = function()
    local plugins = { 'friendly-snippets' }
    local paths = {}
    local path
    local root_path = vim.env.HOME .. '/.local/share/nvim/site/pack/packer/start/'
    for _, plug in ipairs(plugins) do
        path = root_path .. plug
        if vim.fn.isdirectory(path) ~= 0 then
            table.insert(paths, path)
        end
    end
    return paths
end

require('luasnip.loaders.from_vscode').lazy_load({
    paths = snippets_paths(),
    include = { 'html' }, -- Load all languages
    exclude = {},
})
