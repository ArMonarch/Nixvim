{
  description = "A Nix Flake of Neovim Wrapper";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # defines system that this flake supports
    systems.url = "github:nix-systems/default-linux";

    # Powered by
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

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
        pkgs,
        lib,
        ...
      }: rec {
        packages.default = pkgs.callPackage ./default.nix {
          inherit pkgs lib;
          wrappers = inputs.wrappers;
        };
        packages.nixvim = packages.default;
      };
    };
}
