{
  description = "A Nix Flake of Neovim Wrapper";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    wrappers = {
      url = "github:lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      wrappers,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        package-name = "neovim";
        stable-pkgs = import nixpkgs { inherit system; };
        unstable-pkgs = import nixpkgs-unstable { inherit system; };

        # flag to set neovim transparent colorscheme
        neovim-transparent-theme = false;

        neovim-startPlugins = with stable-pkgs.vimPlugins; [
          lazy-nvim
          plenary-nvim
        ];
        neovim-optPlugins =
          with stable-pkgs.vimPlugins;
          [
            tokyonight-nvim
            catppuccin-nvim
            rose-pine

            blink-cmp
            conform-nvim
            gitsigns-nvim
            lazydev-nvim
            lualine-nvim
            neorg
            noice-nvim
            nui-nvim # <- noice-nvim
            mini-icons
            mini-pairs
            nvim-treesitter
            plenary-nvim
            snacks-nvim
            smear-cursor-nvim
            todo-comments-nvim
            trouble-nvim
            which-key-nvim

            (stable-pkgs.stdenvNoCC.mkDerivation {
              name = "lualine-pretty-path";
              src = stable-pkgs.fetchFromGitHub {
                owner = "bwpge";
                repo = "lualine-pretty-path";
                rev = "852cb06f3562bced4776a924e56a9e44d0ce634f";
                hash = "sha256-Ieho+EruCPW4829+qQ3cdfc+wZQ2CFd16YtcTwUAnKg=";
              };
              phases = [ "installPhase" ];
              installPhase = "cp -r $src $out";
            })
          ]
          ++ [ stable-pkgs.luajitPackages.lua-utils-nvim ];

        foldPlugins = builtins.foldl' (
          acc: next: acc ++ [ next ] ++ (foldPlugins (next.dependencies or [ ]))
        ) [ ];
        neovim-treesitter-grammers = with unstable-pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
        ];

        neovim-packages = stable-pkgs.runCommandLocal "neovim-packages" { } ''
          mkdir -p $out/pack/${package-name}/{start,opt}
          ln -vsfT ${./neovim-config} $out/pack/${package-name}/start/neovim-config

          # necessary packages should be loaded at start i.e. mainly plugins manager and its helper package
          ${stable-pkgs.lib.concatMapStringsSep "\n" (
            plugin: "ln -vsfT ${plugin} $out/pack/${package-name}/start/${stable-pkgs.lib.getName plugin}"
          ) neovim-startPlugins}

          # load the treesitter parsers into one folder and append that folder to 
          # vim runtimepath in the lua config as lazy.nvim resets runtimepath.
          mkdir -p $out/pack/${package-name}/opt/treesitter/parser
          ${stable-pkgs.lib.concatMapStringsSep "\n" (plugin: ''
            for so in ${plugin}/parser/*.so; do
              ln -vsfT "$so" "$out/pack/${package-name}/opt/treesitter/parser/$(basename "$so")"
            done
          '') (stable-pkgs.lib.unique (foldPlugins neovim-treesitter-grammers))}

          # load optional plugins which lazy.nvim will load automatically
          ${stable-pkgs.lib.concatMapStringsSep "\n" (
            plugin: "ln -vsfT ${plugin} $out/pack/${package-name}/opt/${stable-pkgs.lib.getName plugin}"
          ) neovim-optPlugins}
        '';
      in
      {
        packages.default = wrappers.lib.wrapPackage rec {
          pkgs = stable-pkgs;
          package = stable-pkgs.neovim-unwrapped;
          exePath = nixpkgs.lib.getExe package;
          binName = builtins.baseNameOf exePath;
          runtimeInputs = with stable-pkgs; [
            # Packages that plugins depends on
            lazygit # <- snacks.nvim
            gh # <- snacks.nvim

            # LSP Servers Packages
            basedpyright
            lua-language-server
            marksman
            nixd
            nil
            rust-analyzer
            typescript-language-server
            zls

            # Formatters Packages
            nixfmt-rfc-style
            prettierd
            stylua
            shfmt
            ruff
            rustfmt
          ];
          env = {
            "NVIM_APPNAME" = "neovim";
          };
          flags = {
            "-u" = "NORC";
            "--cmd" = ''
              set packpath^=${neovim-packages} |
              set runtimepath^=${neovim-packages} |
              let g:neovim_plugins='${neovim-packages}/pack/neovim/opt' |
              let g:neovim_treesitter_parsers='${neovim-packages}/pack/neovim/opt/treesitter' |
              let g:neovim_transparent_theme='${builtins.toString neovim-transparent-theme}'
            '';
          };
          flagSeparator = " ";
          passthru = {
            inherit neovim-packages;
          };
        };
      }
    );
}
