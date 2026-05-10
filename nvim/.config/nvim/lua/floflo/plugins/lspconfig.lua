local HOME = os.getenv('HOME')

return {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
        local lspconfig = require('lspconfig')

        vim.lsp.enable('lua_ls')
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        disable = { 'missing-fields' },
                    },
                },
            },
        })

        vim.lsp.enable('clangd')
        vim.lsp.config('clangd', {
            cmd = {
                'clangd',
                '--enable-config',
                '--header-insertion=iwyu',
                '--completion-style=detailed',
                '--clang-tidy',
                '--background-index',
            },
        })

        vim.lsp.enable('cmake')

        vim.lsp.enable('glsl_analyzer')

        vim.lsp.enable('html')
        -- vim.lsp.enable('emmet_language_server')
        -- vim.lsp.config('emmet_language_server', {
        --     filetypes = {
        --         'css',
        --         'eruby',
        --         'html',
        --         'htmldjango',
        --         'javascriptreact',
        --         'less',
        --         'pug',
        --         'sass',
        --         'scss',
        --         'typescriptreact',
        --         'htmlangular',
        --         'php'
        --     },
        -- })
        vim.lsp.enable('cssls')
        vim.lsp.enable('jsonls')
        vim.lsp.enable('yamlls')
        vim.lsp.enable('eslint')
        vim.lsp.enable('vtsls')
        local vue_plugin = {
            name = '@vue/typescript-plugin',
            location = '/usr/lib/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
        }
        vim.lsp.config('vtsls', {
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {
                            vue_plugin,
                        },
                    },
                },
            },
            filetypes = {
                'typescript',
                'javascript',
                'javascriptreact',
                'typescriptreact',
                'vue',
            },
        })
        vim.lsp.enable('vue_ls')
        vim.lsp.config('vue_ls', {
            filetypes = {
                'vue',
            },
            init_options = {
                typescript = {
                    tsdk = '/usr/lib/node_modules/typescript/lib/'
                }
            }
        })
        vim.lsp.enable('tailwindcss')
        vim.lsp.config('tailwindcss', {
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
        })
        vim.lsp.enable('angularls')

        -- vim.lsp.enable('pylsp')
        vim.lsp.config('pylsp', {
            settings = {
                pylsp = {
                    plugins = {
                        autopep8 = { enabled = false },
                        pyflakes = { enabled = false },
                        pylint = {
                            enabled = true,
                            executable = 'pylint',
                            args = {
                                '--disable=missing-function-docstring,missing-module-docstring,missing-class-docstring,too-few-public-methods',
                            },
                        },
                        pycodestyle = { enabled = false },
                        pylsp_mypy = {
                            enabled = true,
                            report_progress = true,
                            live_mode = false,
                            dmypy = true,
                        },
                        mccabe = { enabled = false },
                        preload = { enabled = false },
                        yapf = { enabled = false },
                    }
                }
            },
            flags = {
                debounce_text_changes = 200
            }
        })
        vim.lsp.enable('ty')
        vim.lsp.enable('ruff')

        vim.lsp.enable('bashls')
        vim.lsp.enable('fish_lsp')

        vim.lsp.enable('rust_analyzer')
        -- vim.lsp.config('rust_analyzer', {
        --     textDocument = {
        --         completion = {
        --             completionItem = {
        --                 snippetSupport = false,
        --             },
        --         },
        --     }
        -- })

        vim.lsp.enable('gopls')

        vim.lsp.enable('intelephense')

        vim.lsp.enable('jdtls')
        vim.lsp.config('jdtls', {
            cmd = {
                'jdtls',
                '-configuration', HOME .. '/.cache/jdtls/config',
                '-data', HOME .. '/.cache/jdtls/workspace'
            }
        })
        vim.lsp.enable('kotlin_language_server')
        vim.lsp.enable('gradle_ls')

        vim.lsp.enable('ansiblels')

        vim.lsp.enable('tinymist')

        vim.lsp.enable('ocamllsp')
    end,
}
