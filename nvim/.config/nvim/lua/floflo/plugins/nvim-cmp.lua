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
        'ray-x/lsp_signature.nvim',
        'L3MON4D3/LuaSnip',
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
                    menu = {
                        nvim_lua = '[Lua]',
                        nvim_lsp = '[Lsp]',
                        nvim_lsp_document_symbol = '[Lsp]',
                        nvim_lsp_signature_help = '[Help]',
                        luasnip = '[LuaSnip]',
                        path = '[Path]',
                        buffer = '[Buffer]',
                        cmdline = '[Cmd]'
                    }
                })
            },

            sources = cmp.config.sources({
                { name = 'nvim_lua' },
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 3 },
                { name = 'path' }
            }, {
                { name = 'buffer', keyword_length = 2 }
            }),

            experimental = {
                ghost_text = true
            }
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({}, {
                { name = 'buffer' }
            })
        })

        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'nvim_lsp_document_symbol' }
            }, {
                { name = 'buffer' }
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

        local lsp_signature = require('lsp_signature')

        vim.keymap.set({ 'n', 'i' }, '<C-b>', lsp_signature.toggle_float_win, {
            silent = true,
            noremap = true,
            desc = 'Lsp: toggle signature'
        })

        local function config(_config)
            return vim.tbl_deep_extend('force', {
                capabilities = cmp_nvim_lsp.default_capabilities(),
                on_attach = function(_, bufnr)
                    lsp_signature.on_attach({}, bufnr)
                end
            }, _config or {})
        end

        local lspconfig = require('lspconfig')

        lspconfig.pylsp.setup(config({
            settings = {
                pylsp = {
                    plugins = {
                        autopep8 = { enabled = false },
                        pyflakes = { enabled = false },
                        pylint = {
                            enabled = true,
                            executable = 'pylint'
                        },
                        pycodestyle = { enabled = false },
                        pylsp_mypy = {
                            enabled = true,
                            report_progress = true
                        },
                        mccabe = { enabled = false }
                    }
                }
            },
            flags = {
                debounce_text_changes = 200
            }
        }))

        lspconfig.bashls.setup(config())
        lspconfig.fish_lsp.setup(config())

        lspconfig.ts_ls.setup(config({
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = '/usr/lib/node_modules/@vue/typescript-plugin',
                        languages = { 'vue' }
                    }
                }
            },
            filetypes = {
                'javascript',
                'javascriptreact',
                'javascript.jsx',
                'typescript',
                'typescriptreact',
                'typescript.tsx',
                'vue'
            }
        }))
        lspconfig.html.setup(config())
        lspconfig.emmet_language_server.setup(config({
            filetypes = {
                'css',
                'eruby',
                'html',
                'htmldjango',
                'javascriptreact',
                'less',
                'pug',
                'sass',
                'scss',
                'typescriptreact',
                'htmlangular',
                'php'
            }
        }))
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
            },
            init_options = {
                typescript = {
                    tsdk = '/usr/lib/node_modules/typescript/lib/'
                }
            }
        }))
        lspconfig.tailwindcss.setup(config({
            root_dir = lspconfig.util.root_pattern(
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.mjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.cjs',
            'postcss.config.mjs',
            'postcss.config.ts'
            )
        }))

        lspconfig.clangd.setup(config({
            cmd = { 'clangd', '--enable-config', '-header-insertion=never' }
        }))
        lspconfig.cmake.setup(config())

        lspconfig.glsl_analyzer.setup(config())

        lspconfig.rust_analyzer.setup(config({
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = false,
                    },
                },
            }
        }))

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
                        disable = { 'missing-fields' },
                        globals = { 'vim' }
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            '${3rd}/luv/library',
                            '${3rd}/busted/library',
                            unpack(vim.api.nvim_get_runtime_file('', true))
                        }
                    },
                    telemetry = {
                        enable = false
                    }
                }
            }
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

        -- TODO health
        lspconfig.ansiblels.setup(config())
    end
}
