-- configure jdtls
local config = {
	name = "jdtls",

	-- `cmd` defines the executable to launch eclipse.jdt.ls.
	-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
	--
	-- As alternative you could also avoid the `jdtls` wrapper and launch
	-- eclipse.jdt.ls via the `java` executable
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = { "jdtls" },

	-- `root_dir` must point to the root of your project.
	-- See `:help vim.fs.root`
	root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", ".git" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- This sets the `initializationOptions` sent to the language server
	-- If you plan on using additional eclipse.jdt.ls plugins like java-debug
	-- you'll need to set the `bundles`
	--
	-- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on any eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
}

local run_jdtls = function()
	if vim.fn.executable("jdtls") == 0 then
		vim.notify(
			"The language server `jdtls` is either not installed, missing from PATH, or not executable.",
			"error"
		)
		return
	end
	require("jdtls").start_or_attach(config)
end

-- setup jdtls to run on every java file with autocommand on FileType 'java'
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java" },
	callback = run_jdtls,
})
