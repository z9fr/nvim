return {
	{
		'nvim-orgmode/orgmode',
		dependencies = {
			{ 'nvim-treesitter/nvim-treesitter', lazy = true },
		},
		config = function()
			require('orgmode').setup_ts_grammar()
			require('orgmode').setup({
				org_agenda_files = '~/sync/org/**/*',
				org_default_notes_file = '~/sync/org/refile.org',
				org_agenda_span = 'week',
				org_capture_templates = {
					T = {
						description = 'Todo',
						template = '* TODO %?\n %u',
						target = '~/sync/org/todo.org'
					},
					j = {
						description = 'Journal',
						template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
						target = '~/sync/org/journal.org'
					},
					n = {
						description = 'Notes',
						template = '* %?\n %u',
						target = '~/sync/org/notes.org'
					}
				}
			})
		end,
	},
	{
		'akinsho/org-bullets.nvim',
		ft = { 'org' },
		config = function()
			require("org-bullets").setup {
				concealcursor = true, -- If false then when the cursor is on a line underlying characters are visible
				symbols = {
					list = "•",
					headlines = { "◉", "○", "✸", "✿" },
					checkboxes = {
						half = { "", "OrgTSCheckboxHalfChecked" },
						done = { "✓", "OrgDone" },
						todo = { "×", "OrgTODO" },
					},
				}
			}
		end
	},
}
