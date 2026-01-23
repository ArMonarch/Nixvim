require("config.lsp.config.basedpyright")
require("config.lsp.config.denols")
require("config.lsp.config.jdtls")
require("config.lsp.config.lua_ls")
require("config.lsp.config.marksman")
require("config.lsp.config.nil_ls")
require("config.lsp.config.nixd")
require("config.lsp.config.rust_analyzer")
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
vim.lsp.enable("rust-analyzer")
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

-- setup jdtls to run on every java file with autocommand on FileType 'java'
local function start_jtdls_client()
	-- configure jdtls
	local config = {
		name = "jdtls",

		-- `cmd` defines the executable to launch eclipse.jdt.ls.
		-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
		--
		-- As alternative you could also avoid the `jdtls` wrapper and launch
		-- eclipse.jdt.ls via the `java` executable
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = { "jdtls" },

		-- `root_dir` must point to the root of your project.
		-- See `:help vim.fs.root`
		root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {},
		},

		-- This sets the `initializationOptions` sent to the language server
		-- If you plan on using additional eclipse.jdt.ls plugins like java-debug
		-- you'll need to set the `bundles`
		--
		-- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on any eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = {},
		},
	}
	require("jdtls").start_or_attach(config)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = start_jtdls_client,
})
