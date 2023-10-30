local gitsigns = require('gitsigns')

gitsigns.setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol'
	},
	current_line_blame_formatter = '<author>, <summary> - <author_time:%Y-%m-%d>'
})
