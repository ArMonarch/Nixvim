{
  pkgs,
  lib,
  wrappers,
  ...
}: let
  package-name = "neovim";

  # flag to set neovim transparent colorscheme
  neovim-transparent-theme = false;

  neovim-startPlugins = with pkgs.vimPlugins; [
    lazy-nvim
  ];

  neovim-optPlugins = with pkgs.vimPlugins; [
    rose-pine

    blink-cmp
    conform-nvim
    friendly-snippets
    gitsigns-nvim
    lazydev-nvim
    lualine-nvim
    noice-nvim
    nvim-jdtls
    nui-nvim # <- noice-nvim
    mini-icons
    mini-pairs
    plenary-nvim
    render-markdown-nvim
    markdown-preview-nvim
    snacks-nvim
    smear-cursor-nvim
    todo-comments-nvim
    ts-comments-nvim
    trouble-nvim
    which-key-nvim

    (
      pkgs.stdenvNoCC.mkDerivation {
        name = "lualine-pretty-path";
        src = pkgs.fetchFromGitHub {
          owner = "bwpge";
          repo = "lualine-pretty-path";
          rev = "852cb06f3562bced4776a924e56a9e44d0ce634f";
          hash = "sha256-Ieho+EruCPW4829+qQ3cdfc+wZQ2CFd16YtcTwUAnKg=";
        };
        phases = ["installPhase"];
        installPhase = "cp -r $src $out";
      }
    )
  ];

  foldPlugins = builtins.foldl' (
    acc: next: acc ++ [next] ++ (foldPlugins (next.dependencies or []))
  ) [];
  neovim-treesitter-grammers = with pkgs.vimPlugins; [nvim-treesitter.withAllGrammars];

  neovim-packages = pkgs.runCommandLocal "neovim-packages" {} ''
    mkdir -p $out/pack/${package-name}/{start,opt}
    ln -vsfT ${./neovim-config} $out/pack/${package-name}/start/neovim-config

    # necessary packages should be loaded at start i.e. mainly plugins manager and its helper package
    ${
      pkgs.lib.concatMapStringsSep "\n" (
        plugin: "ln -vsfT ${plugin} $out/pack/${package-name}/start/${pkgs.lib.getName plugin}"
      )
      neovim-startPlugins
    }

    # load optional plugins which lazy.nvim will load automatically
    ${
      pkgs.lib.concatMapStringsSep "\n" (
        plugin: "ln -vsfT ${plugin} $out/pack/${package-name}/opt/${pkgs.lib.getName plugin}"
      )
      neovim-optPlugins
    }
  '';

  # neovim searches treesitter parsers from runtime path/parser/language.so and the
  # matching highlight/indent/fold queries from runtime path/queries/language/, so we
  # append this neovim-treesitter path to runtime path after loading lazy plugins
  # as it resets runtime path.
  # nvim-treesitter's `main` branch splits these into separate derivations -- one
  # `-grammar-<lang>` (only parser/) and one `-queries-<lang>` (only queries/) per
  # language -- hence the two loops below.
  neovim-treesitter = pkgs.runCommandLocal "neovim-treesitter" {} ''
    # load the treesitter parsers and queries into one folder and append that folder
    # to vim runtimepath in the lua config as lazy.nvim resets runtimepath.
    mkdir -p $out/pack/${package-name}/treesitter/{parser,queries}
    ${pkgs.lib.concatMapStringsSep "\n" (plugin: ''
      for so in ${plugin}/parser/*.so; do
        if [ -e "$so" ]; then
          ln -vsfT "$so" "$out/pack/${package-name}/treesitter/parser/$(basename "$so")"
        fi
      done
      for query in ${plugin}/queries/*; do
        if [ -e "$query" ]; then
          ln -vsfT "$query" "$out/pack/${package-name}/treesitter/queries/$(basename "$query")"
        fi
      done
    '') (pkgs.lib.unique (foldPlugins neovim-treesitter-grammers))}
  '';
in
  wrappers.lib.wrapPackage rec {
    inherit pkgs;
    package = pkgs.neovim-unwrapped;
    exePath = lib.getExe package;
    binName = baseNameOf exePath;
    runtimeInputs = with pkgs; [
      # Packages that plugins depends on
      ripgrep # <- snacks.nvim picker (grep)
      fd # <- snacks.nvim picker (files)
      lazygit # <- snacks.nvim
      gh # <- snacks.nvim
      imagemagick

      # LSP Servers Packages
      lua-language-server
      nixd
      nil

      # Formatters Packages
      alejandra
      stylua
      shfmt
    ];
    env = {
      "NVIM_APPNAME" = "nixvim";
    };
    flags = {
      "-u" = "NORC";
      "--cmd" = ''
        set packpath=${neovim-packages} |
        set packpath^=${pkgs.neovim-unwrapped}/share/nvim/runtime |
        set runtimepath^=${neovim-packages} |
        let g:neovim_packages='${neovim-packages}' |
        let g:neovim_plugins='${neovim-packages}/pack/neovim/opt' |
        let g:neovim_treesitter_parsers='${neovim-treesitter}/pack/neovim/treesitter' |
        let g:neovim_transparent_theme='${toString neovim-transparent-theme}'
      '';
    };
    flagSeparator = " ";
    passthru = {
      inherit neovim-packages;
    };
  }
