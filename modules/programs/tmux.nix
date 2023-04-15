{ pkgs, ... }:
{
  home.packages = [ pkgs.tmux pkgs.tmuxinator ];

  xdg.configFile."tmux/tmux.conf" = {
    source = ../../config/tmux/tmux.conf;
  };
}
