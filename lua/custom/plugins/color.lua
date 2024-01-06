return {
	'rose-pine/neovim',
	name = 'rose-pine',
	priority = 1000,
	opts = {
		disable_background = true
	},
	config = function()
		vim.cmd.colorscheme 'rose-pine'

		function ColorMyPencils(color)
			color = color or "rose-pine"
			vim.cmd.colorscheme(color)

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end

		ColorMyPencils()
	end,
}
