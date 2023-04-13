{ pkgs, user, ... }:
{
  environment = {
    shells = with pkgs;[ fish ];
  };

  users.users."${user}" = {
    home = "/Users/${user}";
    shell = pkgs.fish;
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      swapLeftCommandAndLeftAlt = false;
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

  programs = {
    fish.enable = true;
  };

  services = {
    nix-daemon.enable = true;
  };
}
