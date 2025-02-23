{ pkgs, ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        general = {
          import = [
            "${pkgs.vimPlugins.kanagawa-nvim}/extras/alacritty/kanagawa_wave.toml"
          ];
        };
        window = {
          decorations = "buttonless";
          dynamic_padding = true;
          dynamic_title = true;
        };
        scrolling = {
          history = 0;
        };
        cursor = {
          style = "Block";
          unfocused_hollow = true;
        };
        mouse = {
          hide_when_typing = false;
          bindings = [
            { action = "PasteSelection"; mouse = "Middle"; }
          ];
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
        keyboard = {
          bindings = [
            { key = "Paste"; action = "Paste"; }
            { key = "Copy"; action = "Copy"; }
            { key = "PageUp"; mods = "Shift"; mode = "~Alt"; action = "ScrollPageUp"; }
            { key = "PageDown"; mods = "Shift"; mode = "~Alt"; action = "ScrollPageDown"; }
            { key = "Home"; mods = "Shift"; mode = "~Alt"; action = "ScrollToTop"; }
            { key = "End"; mods = "Shift"; mode = "~Alt"; action = "ScrollToBottom"; }

            # Tmux
            # Rename the current tmux window
            { key = "Comma"; mods = "Command"; chars = "\\u0002\\u002c"; }

            # Change session
            { key = "S"; mods = "Command"; chars = "\\u0002\\u0073"; }
            # Open project picker
            { key = "P"; mods = "Command"; chars = "\\u0002\\u0054"; }

            # Select window 1-9
            { key = "Key1"; mods = "Command"; chars = "\\u0002\\u0031"; }
            { key = "Key2"; mods = "Command"; chars = "\\u0002\\u0032"; }
            { key = "Key3"; mods = "Command"; chars = "\\u0002\\u0033"; }
            { key = "Key4"; mods = "Command"; chars = "\\u0002\\u0034"; }
            { key = "Key5"; mods = "Command"; chars = "\\u0002\\u0035"; }
            { key = "Key6"; mods = "Command"; chars = "\\u0002\\u0036"; }
            { key = "Key7"; mods = "Command"; chars = "\\u0002\\u0037"; }
            { key = "Key8"; mods = "Command"; chars = "\\u0002\\u0038"; }
            { key = "Key9"; mods = "Command"; chars = "\\u0002\\u0039"; }

            # Create a new tmux window
            { key = "T"; mods = "Command"; chars = "\\u0002\\u0063"; }
            # Break the current tmux pane out of the tmux window
            { key = "T"; mods = "Command|Shift"; chars = "\\u0002\\u0021"; }
            # Kill the current tmux pane (and window if last pane)
            { key = "W"; mods = "Command"; chars = "\\u0002\\u0078"; }
            # Toggle the zoom state of the current tmux pane
            { key = "Z"; mods = "Command"; chars = "\\u0002\\u007a"; }
            # Split the current pane into two; left and right
            { key = "N"; mods = "Command"; chars = "\\u0002\\u0025"; }
            # Split the current pane into two; top and bottom.
            { key = "N"; mods = "Command|Shift"; chars = "\\u0002\\u0022"; }
            # Change to the next tmux window
            { key = "J"; mods = "Command"; chars = "\\u0002\\u0068"; }
            # Change to the previous tmux window
            { key = "K"; mods = "Command"; chars = "\\u0002\\u006c"; }

            # (macOS only)
            { key = "Key0"; mods = "Command"; action = "ResetFontSize"; }
            { key = "Equals"; mods = "Command"; action = "IncreaseFontSize"; }
            { key = "Plus"; mods = "Command"; action = "IncreaseFontSize"; }
            { key = "NumpadAdd"; mods = "Command"; action = "IncreaseFontSize"; }
            { key = "Minus"; mods = "Command"; action = "DecreaseFontSize"; }
            { key = "NumpadSubtract"; mods = "Command"; action = "DecreaseFontSize"; }
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
  };
}
