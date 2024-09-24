-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- color scheme
    use { "ellisonleao/gruvbox.nvim" }

    -- treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = "nvim-treesitter",
    }

    use('mbbill/undotree')

    -- git
    use('lewis6991/gitsigns.nvim')
    use('tpope/vim-fugitive')

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },         -- Required
            { 'williamboman/mason.nvim' },       -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    }

    -- DAP
    use('mfussenegger/nvim-dap')

    -- Formatter
    use('stevearc/conform.nvim')

    -- Misc editor sugar
    use('numToStr/Comment.nvim')
    use('tpope/vim-sleuth')
    use('folke/neodev.nvim')
    use('nvim-lualine/lualine.nvim')
end)
