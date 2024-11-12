{ pkgs, ... }:
{
  programs = {
    lazygit = {
      enable = true;
      settings = {
        git = {
          parseEmoji = true;
          paging = {
            colorArg = "always";
            pager = "${pkgs.delta}/bin/delta --dark --paging=never --24-bit-color=never";
            branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium --oneline {{branchName}} --";
          };
        };
      };
    };
  };
}
