return {
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = function()
			vim.defer_fn(function()
				require('nvim-treesitter.configs').setup {
					-- Add languages to be installed here that you want installed for treesitter
					ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript',
						'vimdoc', 'vim', 'query', 'bash' },

					auto_install = true,

					highlight = { enable = true },
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = '<c-space>',
							node_incremental = '<c-space>',
							scope_incremental = '<c-s>',
							node_decremental = '<M-space>',
						},
					},
					textobjects = {
						select = {
							enable = true,
							lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
							keymaps = {
								-- You can use the capture groups defined in textobjects.scm
								['aa'] = '@parameter.outer',
								['ia'] = '@parameter.inner',
								['af'] = '@function.outer',
								['if'] = '@function.inner',
								['ac'] = '@class.outer',
								['ic'] = '@class.inner',
							},
						},
						move = {
							enable = true,
							set_jumps = true, -- whether to set jumps in the jumplist
							goto_next_start = {
								[']m'] = '@function.outer',
								[']]'] = '@class.outer',
							},
							goto_next_end = {
								[']M'] = '@function.outer',
								[']['] = '@class.outer',
							},
							goto_previous_start = {
								['[m'] = '@function.outer',
								['[['] = '@class.outer',
							},
							goto_previous_end = {
								['[M'] = '@function.outer',
								['[]'] = '@class.outer',
							},
						},
						swap = {
							enable = true,
							swap_next = {
								['<leader>a'] = '@parameter.inner',
							},
							swap_previous = {
								['<leader>A'] = '@parameter.inner',
							},
						},
					},
				}
			end, 0)
		end,
	},
	{
		{
			'nvim-treesitter/nvim-treesitter-context',
			config = function()
				require 'treesitter-context'.setup {
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
					min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
					line_numbers = true,
					multiline_threshold = 20, -- Maximum number of lines to show for a single context
					trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
					mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
					separator = nil,
					zindex = 20,
					on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
				}
			end
		}
	}

}
