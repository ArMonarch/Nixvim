-- set vim options
require("neovim-config.lua.config.options")

-- Add LSP & Plugins before keymaps and autocmds as some
-- of the keymaps and autocmd depend upon these plugins

-- Setup & Config for LSP Server per language
require("neovim-config.lua.config.lsp.init")

-- load plugins
require("neovim-config.lua.config.plugins.init")

-- load set vim keymaps
require("neovim-config.lua.config.keymaps")

-- load set vim autocmds
require("neovim-config.lua.config.autocmds")
