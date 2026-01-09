local neovim_plugins = vim.g.neovim_plugins
local neovim_transparent_theme = vim.g.neovim_transparent_theme

---@type LazyConfig
local lazyOptions = {
	defaults = {
		lazy = true,
	},
	dev = {
		path = neovim_plugins or nil,
		patterns = {
			"bwpge",
			"catppuccin",
			"echasnovski",
			"folke",
			"lewis6991",
			"MeanderingProgrammer",
			"MunifTanjim",
			"mfussenegger",
			"nvim-lua",
			"nvim-lualine",
			"nvim-treesitter",
			"rose-pine",
			"saghen",
			"sphamba",
			"stevearc",
		},
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
		"nvim-lua/plenary.nvim",
		name = "plenary.nvim",
		lazy = true,
	},
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

	-- blink.nvim completion configuration
	{ import = "config.nvim_plugins.blink" },

	-- conform.nvim formatter configuration
	{ import = "config.nvim_plugins.conform" },

	-- gitsigns.nvim configuration
	{ import = "config.nvim_plugins.gitsigns" },

	-- lazy.dev configuration
	{ import = "config.nvim_plugins.lazydev" },

	-- lualine configuration
	{ import = "config.nvim_plugins.lualine" },

	-- noice configuration for commandline only
	{ import = "config.nvim_plugins.noice" },

	-- mini-icons configuration
	{ import = "config.nvim_plugins.mini-icons" },

	-- mini-pairs configuration
	{ import = "config.nvim_plugins.mini-pairs" },

	-- snacks.nvim configuration
	{ import = "config.nvim_plugins.snacks" },

	-- smearcursor.nvim animation configuration
	{ import = "config.nvim_plugins.smear-cursor" },

	-- todo-comments configuration
	{ import = "config.nvim_plugins.todo-comments" },

	-- trouble configuration
	{ import = "config.nvim_plugins.trouble" },

	-- nvim-treesitter configuration
	{ import = "config.nvim_plugins.nvim-treesitter" },

	-- whick-key.nvim config
	{ import = "config.nvim_plugins.which-key" },

	-- configure jdtls for neovim
	{
		"mfussenegger/nvim-jdtls",
		name = "nvim-jdtls",
	},
}, lazyOptions)

-- set colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- load netrw file explorer as lazy.nvim disables it
vim.cmd.packadd("netrw")

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
