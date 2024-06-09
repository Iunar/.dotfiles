lspcfg = require('lspconfig')

lspcfg.clangd.setup{
	on_attach = function()
		-- :h vim.lsp.buf...
		-- Set keys
		--vim.keymap.set('n', 'K', vim.lsp.buf.hover())
	end,
}
lspcfg.lua_ls.setup{}
lspcfg.gopls.setup{}
