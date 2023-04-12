{ pkgs, ... }:
{
  environment = {
    shells = with pkgs;[ fish ];
  };

  users.users.max.shell = "/run/current-system/sw/bin/zsh";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      dock.autohide = true;
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 20;
        KeyRepeat = 4;
      };
    };
  };

  # homebrew = {
  #   enable = true;
  # };

  services.nix-daemon.enable = true;
}
