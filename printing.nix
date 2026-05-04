{ pkgs, ... }:
{
  services = {
    # IPP everywhere printer discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed

        hplipWithPlugin
      ];
    };

    ipp-usb.enable = true;

    system-config-printer.enable = true;
  };

  programs.evince.enable = true;
}
