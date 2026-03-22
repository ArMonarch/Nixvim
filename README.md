# Nixvim

A fully declarative Neovim configuration wrapped with Nix. The editor config is written in pure Lua while Nix handles all dependencies — plugins, LSP servers, formatters, and CLI tools — so it works on any NixOS machine with zero manual setup.

## How It Works

```
flake.nix → default.nix → Wrapped Neovim Package
                ├── Lua config (neovim-config/)
                ├── Plugins (via nixpkgs.vimPlugins + lazy.nvim)
                ├── Treesitter grammars (pre-compiled)
                ├── LSP servers
                └── Formatters & CLI tools
```

Nix builds a self-contained Neovim package with everything bundled. No Mason, no runtime downloads, no compilation on first launch. The config is isolated via `NVIM_APPNAME=nixvim` so it won't conflict with your existing Neovim setup.

## Installation

**Run directly without cloning:**

```sh
nix run github:ArMonarch/Nixvim#nixvim
```

**Or clone and run locally:**

```sh
git clone https://github.com/ArMonarch/Nixvim.git
cd Nixvim
nix run .#nixvim
```

> Requires Nix with flakes enabled.

## Features

### Plugins

| Category | Plugin | Purpose |
|----------|--------|---------|
| Plugin Manager | lazy.nvim | Lazy-loading plugin management |
| Completion | blink.cmp | Fast completion with LSP, path, snippets, buffer sources |
| Formatting | conform.nvim | Per-filetype formatting with LSP fallback |
| Git | gitsigns.nvim | Inline diff markers, hunk staging, blame |
| Statusline | lualine.nvim | Git branch, diagnostics, pretty path |
| UI | noice.nvim | Enhanced command line and notifications |
| Utilities | snacks.nvim | File picker, explorer, terminal, lazygit, notifications |
| Keybindings | which-key.nvim | Keybinding hints on leader press |
| Diagnostics | trouble.nvim | Diagnostic and reference panel |
| Treesitter | nvim-treesitter | Syntax highlighting, folding, textobjects |
| Markdown | render-markdown.nvim | In-buffer markdown rendering |
| Comments | ts-comments.nvim | Treesitter-aware commenting |
| TODO | todo-comments.nvim | Highlight and navigate TODO/FIXME/HACK |
| Pairs | mini.pairs | Auto-pairing brackets and quotes |
| Cursor | smear-cursor.nvim | Smooth cursor animation |
| Colorschemes | tokyonight, catppuccin, rose-pine | |

### LSP Servers

| Server | Language |
|--------|----------|
| lua_ls | Lua |
| nixd / nil_ls | Nix |
| basedpyright | Python |
| ts_ls | TypeScript / JavaScript |
| denols | Deno |
| rust-analyzer | Rust |
| zls | Zig |
| ols | Odin |
| jdtls | Java |
| texlab | LaTeX |

LSP servers auto-enable based on filetype using Neovim 0.11's declarative `vim.lsp.config()` / `vim.lsp.enable()` pattern.

### Formatters

| Formatter | Language |
|-----------|----------|
| stylua | Lua |
| alejandra | Nix |
| black | Python |
| prettierd | JavaScript / TypeScript |
| rustfmt | Rust |
| zigfmt | Zig |
| shfmt | Shell |

### Bundled CLI Tools

`lazygit`, `gh` (GitHub CLI), `imagemagick` — available inside Neovim without system-wide installation.

## Keybindings

Leader key: `Space`

<details>
<summary>Navigation & Editing</summary>

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Window navigation |
| `<S-h/l>` | Previous / next buffer |
| `<A-j/k>` | Move lines up / down |
| `<C-s>` | Save file |
| `j` / `k` | Move by display lines |

</details>

<details>
<summary>File & Search (snacks.nvim picker)</summary>

| Key | Action |
|-----|--------|
| `<leader><leader>` | Find files |
| `<leader>/` | Grep |
| `<leader>:` | Command history |
| `<leader>fb` | Buffers |
| `<leader>fg` | Git files |
| `<leader>fr` | Recent files |
| `<leader>se` | Explorer |
| `<leader>ss` | LSP symbols |
| `<leader>sd` | Diagnostics |

</details>

<details>
<summary>LSP & Code</summary>

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gI` | Implementations |
| `gy` | Type definition |
| `K` | Hover |
| `<leader>cf` | Format |
| `<leader>cd` | Line diagnostics |
| `]d` / `[d` | Next / prev diagnostic |

</details>

<details>
<summary>Git</summary>

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit |
| `<leader>gs` | Git status |
| `<leader>gl` | Git log |
| `<leader>gb` | Branches |
| `<leader>ghp` | Preview hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghb` | Blame line |

</details>

<details>
<summary>UI Toggles</summary>

| Key | Action |
|-----|--------|
| `<leader>uh` | Inlay hints |
| `<leader>ul` | Line numbers |
| `<leader>uL` | Relative numbers |
| `<leader>us` | Spell check |
| `<leader>uw` | Word wrap |
| `<leader>uz` | Zen mode |
| `<leader>ud` | Diagnostics |

</details>

## Project Structure

```
.
├── flake.nix                  # Flake definition (inputs & outputs)
├── default.nix                # Neovim wrapper, plugins, dependencies
└── neovim-config/
    └── lua/
        ├── config/
        │   ├── init.lua       # Entry point
        │   ├── options.lua    # Editor options
        │   ├── keymaps.lua    # Keybindings
        │   ├── autocmds.lua   # Autocommands
        │   ├── lsp/           # LSP server configs
        │   └── nvim_plugins/  # Plugin configs
        └── plugin/
            └── init.lua       # Plugin initialization
```

## License

MIT
