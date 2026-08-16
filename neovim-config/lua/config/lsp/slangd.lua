---@brief
---
--- https://github.com/shader-slang/slang
---
--- `Slang Language Server`, ships with the slang compiler toolchain.
---
--- The `slangd` binary can be downloaded as part of [slang releases](https://github.com/shader-slang/slang/releases),
--- installed from nixpkgs as `shader-slang`, or by
--- [building `slang` from source](https://github.com/shader-slang/slang/blob/master/docs/building.md).
---
--- Available settings are documented
--- [here](https://github.com/shader-slang/slang-vscode-extension/tree/main?tab=readme-ov-file#configurations).

---@type vim.lsp.Config
local slangd_config = {
	name = "slangd",
	cmd = { "slangd" },
	filetypes = { "hlsl", "shaderslang" },
	root_markers = { "slangdconfig.json", ".clang-format", ".git" },
	settings = {
		slang = {
			inlayHints = {
				deducedTypes = true,
				parameterNames = true,
			},
		},
	},
}

-- add the slang language server configuration
vim.lsp.config("slangd", slangd_config)

local run_slangd = function()
	-- check if slang language server is installed or in path
	if vim.fn.executable("slangd") == 0 then
		vim.notify(
			"The language server `slangd` is either not installed, missing from PATH, or not executable.",
			"error"
		)
		return
	end

	-- return if client is already connected to buffer
	if vim.lsp.get_clients({ name = "slangd" })[1] then
		return
	end

	vim.lsp.enable("slangd", true)
end

-- setup slang language server to run with autocommand on FileType event
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "hlsl", "shaderslang" },
	callback = run_slangd,
})
