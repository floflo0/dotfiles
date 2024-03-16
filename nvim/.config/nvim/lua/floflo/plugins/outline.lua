return {
    'hedyhli/outline.nvim',
    event = 'VeryLazy',
    config = function()
        require('outline').setup({
            symbols = {
                icons = {
                    File          = { icon = '󰈙', hl = 'Identifier' },
                    Module        = { icon = '', hl = 'Include' },
                    Namespace     = { icon = '', hl = 'Include' },
                    Package       = { icon = '', hl = 'Include' },
                    Class         = { icon = '󰠱', hl = 'Type' },
                    Method        = { icon = '󰊕', hl = 'Function' },
                    Property      = { icon = '󰜢', hl = 'Identifier' },
                    Field         = { icon = '󰜢', hl = 'Identifier' },
                    Constructor   = { icon = '', hl = 'Special' },
                    Enum          = { icon = '', hl = 'Type' },
                    Interface     = { icon = '', hl = 'Type' },
                    Function      = { icon = '󰊕', hl = 'Function' },
                    Variable      = { icon = '󰀫', hl = 'Constant' },
                    Constant      = { icon = '󰏿', hl = 'Constant' },
                    String        = { icon = '𝓐', hl = 'String' },
                    Number        = { icon = '#', hl = 'Number' },
                    Boolean       = { icon = '⊨', hl = 'Boolean' },
                    Array         = { icon = '󰅪', hl = 'Constant' },
                    Object        = { icon = '⦿', hl = 'Type' },
                    Key           = { icon = '󰌋', hl = 'Type' },
                    Null          = { icon = 'N', hl = 'Type' },
                    EnumMember    = { icon = '', hl = 'Identifier' },
                    Struct        = { icon = '󰙅', hl = 'Structure' },
                    Event         = { icon = '', hl = 'Type' },
                    Operator      = { icon = '󰆕', hl = 'Identifier' },
                    TypeParameter = { icon = '𝙏', hl = 'Identifier' },
                    Component     = { icon = '󰅴', hl = 'Function' },
                    Fragment      = { icon = '󰅴', hl = 'Constant' },
                    TypeAlias     = { icon = ' ', hl = 'Type' },
                    Parameter     = { icon = ' ', hl = 'Identifier' },
                    StaticMethod  = { icon = ' ', hl = 'Function' },
                    Macro         = { icon = ' ', hl = 'Function' },
                }
            }
        })

        vim.keymap.set('n', '<C-t>', vim.cmd.Outline, {
            desc = 'Lsp: show symbols tree'
        })
    end
}
