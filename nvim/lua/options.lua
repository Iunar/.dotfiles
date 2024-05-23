---- Options ----------------------------------------
-- Disable backups
vim.o.backup = false
-- Column highlighting
vim.o.cc = "80"
-- Background
vim.o.bg = "dark"
-- C style indentation
vim.o.cin = true

-- Disable cursor column hl
vim.o.cuc = false
-- Enable cursor line hl
vim.o.cul = true

-- ShiftWidth & Tabstop
vim.o.sw = 4
vim.o.ts = 4

-- Relative line numbers
vim.o.nu = true
vim.o.rnu = true

-- Disable highlight when search
vim.o.hls = false
-- Ignore case in search patterns
vim.o.ic = true

-- Format options -> disable comment insert on newline
-- vim.opt.formatoptions:remove({"c","r","o"})
-- This doesnt work because it is immediatly overriden by the default
-- options in the default neovim ftplugin directory
-- Thus a autocmd must be used to overwrite it everytime a buffer is entered;
-- in this case it is fired any time a .c, .h, or .lua file is entered.
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.c", "*.h", "*.lua"},
	callback = function()
		vim.opt.formatoptions:remove({"c","r","o"})
	end
})
-----------------------------------------------------
