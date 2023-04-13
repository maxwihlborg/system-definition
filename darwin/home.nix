{ pkgs, ... }:
{
  imports =
    (import ../modules/programs) ++
    (import ../modules/services) ++
    (import ../modules/shell);

  home = {
    packages = with pkgs;[
      ripgrep
      nushell
      delta
      sad
      exa
      fd
      fzf
      curl
      less
      zellij
    ];
    stateVersion = "22.11";
  };

  home.sessionVariables = {
    PAGER = "less";
    LESS = "-RiF --mouse --wheel-lines=3";
    CLICOLOR = 1;
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
    XDG_CONFIG_HOME = "$HOME/.config";
    # fzf
    FZF_FIND_FILE_COMMAND = "fd --type f";
    FZF_OPEN_COMMAND = "fd --type f";
    # l10n
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  # setup the fish
  home.file.".profile" = {
    text = ''
      exec fish
    '';
  };
}
