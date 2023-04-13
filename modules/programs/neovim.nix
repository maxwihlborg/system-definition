{ pkgs, ... }:
{
  home.packages = [ pkgs.neovim ];

  xdg.configFile."nvim/ftdetect" = {
    source = ../../config/nvim/ftdetect;
  };
  xdg.configFile."nvim/lua" = {
    source = ../../config/nvim/lua;
  };
  xdg.configFile."nvim/spell" = {
    source = ../../config/nvim/spell;
  };
  xdg.configFile."nvim/syntax" = {
    source = ../../config/nvim/syntax;
  };
  xdg.configFile."nvim/init.lua" = {
    source = ../../config/nvim/init.lua;
  };
  xdg.configFile."nvim/stylua.toml" = {
    source = ../../config/nvim/stylua.toml;
  };
}
