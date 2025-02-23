{ pkgs, config, ... }:
{
  imports =
    (import ../modules/account) ++
    (import ../modules/programs) ++
    (import ../modules/shell);

  xdg = {
    enable = true;
  };


  sops = {
    age.keyFile = "${config.xdg.dataHome}/system-definition/key.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets.open_api_token = { };
  };

  home = {
    packages = with pkgs; [
      age
      atac
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
      git-agecrypt
      git-crypt
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
      p7zip
      pgformatter
      postgresql_16_jit
      repgrep
      ripgrep
      sad
      serie
      sesh
      silver-searcher
      skim
      sops
      tokei
      unar
      watchman
      wget
      yazi
      zellij
      zoxide
    ];
    stateVersion = "25.05";
    sessionVariables = {
      PAGER = "less";
      LESS = "-RiF --mouse --wheel-lines=3";
      CLICOLOR = 1;
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
      # fzf
      FZF_FIND_FILE_COMMAND = "fd --type f";
      FZF_OPEN_COMMAND = "fd --type f";
      # skim
      SKIM_DEFAULT_COMMAND = "fd --type f";
      # l10n
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

}
