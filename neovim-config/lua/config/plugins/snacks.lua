return {
	"folke/snacks.nvim",
	name = "snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = false },
		dashboard = { enabled = false },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = false },
		picker = {
			enabled = true,
			layout = { preset = "telescope" },
		},
		notifier = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
  -- stylua: ignore
	keys = {
		-- snacks buffer delete keymaps
		{	"<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },
		{	"<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete Current Buffer" },
		{	"<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },

		-- snacks lazygit keymaps
		{	"<leader>gg", function() Snacks.lazygit({ cwd = Snacks.git.get_root() }) end, desc = "Lazygit (Root Directory)" },
		{	"<leader>gG", function() Snacks.lazygit() end, desc = "Lazygit (cwd)" },

    -- snacks picker -> misc keymaps
		{	"<leader><leader>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },

    -- snacks picker -> files keymaps
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

		-- snacks explorer keymaps
		{	"<leader>e", function() Snacks.explorer({ cwd = Snacks.git.get_root() }) end, desc = "Explorer Snacks (root dir)" },
		{	"<leader>E", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)" },
		{	"<leader>fe", function() Snacks.explorer({ cwd = Snacks.git.get_root() }) end, desc = "Explorer Snacks (root dir)" },
		{	"<leader>fE", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)" },

		-- snacks notifications keymaps
		{	"<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{	"<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
	},
}
