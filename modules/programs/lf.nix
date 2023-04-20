{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.lf ];
  xdg.configFile."lf" = {
    source = mkOutOfStoreSymlink "${config.home.homeDirectory}/ghq/github.com/maxwihlborg/system-definition/config/lf";
  };
}
