require("config.lsp.config.basedpyright")
require("config.lsp.config.denols")
require("config.lsp.config.lua_ls")
require("config.lsp.config.marksman")
require("config.lsp.config.nil_ls")
require("config.lsp.config.nixd")
require("config.lsp.config.ts_ls")
require("config.lsp.config.texlab")
require("config.lsp.config.zls")

-- NOTE: Enable Language Servers here,
-- needs Neovim v0.11+, as it used functions available on Neovim version >= 0.11
vim.lsp.enable("basedpyright")
vim.lsp.enable("denols")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("nil_ls")
vim.lsp.enable("nixd")
vim.lsp.enable("ts_ls")
vim.lsp.enable("texlab")
vim.lsp.enable("zls")

-- Enable Inlay Hints
vim.lsp.inlay_hint.enable(true)

--  This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	group = vim.api.nvim_create_augroup("buf-lsp-attach", { clear = true }),
	callback = function()
		local map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { desc = desc })
		end

		-- lsp keymaps
		map({ "n" }, "K", function()
			vim.lsp.buf.hover({
				border = "single",
				max_height = 15,
				max_width = 80,
			})
		end, "Code Hover")
	end,
})

-- configuration for jdtls through nvim_jdtls and import the configuration
require("config.lsp.jdtls")
-- import the configuration for rust-analyzer
require("config.lsp.rust-analyzer")
