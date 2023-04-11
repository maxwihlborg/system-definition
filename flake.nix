{
  description = "MacOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixpkgs-unstable, darwin, ... }:
    {
      darwinConfigurations = {
        xbook-pro = darwin.lib.darwinSystem
          rec {
            system = "aarch64-darwin";
            modules = [
              ./modules/darwin
              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.max = (import ./modules/home-manager {
                  pkgs = nixpkgs-unstable.legacyPackages."${system}";
                });
              }
            ];
          };
      };
    };
}
