return {
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
        end, { silent = true, noremap = true, desc = 'Snippet choice' })

        require('luasnip.loaders.from_vscode').lazy_load({
            include = { 'html', 'markdown' }
        })
    end
}
