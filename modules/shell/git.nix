{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      userEmail = "6181962+maxwihlborg@users.noreply.github.com";
      userName = "Max Wihlborg";
      signing = {
        key = "CFEADCD30132EB29";
        signByDefault = true;
      };
      aliases = {
        rename = "!moveit() { git push origin --delete `git branch --show-current` || true; git branch -m $1; git push --set-upstream origin $1; }; moveit";
        co = "checkout";
        ci = "commit";
        st = "status";
        br = "branch";
        rb = "rebase";
      };
      extraConfig = {
        include = {
          path = "${pkgs.vimPlugins.tokyonight-nvim}/extras/delta/tokyonight_night.gitconfig";
        };
        init = { defaultBranch = "main"; };
        push = { default = "simple"; followTags = true; };
        pull = { rebase = true; };
        fetch = { prune = true; };
        delta = { line-numbers = true; dark = true; };
      };
      ignores = [
        # General
        ".DS_Store"
        ".AppleDouble"
        ".LSOverride"

        # Icon must end with two \r
        "Icon\r\r"

        # Thumbnails
        "._*"

        # Files that might appear in the root of a volume
        ".DocumentRevisions-V100"
        ".fseventsd"
        ".Spotlight-V100"
        ".TemporaryItems"
        ".Trashes"
        ".VolumeIcon.icns"
        ".com.apple.timemachine.donotpresent"

        # Directories potentially created on remote AFP share
        ".AppleDB"
        ".AppleDesktop"
        "Network Trash Folder"
        "Temporary Items"
        ".apdisk"

        # Vim
        ".swp"
        ".netrwhist"
      ];
    };
  };
}
