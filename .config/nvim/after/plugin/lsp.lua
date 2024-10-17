--[[
local lspcfg = require("lspconfig")

lspcfg.lua_ls.setup{
	opts = {
		inlay_hints = { enabled = true },
	}
}
lspcfg.clangd.setup{
	opts = {
		inlay_hints = { enabled = true },
	}
}
lspcfg.ols.setup{
	opts = {
		inlay_hints = { enabled = true },
	}
}
]]--
