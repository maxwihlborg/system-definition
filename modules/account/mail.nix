{ pkgs, config, ... }:
{
  programs.notmuch = {
    enable = true;
  };

  programs.lieer.enable = true;
  # services.lieer.enable = true;

  programs.neomutt = {
    enable = true;
    vimKeys = true;
    sort = "reverse-date";
    sidebar = {
      enable = true;
    };
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

        neomutt = {
          enable = true;
          sendMailCommand = "gmi send -t -C ${config.accounts.email.maildirBasePath}/wtr";
          showDefaultMailbox = false;
          extraConfig = ''
            set virtual_spoolfile = yes
          '';
        };

        notmuch = {
          enable = true;
          neomutt = {
            enable = true;
            virtualMailboxes = [
              { name = "INBOX"; query = "folder:/wtr/ tag:inbox"; }
              { name = "Unread"; query = "folder:/wtr/ tag:unread"; }
              { name = "Archive"; query = "folder:/wtr/ tag:archive"; }
              { name = "Sent"; query = "folder:/wtr/ tag:sent"; }
              { name = "Trash"; query = "folder:/wtr/ tag:trash"; }
            ];
          };
        };

        lieer.enable = true;
      };
    };
}
