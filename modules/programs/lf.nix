{ pkgs, ... }:
{
  home.packages = [ pkgs.lf ];
  xdg.configFile."lf/lfrc" = {
    source = ../../config/lf/lfrc;
  };
}
