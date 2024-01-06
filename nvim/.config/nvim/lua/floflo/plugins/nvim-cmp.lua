local HOME = os.getenv('HOME')

return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        {
            'L3MON4D3/LuaSnip',
            dependencies = { 'rafamadriz/friendly-snippets' },
            version = 'v2.*',
            build = 'make install_jsregexp',
            config = function()
                local luasnip = require('luasnip')
                vim.keymap.set('i', '<Tab>', function()
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        return '<Tab>'
                    end
                end, { silent = true, noremap = true, expr = true })
                vim.keymap.set('s', '<Tab>', function()
                    luasnip.jump(1)
                end, { silent = true, noremap = true })
                vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
                    luasnip.jump(-1)
                end, { silent = true, noremap = true })

                vim.keymap.set({ 'i', 's' }, '<C-E>', function()
                    if luasnip.choice_active() then
                        luasnip.next_choice()
                    end
                end, { silent = true, noremap = true })

                require('luasnip.loaders.from_vscode').lazy_load({
                    include = { 'html', 'markdown' }
                })
            end
        },
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind.nvim'
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },

            window = {},
            mapping = cmp.mapping.preset.insert({

                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true })
            }),

            formatting = {
                format = require('lspkind').cmp_format({
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
                { name = 'luasnip' },
                { name = 'path' }
            }, {
                { name = 'buffer', keyword_length = 5 }
            }),

            experimental = {
                ghost_text = true
            }
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({}, {
                { name = 'buffer' },
            })
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'nvim_lsp_document_symbol' }
            }, {
                { name = 'buffer' },
            })
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = {}
                    }
                }
            })
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local function config(_config)
            return vim.tbl_deep_extend('force', {
                capabilities = cmp_nvim_lsp.default_capabilities(),
                on_attach = function()
                end,
            }, _config or {})
        end

        local lspconfig = require('lspconfig')

        lspconfig.pylsp.setup(config({
            settings = {
                pylsp = {
                    plugins = {
                        pylint = {
                            enabled = false,
                            executable = 'pylint'
                        },
                        pycodestyle = { enabled = false },
                    }
                }
            }
        }))

        lspconfig.bashls.setup(config())

        lspconfig.tsserver.setup(config())
        lspconfig.html.setup(config())
        lspconfig.cssls.setup(config())
        lspconfig.jsonls.setup(config())
        lspconfig.eslint.setup(config())
        lspconfig.volar.setup(config({
            filetypes = {
                -- 'typescript',
                -- 'javascript',
                -- 'javascriptreact',
                -- 'typescriptreact',
                'vue',
                -- 'json'
            }
        }))
        lspconfig.tailwindcss.setup(config())

        lspconfig.clangd.setup(config({
            cmd = { 'clangd', '--enable-config', '-header-insertion=never' }
        }))

        lspconfig.glsl_analyzer.setup(config())

        lspconfig.rust_analyzer.setup(config())

        lspconfig.gopls.setup(config({
            cmd = { HOME .. '/go/bin/gopls' }
        }))

        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }

        lspconfig.intelephense.setup(config())

        lspconfig.marksman.setup(config())

        lspconfig.jdtls.setup(config({
            cmd = {
                'jdtls',
                '-configuration', HOME .. '/.cache/jdtls/config',
                '-data', HOME .. '/.cache/jdtls/workspace'
            }
        }))
    end
}
