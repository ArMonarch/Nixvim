{
  description = "A Nix Flake of Neovim Wrapper";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # defines system that this flake supports
    systems.url = "github:nix-systems/default";

    # Powered by
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # module for wrapping neovim
    wrappers = {
      url = "github:lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      # Systems for which attributes of perSystem will be built.
      systems = import inputs.systems;

      perSystem = {
        system,
        pkgs,
        lib,
        ...
      }: rec {
        # Some of the packages pulled in are unfree, e.g. `replace-2.24`
        # (a build dependency), which nixpkgs marks as having an unfree license.
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        packages.default = pkgs.callPackage ./default.nix {
          inherit pkgs lib;
          wrappers = inputs.wrappers;
        };
        packages.nixvim = packages.default;
      };
    };
}
