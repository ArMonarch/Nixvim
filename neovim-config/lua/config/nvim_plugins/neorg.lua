return {
	{
		"nvim-neorg/neorg",
		name = "neorg",
		lazy = false,
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
