{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./programs/config.nix
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 7;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";

    # VM kernel modules
    kernelModules = [
      "kvm"
      "kvm_intel"
    ];

    # Harddrive with /swap
    resumeDevice = "/dev/disk/by-uuid/9459f873-20bf-46dd-8b8b-2b9d8d22f43a";

    kernelParams = [
      # "resume=UUID=9459f873-20bf-46dd-8b8b-2b9d8d22f43a"
      # "resume_offset=10586112"
      "usbcore.autosuspend=-1"
    ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;

    # Enable hardware acceleration
    graphics.enable = true;
    graphics.enable32Bit = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };

      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime.offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  security = {
    rtkit.enable = true;

    pam.services.hyprlock = { };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Stockholm";

  virtualisation.libvirtd.enable = true;
  powerManagement.powertop.enable = true;

  console = {
    useXkbConfig = true;
  };

  users = {
    groups.viking = { };
    users.viking = {
      enable = true;

      name = "viking";
      home = "/home/viking/";
      createHome = true;
      isNormalUser = true;

      group = "viking";
      extraGroups = [
        "wheel"
        "input"
        "network"
        "libvirtd"
      ];
      shell = pkgs.zsh;
    };
  };

  xdg.portal.enable = true;

  #----=[ Services ]=----#
  services = {
    # Firmware
    fwupd.enable = true;

    # Usb
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    # Configure keymap in X11
    xserver.xkb.layout = "se";
    xserver.xkb.options = "caps:escape";

    # Enable CUPS to print documents.
    printing.enable = true;

    # Bluetooth GUI
    blueman.enable = true;

    openssh.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha-mauve";
      package = pkgs.kdePackages.sddm;
    };

    # Power Management, lid close currently crashes the system
    thermald.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      KillUserProcesses = false;

      AllowSuspend = true;
      AllowHibernation = true;
      AllowHybridSleep = false;
      AllowSuspendThenHibernate = true;

      HibernateDelaySec = 30;
    };
  };

  system.stateVersion = "25.05";
}
