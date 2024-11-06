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
          body = /* fish */"git add --patch";
        };
        lfcd = {
          body = /* fish */''
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
          body = /* fish */''
            echo "Init flakes"
            nix flake new -t github:nix-community/nix-direnv .
            echo "Setup just"
            echo -n "
            # list all recipies
            @default:
              just --list

            # run command
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

        fish_user_key_bindings = {
          body = /* fish */''
            # keymaps
            fish_vi_key_bindings

            bind \cu '__fzf_open --editor'
            bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'

            bind -M insert \cu '__fzf_open --editor'
            bind -M insert \co '__fzf_open --editor'
          '';
        };

        fish_mode_prompt = {
          body = /* fish */''
            set -l normal (set_color normal)
            switch $fish_bind_mode
              case default
                echo -n -s '[' (set_color red) 'N' $normal ']'
              case insert
                echo -n -s '[' (set_color green) 'I' $normal ']'
              case replace_one
                echo -n -s '[' (set_color green) 'R' $normal ']'
              case visual
                echo -n -s '[' (set_color magenta) 'V' $normal ']'
              case '*'
                echo -n -s '[' (set_color red) '?' $normal ']'
            end
          '';
        };

        fish_prompt = {
          body = /* fish */''
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
      loginShellInit = /* fish */''
        # Homebrew
        eval (/opt/homebrew/bin/brew shellenv)

        # Path
        set -gx GOPATH $HOME/gocode
        set -gx PNPM_HOME $HOME/Library/pnpm
        set -gx RUST_HOME $HOME/.cargo/bin

        set -gx PATH $GOPATH/bin $PNPM_HOME $RUST_HOME $PATH
      '';
      interactiveShellInit = /* fish */''
        # zoxide
        ${pkgs.zoxide}/bin/zoxide init fish | source

        # transient secrets
        set -gx OPENAI_API_KEY $(vsh decrypt vsh:v1:KenJYkez:oqivBeUcUr6IU6aux_tBe9t4KhBBf_bB6c81fc6t-fl2KnvNX2wrA-bKVkoMpeT0uOSe)

        # overrides
        set fish_color_cwd yellow
        set fish_greeting

        # fish git prompt
        set __fish_git_prompt_show_informative_status yes
        set __fish_git_prompt_color_upstream_ahead green
        set __fish_git_prompt_color_upstream_behind red
        set __fish_git_prompt_color_cleanstate green
        set __fish_git_prompt_color_branch yellow
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
