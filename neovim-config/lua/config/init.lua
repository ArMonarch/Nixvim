-- set vim options
require("config.options")

-- Setup & Config for LSP Server per language
require("config.lsp.init")

-- load set vim autocmds
require("config.autocmds")

-- load set vim keymaps
-- these keymaps should not depend on any plugins
-- thus, any keymaps that depend on plugins must be written in this file
-- after loading the plugins
require("config.keymaps")

-- load plugins
require("config.nvim_plugins.lazy")

-- set runtime path for treesitter parsers
local neovim_treesitter_parsers = vim.g.neovim_treesitter_parsers or nil
vim.opt.runtimepath:append(neovim_treesitter_parsers)

-- toggle options
if vim.lsp.inlay_hint then
	Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- function for easier keymap setting
local function map(mode, keys, func, options)
	vim.keymap.set(mode, keys, func, options)
end

-- Snacks toggle options keymap
Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
Snacks.toggle.zen():map("<leader>uz")

-- terminal keymaps
map("n", "<leader>tt", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle Terminal", remap = true })
map("v", "<leader>tt", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle Terminal", remap = true })
map("n", "<leader>tT", function()
	Snacks.terminal.toggle("exec fish", { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Toggle Scratch Terminal", remap = true })
map("v", "<leader>tT", function()
	Snacks.terminal.toggle("exec fish", { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Toggle Scratch Terminal", remap = true })
