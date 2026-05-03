{ inputs, ... }:

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
    ../../modules/system/power-management.nix

    ../../modules/users/viking.nix
    ../../modules/networking

    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/firmware.nix
    ../../modules/hardware/graphics.nix

    ../../modules/services/audio.nix
    ../../modules/services/desktop.nix
    ../../modules/services/virtualization.nix
    ../../modules/services/wireguard.nix
    ../../modules/services/misc.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = {
    inherit inputs;
  };

  home-manager.users.viking = import ./home.nix;

  my.graphics = {
    mode = "offload";

    nvidia = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  system.stateVersion = "25.05";
}
