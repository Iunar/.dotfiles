require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "lua", "odin" },
	auto_install = true,
	highlight = {
		enable = true,
	}
}

vim.cmd("TSUpdate")
