return {
	"folke/flash.nvim",
	name = "flash.nvim",
	-- loaded eagerly rather than on the `keys` below because `search` mode hooks into
	-- `/` and `?` themselves, so the plugin has to already be live for `<c-s>` to have
	-- anything to toggle.
	event = "VeryLazy",
	opts = {},
  -- stylua: ignore
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<c-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
