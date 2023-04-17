{ pkgs, ... }:
{
  xdg.configFile."hammerspoon/init.lua" = {
    source = ../../config/hammerspoon/init.lua;
  };
  xdg.configFile."hammerspoon/Spoons/EmmyLua.spoon/init.lua" = {
    source = "${pkgs.fetchzip {
      url = "https://github.com/Hammerspoon/Spoons/raw/85c47f7abdd49b6d7dfe6ed90cf61e6800bfdda1/Spoons/EmmyLua.spoon.zip";
      sha256 = "sha256-JpPwp0sJaFtlNgjGQmSYa9CH3eC0HJuHDoPD+DuZZzw=";
    }}/init.lua";
  };
}
