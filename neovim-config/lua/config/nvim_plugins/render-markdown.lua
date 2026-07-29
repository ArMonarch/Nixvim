return {
	"MeanderingProgrammer/render-markdown.nvim",
	name = "render-markdown.nvim",
	lazy = true, -- Recommended false
	ft = { "markdown", "quarto" },
	dependencies = {
		"echasnovski/mini.icons",
	},
	opts = {
		completions = { blink = { enabled = true } },
		heading = {
			enabled = false,
		},
	},
}
