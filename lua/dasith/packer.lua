-- This file can be loaded by calling `lua require('plugins')` from your init.vim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }


  use({ 
	  'rose-pine/neovim',
	  as = 'rose-pine' 
  })

   vim.cmd('colorscheme rose-pine')

   use('nvim-treesitter/nvim-treesitter')
   use('nvim-treesitter/playground')

   use {
	   'nvim-treesitter/nvim-treesitter',
	   run = function()
		   local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		   ts_update()
	   end,}

end)
