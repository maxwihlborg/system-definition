{ pkgs, ... }:
{
  programs = {
    vifm = {
      enable = true;
      extraOptions = /* fish */''
      '';
    };
  };
}
