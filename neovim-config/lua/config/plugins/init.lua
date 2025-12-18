local neovim_plugins = vim.g.neovim_plugins
local neovim_transparent_theme = vim.g.neovim_transparent_theme

---@type LazyConfig
local lazyOptions = {
	defaults = {
		lazy = true,
	},
	dev = {
		path = neovim_plugins and string.format("%s/pack/neovim/opt", neovim_plugins) or "",
		patterns = { "" },
		fallback = false,
	},
	install = {
		missing = false,
		colorscheme = { "retrobox" },
	},
	performance = {
		cache = { enabled = true },
		reset_pathpath = true,
		rpt = {
			reset = true,
			disable_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = " ",
			config = "",
			debug = "● ",
			event = " ",
			favorite = " ",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			require = "󰢱 ",
			source = " ",
			start = " ",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
}

-- setup lazy.vim
require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		name = "tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = { transparent = neovim_transparent_theme == "1" and true or false },
	},

	{
		"catppuccin/nvim",
		name = "catppuccin-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({ transparent_background = neovim_transparent_theme == "1" and true })
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		opts = { styles = { transparency = neovim_transparent_theme == "1" and true or false } },
	},

	-- conform.nvim formatter configuration
	{ import = "config.plugins.conform" },

	-- snacks.nvim configuration
	{ import = "config.plugins.snacks" },

	-- smearcursor.nvim animation
	{ import = "config.plugins.smear-cursor" },

	-- whick-key.nvim config
	{ import = "config.plugins.which-key" },
}, lazyOptions)

-- set colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- load netrw file explorer as lazy.nvim disables it
vim.cmd.packadd("netrw")
