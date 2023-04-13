{ pkgs, ... }:
let
  theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/folke/tokyonight.nvim/1d1d1722e035389dc3bfc2489133fa58533c310f/extras/alacritty/tokyonight_night.yml";
    sha256 = "sha256-eQZRMc1jpE6spIuHCj7s20gR/0iy/MLOAzz7U+Mg/EY=";
  };
in
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        import = [ theme ];
        window = {
          "dynamic_padding" = true;
          decorations = "none";
        };
        font = {
          size = 14;
          normal = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold Italic";
          };
        };
        bell = {
          duration = 0;
        };
        key_bindings = [
          { key = "Paste"; action = "Paste"; }
          { key = "Copy"; action = "Copy"; }
          { key = "PageUp"; mods = "Shift"; mode = "~Alt"; action = "ScrollPageUp"; }
          { key = "PageDown"; mods = "Shift"; mode = "~Alt"; action = "ScrollPageDown"; }
          { key = "Home"; mods = "Shift"; mode = "~Alt"; action = "ScrollToTop"; }
          { key = "End"; mods = "Shift"; mode = "~Alt"; action = "ScrollToBottom"; }

          # Tmux
          # Rename the current tmux window
          { key = "Comma"; mods = "Command"; chars = "\\x02\\x2c"; }

          # Change session
          { key = "S"; mods = "Command"; chars = "\\x02\\x73"; }

          # Select window 1-9
          { key = "Key1"; mods = "Command"; chars = "\\x02\\x31"; }
          { key = "Key2"; mods = "Command"; chars = "\\x02\\x32"; }
          { key = "Key3"; mods = "Command"; chars = "\\x02\\x33"; }
          { key = "Key4"; mods = "Command"; chars = "\\x02\\x34"; }
          { key = "Key5"; mods = "Command"; chars = "\\x02\\x35"; }
          { key = "Key6"; mods = "Command"; chars = "\\x02\\x36"; }
          { key = "Key7"; mods = "Command"; chars = "\\x02\\x37"; }
          { key = "Key8"; mods = "Command"; chars = "\\x02\\x38"; }
          { key = "Key9"; mods = "Command"; chars = "\\x02\\x39"; }

          # Create a new tmux      window
          { key = "T"; mods = "Command"; chars = "\\x02\\x63"; }
          # Break the current tmux pane out of the tmux window
          { key = "T"; mods = "Command|Shift"; chars = "\\x02\\x21"; }
          # Kill the current tmux  pane (and window if last pane)
          { key = "W"; mods = "Command"; chars = "\\x02\\x78"; }
          # Toggle the zoom state  of the current tmux pane
          { key = "Z"; mods = "Command"; chars = "\\x02\\x7a"; }
          # Split the current pane into two; left and right
          { key = "N"; mods = "Command"; chars = "\\x02\\x25"; }
          # Split the current pane into two; top and bottom.
          { key = "N"; mods = "Command|Shift"; chars = "\\x02\\x22"; }
          # Change to the next     tmux window
          { key = "J"; mods = "Command"; chars = "\\x02\\x68"; }
          # Change to the previous tmux window
          { key = "K"; mods = "Command"; chars = "\\x02\\x6c"; }
          # Change to the previous tmux window
          { key = "P"; mods = "Command"; chars = "\\x02\\x54"; }

          # (macOS only)
          { key = "Key0"; mods = "Command"; action = "ResetFontSize"; }
          { key = "Equals"; mods = "Command"; action = "IncreaseFontSize"; }
          { key = "Plus"; mods = "Command"; action = "IncreaseFontSize"; }
          { key = "NumpadAdd"; mods = "Command"; action = "IncreaseFontSize"; }
          { key = "Minus"; mods = "Command"; action = "DecreaseFontSize"; }
          { key = "NumpadSubtract"; mods = "Command"; action = "DecreaseFontSize"; }
          # { key = "W"; mods = "Command"; action = "None"; }
          # { key = "N"; mods = "Command"; action = "SpawnNewInstance"; }
          { key = "V"; mods = "Command"; action = "Paste"; }
          { key = "C"; mods = "Command"; action = "Copy"; }
          { key = "M"; mods = "Command"; action = "Minimize"; }
          { key = "Q"; mods = "Command"; action = "Quit"; }
          { key = "F"; mods = "Command|Control"; action = "ToggleFullscreen"; }
          { key = "F"; mods = "Command"; mode = "~Search"; action = "SearchForward"; }
          { key = "B"; mods = "Command"; mode = "~Search"; action = "SearchBackward"; }
        ];
      };
    };
  };
}
