return {
	"folke/snacks.nvim",
	name = "snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = false },
		dashboard = { enabled = false },
		explorer = { enabled = true },
		indent = { enabled = false },
		input = { enabled = false },
		picker = { enabled = false },
		notifier = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	keys = {
		-- snacks buffer delete keymaps
		{
			"<leader>ba",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Delete All Buffers",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete.delete()
			end,
			desc = "Delete Current Buffer",
		},
		{
			"<leader>bo",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Delete Other Buffers",
		},

		-- snacks lazygit keymaps
		{
			"<leader>gg",
			function()
				Snacks.lazygit({ cwd = Snacks.git.get_root() })
			end,
			desc = "Lazygit (Root Directory)",
		},
		{
			"<leader>gG",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit (cwd)",
		},

		-- snacks explorer keymaps
		{
			"<leader>e",
			function()
				Snacks.explorer({ cwd = Snacks.git.get_root() })
			end,
			desc = "Explorer Snacks (root dir)",
		},
		{
			"<leader>E",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer Snacks (cwd)",
		},
		{
			"<leader>fe",
			function()
				Snacks.explorer({ cwd = Snacks.git.get_root() })
			end,
			desc = "Explorer Snacks (root dir)",
		},
		{
			"<leader>fE",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer Snacks (cwd)",
		},
		-- snacks notifications keymaps
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>nd",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
	},
}
