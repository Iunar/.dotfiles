local cmp = require("cmp")
cmp.setup({
 	-- Required
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-a>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-,"] = cmp.mapping.scroll_docs(-1),
		["<C-."] = cmp.mapping.scroll_docs(1),
	}),
	sources = cmp.config.sources({
		{ name = "luasnip" }
	},{
		{ name = "buffer" }
	})
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["clangd"].setup {
	capabilities = capabilities
}
require("lspconfig")["ols"].setup {
	capabilities = capabilities
}
require("lspconfig")["lua_ls"].setup {
	capabilities = capabilities
}
