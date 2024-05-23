function set_scheme(scheme, transparent)
	-- Scheme
	if scheme == nil then 
		vim.cmd.colorscheme("quiet")
	else
		vim.cmd.colorscheme(scheme)
	end

	-- Transparency
	if transparent then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end
