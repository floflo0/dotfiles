local term = nil
local term_float = nil

return {
    'akinsho/toggleterm.nvim',
    opts = {
        size = function(terminal)
            if terminal.direction == 'horizontal' then
                return 15
            elseif terminal.direction == 'vertical' then
                return vim.o.columns * 0.4
            end
        end,
        shade_terminals = false,
    },
    keys = {
        {
            '<C-CR>',
            function()
                if term == nil or term. ht then
                    local Terminal = require('toggleterm.terminal').Terminal
                    term = Terminal:new({
                        direction = 'vertical',
                        on_exit = function ()
                            term = nil
                        end,
                    })
                end
                term:toggle()
            end,
            mode = { 'n', 't' },
            desc = 'Terminal: toggle',
        },
        {
            '<C-BS>',
            function()
                if term_float == nil then
                    local Terminal = require('toggleterm.terminal').Terminal
                    term_float = Terminal:new({
                        direction = 'float',
                        float_opts = { border = 'rounded' },
                        on_exit = function ()
                            term_float = nil
                        end,
                    })
                end
                term_float:toggle()
            end,
            mode = { 'n', 't' },
            desc = 'Terminal: toggle float',
        },
    },
}
