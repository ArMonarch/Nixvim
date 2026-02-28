---@brief
---
--- https://github.com/DanielGavin/ols
---
--- `Odin Language Server`.

---@type vim.lsp.Config
local ols_config = {
	cmd = { "ols" },
	filetypes = { "odin" },
	root_markers = { "ols.json", ".git", "*.odin" },
}

vim.lsp.config("ols", ols_config)

local run_ols = function()
	-- check if ols is installed or in path
	if vim.fn.executable("ols") == 0 then
		vim.notify("The language server `ols` is either not installed, missing from PATH, or not executable.", "error")
		return
	end

	-- check if odin compiler is installed or in path
	if vim.fn.executable("odin") == 0 then
		vim.notify(
			"The language server `odin language server` requires `odin` which is either not installed, missing from PATH, or not executable.",
			"error"
		)
		return
	end

	-- return if client is already connected to buffer
	if vim.lsp.get_clients({ name = "ols" })[1] then
		return
	end

	vim.lsp.enable("ols")
end

-- setup rust-analyzer to run on every rust file with autocommand on FileType 'rust'
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "odin" },
	callback = run_ols,
})
