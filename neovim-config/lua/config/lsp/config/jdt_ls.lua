---@brief
---
--- https://github.com/georgewfraser/java-language-server
---
--- Java language server
---
--- Point `cmd` to `lang_server_linux.sh` or the equivalent script for macOS/Windows provided by java-language-server

---@type vim.lsp.Config
local jdt_ls = {
	cmd = { "jdtls" },
	filetypes = { "java" },
	root_markers = { "build.gradle", "build.gradle.kts", "pom.xml", ".git" },
	settings = {},
}

vim.lsp.config("java-language-server", jdt_ls)
