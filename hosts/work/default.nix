{ lib, ... }:

{
  imports = [
    ./hardware.nix

    ../../profiles/common.nix
    ../../profiles/desktop.nix

    ../../modules/programs/zsh.nix

    ../../modules/packages/base.nix
    ../../modules/packages/networking.nix
    ../../modules/packages/desktop.nix

    ../../modules/system/nix.nix
    ../../modules/system/boot.nix
    ../../modules/system/time.nix

    ../../modules/users/viking.nix
    ../../modules/networking

    ../../modules/hardware/firmware.nix

    ../../modules/services/audio.nix
    ../../modules/services/virtualization.nix
    ../../modules/services/wireguard.nix
    ../../modules/services/desktop.nix
    ../../modules/services/misc.nix
  ];

  networking.hostName = "work";

  networking.wireless.enable = lib.mkForce false;
  hardware.bluetooth.enable = false;

  system.stateVersion = "25.05";
}
