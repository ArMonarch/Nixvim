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

-- floating window geometry, scaled to the current window and clamped so a float
-- stays readable inside a narrow split without swallowing a large monitor.
-- evaluated per call rather than once at startup so it follows terminal resizes:
-- `vim.diagnostic.config()` accepts a function for `float` and calls it when the
-- float is actually opened.
local function float_size()
	return {
		max_width = math.min(120, math.max(80, math.floor(vim.o.columns * 0.4))),
		max_height = math.min(30, math.max(10, math.floor(vim.o.lines * 0.6))),
	}
end

-- diagnostics
--
-- neovim ships with both `virtual_text` and `virtual_lines` off, so a diagnostic is
-- nothing but a sign and an underline until it is opened with `<leader>cd`. render
-- the whole message under the cursor line instead -- `current_line = true` keeps
-- every other line quiet. `severity_sort` stops a hint from masking an error in the
-- sign column, and `source = "if_many"` names the server in the float, which matters
-- for nix where nixd and nil_ls both attach to the same buffer.
-- the sign glyphs mirror the ones in config/nvim_plugins/lualine.lua.
vim.diagnostic.config({
	severity_sort = true,
	virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	float = function()
		return vim.tbl_extend("error", float_size(), { source = "if_many" })
	end,
})

--  This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	group = vim.api.nvim_create_augroup("buf-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		-- lsp keymaps
		map({ "n" }, "K", function()
			vim.lsp.buf.hover(float_size())
		end, "Code Hover")

		-- the default `grn` / `gra` / `grx` mappings are deleted in config/keymaps.lua
		-- so that `gr` (references) fires without waiting on 'timeoutlen', so rename,
		-- code action and codelens are re-bound here under the `<leader>c` group.
		map({ "n" }, "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map({ "n" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
	end,
})

-- import the configuration for basedpyright
require("config.lsp.basedpyright")
-- import the configuration for denols
require("config.lsp.denols")
-- configuration for jdtls through nvim_jdtls and import the configuration
require("config.lsp.jdtls")
-- import the configuration for odin language server
require("config.lsp.ols")
-- import the configuration for rust-analyzer
require("config.lsp.rust-analyzer")
-- import the configuration for slang language server
require("config.lsp.slangd")
-- import the configuration for texlab
require("config.lsp.texlab")
-- import the configuration for typesscript language server
require("config.lsp.ts_ls")
-- import the configuration for zig language server
require("config.lsp.zls")
