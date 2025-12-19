return {
	{
		"nvim-neorg/lua-utils",
		name = "lua-utils.nvim",
	},
	{
		"nvim-neorg/neorg",
		name = "neorg",
		dependencies = { "lua-utils.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
				},
			})
		end,
	},
}
