{ pkgs, ... }:
{
  imports =
    (import ../modules/programs) ++
    (import ../modules/shell);

  home = {
    packages = with pkgs; [
      bat
      btop
      bun
      cloc
      curl
      darwin.trash
      delta
      deno
      eza
      fd
      fzf
      fzy
      gh
      ghq
      gopass
      htop
      httpie
      imagemagick
      jq
      just
      lazydocker
      less
      ncdu
      neofetch
      nixpkgs-fmt
      nnn
      nushell
      ripgrep
      sad
      silver-searcher
      termscp
      tig
      watchman
      wget
      xplr
      zellij
      zig
      zoxide
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
}
