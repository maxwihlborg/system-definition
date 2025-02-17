{ pkgs, lib, ... }:
let
  keyValue = pkgs.formats.keyValue {
    listsAsDuplicateKeys = true;
    mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
  };
in
{
  # FIXME change to home manager when darwin ghostty works
  xdg.configFile."ghostty/config" = {
    source = keyValue.generate "ghostty-config" {
      theme = "${pkgs.vimPlugins.tokyonight-nvim}/extras/ghostty/tokyonight_night";

      font-family = "JetbrainsMonoNL Nerd Font";
      font-feature = "-calt";
      font-thicken = true;

      cursor-style = "block";
      cursor-style-blink = false;

      window-padding-balance = true;
      window-decoration = false;

      macos-titlebar-style = "hidden";

      mouse-hide-while-typing = true;

      confirm-close-surface = false;
      quit-after-last-window-closed = true;

      keybind = [
        "super+b>r=reload_config"

        # Tmux
        # Rename the current tmux window
        "super+,=text:\\x02\\x2c"

        # Change session
        "super+s=text:\\x02\\x73"
        # Open project picker
        "super+p=text:\\x02\\x54"

        # Select window 1-9
        "super+1=text:\\x02\\x31"
        "super+2=text:\\x02\\x32"
        "super+3=text:\\x02\\x33"
        "super+4=text:\\x02\\x34"
        "super+5=text:\\x02\\x35"
        "super+6=text:\\x02\\x36"
        "super+7=text:\\x02\\x37"
        "super+8=text:\\x02\\x38"
        "super+9=text:\\x02\\x39"

        # Create a new tmux window
        "super+t=text:\\x02\\x63"
        # Break the current tmux pane out of the tmux window
        "super+shift+t=text:\\x02\\x21"
        # Kill the current tmux pane (and window if last pane)
        "super+w=text:\\x02\\x78"
        # Toggle the zoom state of the current tmux pane
        "super+z=text:\\x02\\x7a"
        # Split the current pane into two; left and right
        "super+n=text:\\x02\\x25"
        # Split the current pane into two; top and bottom.
        "super+shift+n=text:\\x02\\x22"
        # Change to the next tmux window
        "super+j=text:\\x02\\x68"
        # Change to the previous tmux window
        "super+k=text:\\x02\\x6c"
      ];
    };
  };
}
