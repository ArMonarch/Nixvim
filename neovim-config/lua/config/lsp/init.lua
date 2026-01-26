require("config.lsp.config.lua_ls")
require("config.lsp.config.nil_ls")
require("config.lsp.config.nixd")

-- NOTE: Enable Language Servers here,
-- needs Neovim v0.11+, as it used functions available on Neovim version >= 0.11
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("nixd")

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

-- import the configuration for basedpyright
require("config.lsp.basedpyright")
-- import the configuration for denols
require("config.lsp.denols")
-- configuration for jdtls through nvim_jdtls and import the configuration
require("config.lsp.jdtls")
-- import the configuration for rust-analyzer
require("config.lsp.rust-analyzer")
-- import the configuration for texlab
require("config.lsp.texlab")
-- import the configuration for typesscript language server
require("config.lsp.ts_ls")
-- import the configuration for zig language server
require("config.lsp.zls")
