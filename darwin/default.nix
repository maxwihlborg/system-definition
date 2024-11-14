{ lib, inputs, nixpkgs, home-manager, darwin, sops-nix, user, ... }:
{
  xbook-pro = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = { inherit user inputs; };
    modules = [
      ./configuration.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = import ./home.nix;
        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      }
    ];
  };
}
