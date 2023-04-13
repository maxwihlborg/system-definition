{ pkgs, ... }:
let
  yamlFormat = pkgs.formats.yaml { };
in
{
  home.packages = [ pkgs.lazygit ];
  xdg.configFile."lazygit/config.yml" = {
    source = yamlFormat.generate "lazygit-config" {
      git = {
        paging = {
          colorArg = "always";
          pager = "${pkgs.delta}/bin/delta --dark --paging=never --24-bit-color=never";
          branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium --oneline {{branchName}} --";
        };
      };
    };
  };
}
