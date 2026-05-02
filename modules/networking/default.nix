{ lib, ... }:

{
  networking = {
    hostName = lib.mkDefault "nixos";

    nameservers = [
      "192.168.0.1"
      "1.1.1.1"
    ];

    networkmanager = {
      enable = true;
    };
    useDHCP = lib.mkDefault true;
    wireless.enable = lib.mkDefault true;
  };
}
