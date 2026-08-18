-- mini.surround defaults to the bare `s*` mappings, which shadow the built-in `s`
-- (substitute). `s` is handed to flash.nvim instead (see nvim_plugins/flash.lua), so
-- every operation is moved behind the `gs` prefix that which-key already declares as
-- the "surround" group.
local mappings = {
	add = "gsa",
	delete = "gsd",
	find = "gsf",
	find_left = "gsF",
	highlight = "gsh",
	replace = "gsr",
	update_n_lines = "gsn",
}

return {
	"echasnovski/mini.surround",
	name = "mini.surround",
	opts = { mappings = mappings },
	keys = {
		{ mappings.add, desc = "Add Surrounding", mode = { "n", "x" } },
		{ mappings.delete, desc = "Delete Surrounding" },
		{ mappings.find, desc = "Find Right Surrounding" },
		{ mappings.find_left, desc = "Find Left Surrounding" },
		{ mappings.highlight, desc = "Highlight Surrounding" },
		{ mappings.replace, desc = "Replace Surrounding" },
		{ mappings.update_n_lines, desc = "Update `n_lines`" },
	},
}
