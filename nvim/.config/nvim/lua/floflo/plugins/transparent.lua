return {
    'xiyaowong/transparent.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.transparent_enabled = not vim.g.neovide

        local extra_groups = {}
        if not vim.g.neovide then
            table.insert(extra_groups, 'NormalFloat')
        end

        local transparent = require('transparent')
        transparent.setup({
            extra_groups = extra_groups,
            exclude_groups = { 'CursorLine' }
        })

        transparent.clear_prefix('Trouble')
    end
}
