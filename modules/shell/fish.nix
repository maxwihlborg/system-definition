{ pkgs, ... }:
{
  programs = {
    fish = {
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
  };
}
