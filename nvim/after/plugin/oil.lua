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

--[[ Fails rn
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	callback = function()
		buf_name = string.sub(vim.api.nvim_buf_get_name(0), 1, 3)
		if (buf_name == "oil") then
			oil.open_preview()
		end
	end
})
]]--
