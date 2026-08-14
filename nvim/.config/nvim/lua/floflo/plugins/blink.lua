local winblend
if vim.g.neovide then
    winblend = 80
else
    winblend = 0
end

return {
    'saghen/blink.cmp',
    enabled = true,
    lazy = false,
    version = '1.*',
    dependencies = {
        'neovim/nvim-lspconfig',
        'moyiz/blink-emoji.nvim',
        'rafamadriz/friendly-snippets',
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'enter',
            ['<C-k>'] = false,
            ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            list = { max_items = 100 },
            documentation = {
                auto_show = true,
                window = { winblend = winblend },
            },
            menu = {
                winblend = winblend,
                auto_show = true,
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", gap = 1, "kind", "source_name" },
                    },
                    components = {
                        source_name = {
                            width = { max = 30 },
                            text = function(ctx)
                                if ctx.source_name == 'LSP' then
                                    return ctx.item.client_name
                                end
                                return ctx.source_name
                            end,
                            highlight = 'BlinkCmpSource',
                        },
                    },
                },
            },
            ghost_text = { enabled = true },
            accept = {
                auto_brackets = {
                    blocked_filetypes = { "kotlin" },
                };
            },
        },
        sources = {
            -- default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji' },
            default = { 'lsp', 'path', 'buffer', 'emoji' },
            per_filetype = {
                lua = { inherit_defaults = true, 'lazydev' }
            },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
                emoji = {
                    module = 'blink-emoji',
                    name = 'Emoji',
                    score_offset = 15,
                    min_keyword_length = 1,
                    opts = {
                        insert = true,
                        ---@type string|table|fun():table
                        trigger = function()
                            return { ':' }
                        end,
                    },
                    should_show_items = function()
                        return vim.tbl_contains(
                            { 'gitcommit', 'markdown' },
                            vim.o.filetype
                        )
                    end,
                },
            },
        },
        signature = {
            enabled = true,
            window = {
                winblend = winblend,
                direction_priority = { 's', 'n' },
                show_documentation = true,
            },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        cmdline = {
            keymap = { preset = 'cmdline' },
            completion = {
                list = {
                    selection = { preselect = false },
                },
                menu = { auto_show = true },
            },
        },
    },
}
