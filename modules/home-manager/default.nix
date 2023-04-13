{ pkgs, ... }: {
  home.packages = with pkgs;[
    ripgrep
    # fish
    nushell
    delta
    sad
    exa
    fd
    fzf
    curl
    less
    zellij
  ];

  home.stateVersion = "22.11";
  home.sessionVariables = {
    PAGER = "less";
    LESS = "-RiF --mouse --wheel-lines=3";
    CLICOLOR = 1;
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
    XDG_CONFIG_HOME = "$HOME/.config";
    # fzf
    FZF_FIND_FILE_COMMAND = "fd --type f";
    FZF_OPEN_COMMAND = "fd --type f";
    # l10n
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  programs.git = {
    enable = true;
    userEmail = "6181962+maxwihlborg@users.noreply.github.com";
    userName = "Max Wihlborg";
    aliases = {
      rename = "!moveit() { git push origin --delete `git branch --show-current` || true; git branch -m $1; git push --set-upstream origin $1; }; moveit";
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
      rb = "rebase";
    };
    extraConfig = {
      init = { defaultBranch = "main"; };
      push = { default = "simple"; };
      pull = { rebase = true; };
      fetch = { prune = true; };
    };
    ignores = [
      # General
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"

      # Icon must end with two \r
      "Icon\r\r"

      # Thumbnails
      "._*"

      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"

      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
    ];
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "${pkgs.delta}/bin/delta --dark --paging=never --24-bit-color=never";
          branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium --oneline {{branchName}} --";
        };
      };
    };
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "ghq";
        src = pkgs.fetchFromGitHub {
          owner = "decors";
          repo = "fish-ghq";
          rev = "cafaaabe63c124bf0714f89ec715cfe9ece87fa2";
          sha256 = "sha256-6b1zmjtemNLNPx4qsXtm27AbtjwIZWkzJAo21/aVZzM=";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "fzf";
          rev = "479fa67d7439b23095e01b64987ae79a91a4e283";
          sha256 = "sha256-28QW/WTLckR4lEfHv6dSotwkAKpNJFCShxmKFGQQ1Ew=";
        };
      }
      {
        name = "lf-icons";
        src = pkgs.fetchFromGitHub {
          owner = "joshmedeski";
          repo = "fish-lf-icons";
          rev = "d1c47b2088e0ffd95766b61d2455514274865b4f";
          sha256 = "sha256-6po/PYvq4t0K8Jq5/t5hXPLn80iyl3Ymx2Whme/20kc=";
        };
      }
    ];
    functions = {
      ly = {
        wraps = "lazygit";
        description = "yadm in lazygit-ish";
        body = "lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git";
      };
      lfcd = {
        body = ''
          set tmp (mktemp)
          # `command` is needed in case `lfcd` is aliased to `lf`
          command lf -last-dir-path=$tmp $argv

          if test -f "$tmp"
            set dir (cat $tmp)
            rm -f $tmp
            if test -d "$dir"
              if test "$dir" != (pwd)
                cd $dir
              end
            end
          end
        '';
      };
      sys-switch = {
        wraps = "nix";
        description = "rebuild system flake";

        body = "darwin-rebuild switch --flake $(ghq root)/github.com/maxwihlborg/system-definition/ $argv";
      };
      sys-update = {
        description = "update system flake";
        body = ''
          pushd $(ghq root)/github.com/maxwihlborg/system-definition
          pushd $(ghq root)/github.com/maxwihlborg/system-definition
          nix flake update
          sys-switch
          git add flake.lock
          git commit -m "v.$(date +%F)"
          git push
          popd
        '';
      };

      fish_prompt = {
        body = ''
          set -l last_status $status
          set -l normal (set_color normal)
          set -l color_cwd (set_color $fish_color_cwd)
          set -l color_wrapp (set_color blue)
          set -l suffix
          set -l prompt_status
          set -l path_cwd

          switch $USER
            case root toor
              set suffix "#"
            case '*'
              set suffix "\$"
          end

          if test $last_status -ne 0
            set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
          end

          switch $PWD
            case $HOME
              set path_cwd '~'
            case '*'
              set path_cwd (basename $PWD)
          end

          echo -n -s $color_wrapp '[' $color_cwd $path_cwd $normal (__fish_vcs_prompt) $prompt_status $color_wrapp ']' $normal $suffix ' '
        '';
      };
    };
    shellInit = ''
      # Homebrew
      eval (/opt/homebrew/bin/brew shellenv)

      # Path
      set -gx PATH ~/bin /usr/local/sbin $PATH

      # Go/Rust
      set -gx GOPATH $HOME/gocode
      set -gx PATH $GOPATH/bin $HOME/.cargo/bin $PATH

      # JS
      set -gx PNPM_HOME $HOME/Library/pnpm
      set -gx PATH $PNPM_HOME (yarn global bin) $PATH
    '';
    interactiveShellInit = ''
      # Overrides
      set fish_color_cwd yellow
      set fish_greeting

      # Fish git prompt
      set __fish_git_prompt_show_informative_status yes
      set __fish_git_prompt_color_upstream_ahead green
      set __fish_git_prompt_color_upstream_behind red
      set __fish_git_prompt_color_cleanstate green
      set __fish_git_prompt_color_branch yellow

      # Colors
      set normal (set_color normal)
      set magenta (set_color magenta)
      set yellow (set_color yellow)
      set green (set_color green)
      set red (set_color red)
      set gray (set_color -o black)

      # Key maps
      bind \cu '__fzf_open --editor'
      bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'

      # Zoxide
      zoxide init fish | source
    '';
    shellAliases = {
      # exa
      la = "exa -a";
      ll = "exa -l";
      lla = "exa -la";
      lt = "exa -T -I node_modules";

      # node
      p = "pnpm";

      # git
      g = "git";
      gg = "lazygit";

      md = "mkdir -p";

      # nav
      ".." = "cd ..";
      ".2" = "cd ../..";
      ".3" = "cd ../../..";
      c = "cd $HOME/.config";
      j = "z";

      # tmux
      mx = "tmux";
      tx = "tmuxinator";

      # neovim
      nn = "nvim";
      ne = "nvim";
      nb = "nvim +DBUI";
    };
  };

  programs.alacritty = {
    settings = import ./alacritty {
      inherit pkgs;
    };
    enable = true;
  };

  # setup the fish
  home.file.".profile".text = ''
    exec fish
  '';
}
