{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux ];

  xdg.configFile."tmux/tmux.conf" = {
    source = ../../config/tmux/tmux.conf;
  };
}
