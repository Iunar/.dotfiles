oil = require("oil")
oil.setup({

	default_file_explorer = true,
	skip_confirm_for_simple_edits = false,

	keymaps = {
		["<C-p>"] = "actions.preview",
		["<C-r>"] = "actions.refresh",
		["-"] = "actions.parent",
	},
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
