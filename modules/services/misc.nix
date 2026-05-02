{ ... }:

{
  services = {
    fwupd.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
    };
    tailscale.enable = true;
    udisks2.enable = true;
    qbittorrent.enable = true;
    ntp.enable = true;
    avahi.enable = true;
  };
}
