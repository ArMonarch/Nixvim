require("config.lsp.config.basedpyright")
require("config.lsp.config.lua_ls")
require("config.lsp.config.marksman")
require("config.lsp.config.nil_ls")
require("config.lsp.config.nixd")
require("config.lsp.config.rust_analyzer")
require("config.lsp.config.ts_ls")
require("config.lsp.config.zls")

-- NOTE: Enable Language Servers here,
-- needs Neovim v0.11+, as it used functions available on Neovim version >= 0.11
vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("nil_ls")
vim.lsp.enable("nixd")
vim.lsp.enable("rust-analyzer")
vim.lsp.enable("ts_ls")
vim.lsp.enable("zls")

-- Enable Inlay Hints
vim.lsp.inlay_hint.enable(true)
