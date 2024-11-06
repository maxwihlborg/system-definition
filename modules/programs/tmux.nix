{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.tmux ];

  xdg.configFile."tmux" = {
    source = mkOutOfStoreSymlink "${config.home.homeDirectory}/ghq/github.com/maxwihlborg/system-definition/config/tmux";
  };
}
