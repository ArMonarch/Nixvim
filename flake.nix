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

        neovim-startPlugins = with stable-pkgs.vimPlugins; [
          plenary-nvim
          lazy-nvim
        ];
        neovim-optPlugins = with stable-pkgs.vimPlugins; [
          tokyonight-nvim
          catppuccin-nvim
          rose-pine
          gruvbox-material-nvim
        ];

        neovim-packages = stable-pkgs.runCommandLocal "neovim-packages" { } ''
          mkdir -p $out/pack/${package-name}/{start,opt}
          ln -vsfT ${./neovim-config} $out/pack/${package-name}/start/neovim-config

          # necessary packages should be loaded at start i.e. mainly plugins manager and its helper package
          ${stable-pkgs.lib.concatMapStringsSep "\n" (
            plugin: "ln -vsfT ${plugin} $out/pack/${package-name}/start/${stable-pkgs.lib.getName plugin} "
          ) neovim-startPlugins}

          # load optional plugins which lazy.nvim will load automatically
          ${stable-pkgs.lib.concatMapStringsSep "\n" (
            plugin: "ln -vsfT ${plugin} $out/pack/${package-name}/opt/${stable-pkgs.lib.getName plugin} "
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
            basedpyright
            lua-language-server
            marksman
            nixd
            nil
            rust-analyzer
            typescript-language-server
            zls
          ];
          env = {
            "NVIM_APPNAME" = "neovim";
          };
          flags = {
            "-u" = "NORC";
            "--cmd" = "set packpath^=${neovim-packages} | set runtimepath^=${neovim-packages}";
          };
          flagSeparator = " ";
          passthru = {
            inherit neovim-packages;
          };
        };
      }
    );
}
