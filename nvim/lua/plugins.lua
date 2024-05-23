local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Themes ----------------------------------------------------------
	{ 
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000 
	},
	--------------------------------------------------------------------

	--- Oil ------------------------------------------------------------
	{
		'stevearc/oil.nvim',
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	--------------------------------------------------------------------

	--- TreeSitter -----------------------------------------------------
	{
		'nvim-treesitter/nvim-treesitter',
	},
	--------------------------------------------------------------------

	--- LspConfig ------------------------------------------------------
	{
		'neovim/nvim-lspconfig',
	},
	--------------------------------------------------------------------

})
