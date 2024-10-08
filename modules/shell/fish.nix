{ pkgs, config, ... }:
{
  programs = {
    fish = {
      enable = true;
      plugins = [
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
        gap = {
          wraps = "git";
          description = "git add --patch";
          body = "git add --patch";
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
        env-init = {
          description = "setup dir with flakes";
          body = ''
            echo "Init flakes"
            nix flake new -t github:nix-community/nix-direnv .
            echo "Setup just"
            echo -n "set positional-arguments := true

            # List all recipies
            @default:
              just --list

            # Run command
            @run *args='\':
              echo \$@
            " > justfile
          '';
        };
        t = {
          wraps = "sesh";
          description = "sesh connect from zoxide query";
          body = "sesh connect $(zoxide query $argv)";
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
      loginShellInit = ''
        # Homebrew
        eval (/opt/homebrew/bin/brew shellenv)

        # Path
        set -gx GOPATH $HOME/gocode
        set -gx PNPM_HOME $HOME/Library/pnpm
        set -gx RUST_HOME $HOME/.cargo/bin

        set -gx PATH $GOPATH/bin $PNPM_HOME $RUST_HOME $PATH
      '';
      interactiveShellInit = ''
        # Zoxide
        ${pkgs.zoxide}/bin/zoxide init fish | source

        # Secrets
        source ${config.home.homeDirectory}/ghq/github.com/maxwihlborg/system-definition/config/fish/env.fish

        set -gx OPENAI_API_KEY $(vsh decrypt vsh:v1:KenJYkez:oqivBeUcUr6IU6aux_tBe9t4KhBBf_bB6c81fc6t-fl2KnvNX2wrA-bKVkoMpeT0uOSe)

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
      '';
      shellAliases = {
        # eza
        la = "eza -a";
        ll = "eza -l";
        lla = "eza -la";
        lt = "eza -T -I node_modules";

        # node
        p = "pnpm";
        n = "npm";

        # git
        g = "git";

        # lazy
        gg = "lazygit";
        gd = "lazydocker";

        md = "mkdir -p";

        # nav
        ".." = "cd ..";
        ".2" = "cd ../..";
        ".3" = "cd ../../..";
        c = "cd $HOME/.config";
        j = "z";

        # tmux
        mx = "tmux";

        # GoPass
        pass = "gopass";

        # neovim
        nn = "nvim";
        ne = "nvim";
        nb = "nvim +DBUI";
        nnc = "nvim -c 'cbuffer | copen | bdelete! 1'";
      };
    };
  };
}
