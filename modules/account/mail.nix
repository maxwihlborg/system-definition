{ pkgs, ... }:
{
  programs.notmuch = {
    enable = true;
  };

  programs.lieer.enable = true;
  # services.lieer.enable = true;

  programs.neomutt = {
    enable = true;
    vimKeys = true;
  };

  accounts.email =
    let
      mail = import ./mail.crypt.nix;
    in
    {
      accounts.wtr = {
        primary = true;
        realName = "Max Wihlborg";
        address = mail.address.wtr;
        userName = mail.address.wtr;
        flavor = "gmail.com";
        notmuch.enable = true;

        lieer.enable = true;
      };
    };
}
