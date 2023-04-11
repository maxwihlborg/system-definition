{ pkgs, ... }: {
  # home.packages = with pkgs; [
  #   ripgrep
  #   sad
  #   fd
  #   fzf
  #   curl
  #   less
  # ];

  home.packages = with pkgs;[
    ripgrep
    fish
    sad
    fd
    fzf
    curl
    less
  ];

  home.stateVersion = "22.11";

  programs.alacritty = {
    settings = import ./alacritty {
      inherit pkgs;
    };
    enable = true;
  };

  home.file.".profile".text = ''
    ${pkgs.fish}/bin/fish && exit;
  '';

  programs.zsh.enable = true;
  programs.home-manager.enable = true;
}
