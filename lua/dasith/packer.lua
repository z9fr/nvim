return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use 'folke/tokyonight.nvim'

    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use({"catppuccin/nvim", as = "catppuccin" })

    -- All the things
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use "hrsh7th/nvim-cmp" --completion
 	use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    
    -- treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")
end)

