{ pkgs, ... }:
{
  programs = {
    lazygit = {
      enable = true;
      settings = {
        git = {
          overrideGpg = true;
          parseEmoji = true;
          # branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium --oneline {{branchName}} --";
          branchLogCmd = "git-graph --no-pager -n 100";
          paging = {
            colorArg = "always";
            pager = "${pkgs.delta}/bin/delta --dark --paging=never";
          };
        };
        gui = {
          nerdFontsVersion = "3";
          theme = {
            activeBorderColor = [ "#ff9e64" "bold" ];
            inactiveBorderColor = [ "#27a1b9" ];
            searchingActiveBorderColor = [ "#ff9e64" "bold" ];
            optionsTextColor = [ "#7aa2f7" ];
            selectedLineBgColor = [ "#283457" ];
            cherryPickedCommitFgColor = [ "#7aa2f7" ];
            cherryPickedCommitBgColor = [ "#bb9af7" ];
            markedBaseCommitFgColor = [ "#7aa2f7" ];
            markedBaseCommitBgColor = [ "#e0af68" ];
            unstagedChangesColor = [ "#db4b4b" ];
            defaultFgColor = [ "#c0caf5" ];
          };
        };
      };
    };
  };
}
