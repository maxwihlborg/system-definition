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
      experimental-features = nix-command flakes
    '';
  };

  ids = {
    gids = {
      nixbld = 30000;
    };
  };
  system = {
    stateVersion = 6;
    primaryUser = user;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      swapLeftCommandAndLeftAlt = false;
    };
    defaults = {
      dock.autohide = true;
      trackpad = {
        Clicking = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 18;
        KeyRepeat = 3;
      };
    };
  };


  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  # homebrew = {
  #   enable = true;
  # };

  programs = {
    fish.enable = true;
  };
}
