local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- autocompletion
    use('neovim/nvim-lspconfig')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lua')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/cmp-nvim-lsp-document-symbol')
    use('hrsh7th/cmp-nvim-lsp-signature-help')
    use('hrsh7th/nvim-cmp')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    use('onsails/lspkind.nvim')

    use('rafamadriz/friendly-snippets')

    use({ 'TimUntersberger/neogit', requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
    }})

    -- theme de couleur
    use({ 'dracula/vim', as = 'dracula' })
    use('navarasu/onedark.nvim')
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use({ 'catppuccin/nvim', as = 'catppuccin' })
    use('folke/tokyonight.nvim')
    use('gruvbox-community/gruvbox')

    use({
        'nvim-treesitter/nvim-treesitter',
	    run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end
    })

    use('numToStr/Comment.nvim')  -- comment code

    use('lukas-reineke/indent-blankline.nvim')

    use({
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons'
        }
    })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

    use('j-hui/fidget.nvim')

    -- Afficher les couleurs en css
    use('ap/vim-css-color')

    use('mbbill/undotree')

    use('Vonr/align.nvim')

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
