return {
	"folke/todo-comments.nvim",
	name = "todo-comments.nvim",
	cmd = { "TodoTrouble" },
	lazy = true,
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = {},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next Todo Comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous Todo Comment",
		},
	},
}
