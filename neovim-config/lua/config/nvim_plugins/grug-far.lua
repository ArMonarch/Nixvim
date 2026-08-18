return {
	"MagicDuck/grug-far.nvim",
	name = "grug-far.nvim",
	cmd = "GrugFar",
	opts = {},
	keys = {
		{
			"<leader>sR",
			function()
				-- `transient = true` keeps the buffer out of the buffer list, so `<S-h>` /
				-- `<S-l>` do not cycle through spent search buffers.
				-- a visual selection prefills the search field (`visualSelectionUsage`
				-- defaults to "prefill-search"); scope a run to fewer files by filling in
				-- the "Files Filter" field inside the buffer.
				require("grug-far").open({ transient = true })
			end,
			mode = { "n", "x" },
			desc = "Search and Replace",
		},
	},
}
