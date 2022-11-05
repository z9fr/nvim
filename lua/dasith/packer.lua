return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use 'folke/tokyonight.nvim'

    use({ 'rose-pine/neovim', as = 'rose-pine' })
     use({"catppuccin/nvim", as = "catppuccin" })
end)

