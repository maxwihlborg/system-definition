{ pkgs, ... }:
let
  repo = pkgs.fetchFromGitHub {
    owner = "vifm";
    repo = "vifm";
    rev = "8499457ead5a7a0cfcb4b5c43441975c2208c81d";
    hash = "sha256-8krBFo35RNxLGeTSjOd9OhDqnaSqAWi/B1e0yIdZb/U=";
  };
in
{
  xdg.configFile = {
    "vifm/plugins/devicons".source = "${repo}/data/plugins/devicons";
  };
  programs = {
    vifm = {
      enable = true;

      extraConfig = ''
        " Marks

        mark h ~/
        mark s ~/ghq/github.com/maxwihlborg/system-definition/
        mark g ~/ghq/
        mark d ~/Downloads/

        " Options

        set vicmd=nvim
        set trash
        set trashdir=~/.Trash
        set grepprg=rg

        " Keymaps

        " Navigation
        map s :
        map ä {
        map ö }
        map J 8j
        map K 8k

        " Toggle hidden files
        map . za

        nnoremap S :sort<cr>
        nnoremap q :quit<cr>

        nnoremap w :view<cr>
        vnoremap w :view<cr>gv

        nnoremap I cw<c-a>
        nnoremap cc cw<c-u>
        nnoremap A cw

        fileviewer *.bmp,*.jpg,*.avif,*.webp,*.jpeg,*.png,*.gif,*.xpm magick identify %f -verbose
        fileviewer *.zip,*.jar,*.war,*.ear zip -sf %c
        fileviewer justfile just -f %c --list
        fileviewer *.tar,*.tar.bz2,*.tbz2,*.tgz,*.tar.gz tar -tf %f
      '';
    };
  };
}
