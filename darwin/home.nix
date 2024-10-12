{ pkgs, ... }:
{
  imports =
    (import ../modules/programs) ++
    (import ../modules/shell);

  home = {
    packages = with pkgs; [
      bat
      btop
      cocogitto
      curl
      darwin.trash
      delta
      deno
      eza
      fd
      ffmpeg
      fzf
      fzy
      gh
      ghq
      glow
      gopass
      htop
      httpie
      imagemagick
      jq
      just
      lazydocker
      less
      meshoptimizer
      ncdu
      neofetch
      nixpkgs-fmt
      nushell
      pgformatter
      postgresql_16_jit
      ripgrep
      sad
      sesh
      silver-searcher
      termscp
      tig
      tokei
      unar
      vimv
      watchman
      wget
      xplr
      yazi
      zellij
      zoxide
    ];
    stateVersion = "24.11";
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
