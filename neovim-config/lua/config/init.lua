-- set vim options
require("config.options")

-- Add LSP & Plugins before keymaps and autocmds as some
-- of the keymaps and autocmd depend upon these plugins

-- Setup & Config for LSP Server per language
require("config.lsp")
