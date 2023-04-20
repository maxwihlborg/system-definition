{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.neovim ];

  xdg.configFile."nvim" = {
    source = mkOutOfStoreSymlink "${config.home.homeDirectory}/ghq/github.com/maxwihlborg/system-definition/config/nvim";
  };
}
