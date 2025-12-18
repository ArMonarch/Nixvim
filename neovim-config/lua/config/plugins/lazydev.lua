return {
	"folke/lazydev.nvim",
	name = "lazydev.nvim",
	cmd = "LazyDev",
	ft = "lua",
	opts = {
		library = {
			-- Load luvit types when the `vim.uv` word is found
			-- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = "snacks.nvim", word = { "Snacks" } },
		},
	},
}
