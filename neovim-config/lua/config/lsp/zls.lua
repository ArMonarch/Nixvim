---@brief
--- https://github.com/zigtools/zls
---
--- Zig LSP implementation + Zig Language Server

---@type vim.lsp.Config
local zls_config = {
	name = "zls",
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "zls.json", "build.zig", ".git" },
	workspace_required = false,
}

-- add the zig language server configuration
vim.lsp.config("zls", zls_config)

local run_zls = function()
	-- check if zig language server is installed or in path
	if vim.fn.executable("zls") == 0 then
		vim.notify("The language server `zls` is either not installed, missing from PATH, or not executable.", "error")
		return
	end

	-- check if zig language server is installed or in path
	if vim.fn.executable("zig") == 0 then
		vim.notify(
			"The language server `zls` requires `zig which is either not installed, missing from PATH, or not executable.",
			"error"
		)
		return
	end

	-- return if client is already connected to buffer
	if vim.lsp.get_clients({ name = "zls" })[1] then
		return
	end

	vim.lsp.enable("zls", true)
end

-- setup zig language server to run with autocommand on FileType event
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "zig", "zir" },
	callback = run_zls,
})
