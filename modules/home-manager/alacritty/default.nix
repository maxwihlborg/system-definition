{ pkgs, ... }: {
  import = [
    (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/folke/tokyonight.nvim/1d1d1722e035389dc3bfc2489133fa58533c310f/extras/alacritty/tokyonight_night.yml";
      sha256 = "sha256-eQZRMc1jpE6spIuHCj7s20gR/0iy/MLOAzz7U+Mg/EY=";
    })
  ];
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
    "bold_italic" = {
      family = "JetBrainsMono Nerd Font Mono";
      style = "Bold Italic";
    };
  };
  bell = {
    duration = 0;
  };
  "key_bindings" = [
    {
      key = "Paste";
      action = "Paste";
    }
    {
      key = "Copy";
      action = "Copy";
    }
    {
      key = "PageUp";
      mods = "Shift";
      mode = "~Alt";
      action = "ScrollPageUp";
    }
    {
      key = "PageDown";
      mods = "Shift";
      mode = "~Alt";
      action = "ScrollPageDown";
    }
    {
      key = "Home";
      mods = "Shift";
      mode = "~Alt";
      action = "ScrollToTop";
    }
    {
      key = "End";
      mods = "Shift";
      mode = "~Alt";
      action = "ScrollToBottom";
    }
    {
      key = "Comma";
      mods = "Command";
      chars = "\u0002,";
    }
    {
      key = "S";
      mods = "Command";
      chars = "\u0002s";
    }
    {
      key = "Key1";
      mods = "Command";
      chars = "\u00021";
    }
    {
      key = "Key2";
      mods = "Command";
      chars = "\u00022";
    }
    {
      key = "Key3";
      mods = "Command";
      chars = "\u00023";
    }
    {
      key = "Key4";
      mods = "Command";
      chars = "\u00024";
    }
    {
      key = "Key5";
      mods = "Command";
      chars = "\u00025";
    }
    {
      key = "Key6";
      mods = "Command";
      chars = "\u00026";
    }
    {
      key = "Key7";
      mods = "Command";
      chars = "\u00027";
    }
    {
      key = "Key8";
      mods = "Command";
      chars = "\u00028";
    }
    {
      key = "Key9";
      mods = "Command";
      chars = "\u00029";
    }
    {
      key = "T";
      mods = "Command";
      chars = "\\x02\\x63";
    }
    {
      key = "T";
      mods = "Command|Shift";
      chars = "\\x02\\x21";
    }
    {
      key = "W";
      mods = "Command";
      chars = "\u0002x";
    }
    {
      key = "Z";
      mods = "Command";
      chars = "\u0002z";
    }
    {
      key = "N";
      mods = "Command";
      chars = "\u0002%";
    }
    {
      key = "N";
      mods = "Command|Shift";
      chars = "\u0002\"";
    }
    {
      key = "J";
      mods = "Command";
      chars = "\u0002h";
    }
    {
      key = "K";
      mods = "Command";
      chars = "\u0002l";
    }
    {
      key = "P";
      mods = "Command";
      chars = "\u0002T";
    }
    {
      key = "Key0";
      mods = "Command";
      action = "ResetFontSize";
    }
    {
      key = "Equals";
      mods = "Command";
      action = "IncreaseFontSize";
    }
    {
      key = "Plus";
      mods = "Command";
      action = "IncreaseFontSize";
    }
    {
      key = "NumpadAdd";
      mods = "Command";
      action = "IncreaseFontSize";
    }
    {
      key = "Minus";
      mods = "Command";
      action = "DecreaseFontSize";
    }
    {
      key = "NumpadSubtract";
      mods = "Command";
      action = "DecreaseFontSize";
    }
    {
      key = "V";
      mods = "Command";
      action = "Paste";
    }
    {
      key = "C";
      mods = "Command";
      action = "Copy";
    }
    {
      key = "M";
      mods = "Command";
      action = "Minimize";
    }
    {
      key = "Q";
      mods = "Command";
      action = "Quit";
    }
    {
      key = "F";
      mods = "Command|Control";
      action = "ToggleFullscreen";
    }
    {
      key = "F";
      mods = "Command";
      mode = "~Search";
      action = "SearchForward";
    }
    {
      key = "B";
      mods = "Command";
      mode = "~Search";
      action = "SearchBackward";
    }
  ];
}
