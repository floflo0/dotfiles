return {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = 'v2.*',
    build = 'make install_jsregexp',
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load({
            include = { 'html', 'markdown' }
        })
    end,
    keys = {
        {
            '<Tab>',
            function()
                local luasnip = require('luasnip')
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    return '<Tab>'
                end
            end,
            mode = 'i',
            silent = true,
            noremap = true,
            expr = true,
        },
        {
            '<Tab>',
            function() require('luasnip').jump(1) end,
            mode = 's',
            silent = true,
            noremap = true,
        },
        {
            '<S-Tab>',
            function() require('luasnip').jump(-1) end,
            mode = { 'i', 's' },
            silent = true,
            noremap = true,
        },
        {
            '<C-E>',
            function()
                local luasnip = require('luasnip')
                if luasnip.choice_active() then
                    luasnip.next_choice()
                end
            end,
            mode = { 'i', 's' },
            silent = true,
            noremap = true,
            desc = 'Snippet choice',
        },
    },
}
