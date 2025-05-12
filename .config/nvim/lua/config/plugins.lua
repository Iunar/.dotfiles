require("config.lazy")

-- Setup lazy.nvim
require("lazy").setup({
	{
		"navarasu/onedark.nvim",
		--init = function()
			--vim.cmd("colorscheme onedark")
		--end
	},
    {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			no_italic = true,
			term_colors = true,
			transparent_background = true,
			styles = {
				comments = {},
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
			},
			color_overrides = {
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
			integrations = {
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				dropbar = {
					enabled = true,
					color_mode = true,
				},
			},
		},
        init = function()
            vim.cmd("colorscheme catppuccin-mocha")
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
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                -- height and width can be:
                -- * an absolute number of cells when > 1
                -- * a percentage of the width / height of the editor when <= 1
                -- * a function that returns the width or the height
                width = 80, -- width of the Zen window
                height = 1, -- height of the Zen window
                -- by default, no options are changed for the Zen window
                -- uncomment any of the options below, or add other vim.wo options you want to apply
                options = {
                    cursorcolumn = true, -- disable cursor column
                },
            },
        }
    }
	--[[------------------------------]]--
})

