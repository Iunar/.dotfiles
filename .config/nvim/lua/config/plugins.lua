require("config.lazy")

-- Setup lazy.nvim
require("lazy").setup({
	{
		"navarasu/onedark.nvim",
		init = function()
			vim.cmd("colorscheme onedark")
		end
	},
	{ -- Lsp Config
		"neovim/nvim-lspconfig",
	},
	{ -- Mason (package manager for langauge servers, DAPs, and linters
		"williamboman/mason.nvim",
		init = function()
			require("mason").setup()
		end
	},
	--[[ Plugins needed for completion ]]--
	{
		'hrsh7th/cmp-nvim-lsp'
	},
	{
		'hrsh7th/cmp-buffer'
	},
	{
		'hrsh7th/cmp-path'
	},
	{
		'hrsh7th/cmp-cmdline'
	},
	{
		'hrsh7th/nvim-cmp'
	},
	{
		'L3MON4D3/LuaSnip'
	},
	{
		'saadparwaiz1/cmp_luasnip'
	},
	{ -- Telescope
		'nvim-telescope/telescope.nvim',
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"nvim-tree/nvim-web-devicons"
		},
	},
	{ -- Treesitter
		"nvim-treesitter/nvim-treesitter"
	},
	--[[------------------------------]]--
})

