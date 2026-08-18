-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = true
-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

-- sync clipboard between OS and neovim
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- tab / indentation
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shiftround = true -- Round Indent
-- vim.opt.softtabstop = 2
vim.opt.expandtab = true -- Use spaces instead of tab
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.wrap = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 7 -- Columns of context

-- Apperance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.breakindent = true

-- treesitter fold
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- persistent undo
-- undo history is written to `stdpath("state")/undo`, which `NVIM_APPNAME=nixvim`
-- already isolates to ~/.local/state/nixvim, so it will not collide with another
-- neovim config. without this `<leader>su` (undo history picker) can only ever see
-- the current session.
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- border used by every floating window that does not ask for one explicitly,
-- e.g. lsp hover, diagnostic floats, and plugin popups. set once here instead of
-- being passed per call site.
vim.opt.winborder = "single"

-- disable luarocks
