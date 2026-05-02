{ ... }:

{
  services = {
    fwupd.enable = true;
    dbus.enable = true;
    tailscale.enable = true;
    udisks2.enable = true;
    qbittorrent.enable = true;
    ntp.enable = true;
    avahi.enable = true;
  };
}
