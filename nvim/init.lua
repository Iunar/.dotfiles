require("tman.options")
require("tman.plugins")
require("tman.keymap")
require("tman.telescope")
require("tman.lsp-cmp")
require("tman.treesitter")
require("tman.fold")

vim.opt.conceallevel = 1

-- require("tman.obsidian")

vim.cmd("set termguicolors")
vim.cmd("set t_Co=256")

--vim.cmd("colorscheme rose-pine-main")

vim.cmd("let g:gruvbox_contrast_dark='hard'")
vim.cmd("colorscheme gruvbox")

---- Transparent background
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
