{ pkgs, ... }:
{
  imports =
    (import ../modules/programs) ++
    (import ../modules/shell);

  xdg = {
    enable = true;
  };

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
      gopass
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
      nurl
      pgformatter
      postgresql_16_jit
      ripgrep
      sad
      sesh
      silver-searcher
      tokei
      unar
      watchman
      wget
      yazi
      zellij
      zoxide
    ];
    stateVersion = "24.11";
    sessionVariables = {
      PAGER = "less";
      LESS = "-RiF --mouse --wheel-lines=3";
      CLICOLOR = 1;
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
      # fzf
      FZF_FIND_FILE_COMMAND = "fd --type f";
      FZF_OPEN_COMMAND = "fd --type f";
      # l10n
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

}
