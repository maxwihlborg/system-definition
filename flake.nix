{
  description = "System Declaration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, sops-nix, darwin, ... }:
    let
      user = "max";
    in
    {
      darwinConfigurations = (
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit user inputs nixpkgs darwin home-manager sops-nix;
        }
      );
    };
}
