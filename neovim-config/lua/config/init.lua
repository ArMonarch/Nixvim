-- set vim options
require("config.options")

-- load plugins
require("config.nvim_plugins.lazy")

-- set packpath after lazy updates packpath so that requires below works
local neovim_packages = vim.g.neovim_packages or nil
vim.opt.packpath:append(neovim_packages)

-- set runtime path for treesitter parsers
local neovim_treesitter_parsers = vim.g.neovim_treesitter_parsers or nil
vim.opt.runtimepath:append(neovim_treesitter_parsers)

-- Setup & Config for LSP Server per language
require("config.lsp")

-- load set vim keymaps
require("config.keymaps")

-- load set vim autocmds
require("config.autocmds")
