-- Installer packer:
-- $ yay -S nvim-packer-git
-- :PackerSync

return require('packer').startup(function(use)
    -- autocompletion
    use('neovim/nvim-lspconfig')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lua')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/cmp-nvim-lsp-document-symbol')
    use('hrsh7th/nvim-cmp')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')

    use('rafamadriz/friendly-snippets')

    use({ 'TimUntersberger/neogit', requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
    }})

    -- theme de couleur
    use({ 'dracula/vim', as = 'dracula' })

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

    use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires ='nvim-lua/plenary.nvim' })

    -- Afficher les couleurs en css
    use('ap/vim-css-color')
end)
