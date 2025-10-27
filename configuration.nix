{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./power-management.nix
    ./nvidia.nix
    ./packages.nix
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  nvidia.enable = false;

  nixpkgs.config.allowUnfree = true;

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 7;
    loader.systemd-boot.consoleMode = "max"; # Maximize text size
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";

    kernelParams = [ "usbcore.autosuspend=300" ];
    kernelModules = [
      "kvm" # For VMs
      "kvm_intel"

      "uvcvideo" # Webcam
    ];

    resumeDevice = "/dev/disk/by-uuid/98e5f53b-7c04-430b-bd9b-baa5a88e2d65";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/98e5f53b-7c04-430b-bd9b-baa5a88e2d65"; }
  ];

  systemd.services."unload-thinkpad-acpi" = {
    description = "Unload thinkpad_acpi before suspend";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kmod}/bin/modprobe -r thinkpad_acpi";
      ExecStop = "${pkgs.kmod}/bin/modprobe thinkpad_acpi";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;

    pam.services = {
      hyprlock = { };
      kwallet = {
        name = "kwallet";
        enableKwallet = true;
      };
    };
  };

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  networking = {
    hostName = "nixos";
    nameservers = [
      "192.168.0.1"
      "1.1.1.1"
    ];
    networkmanager = {
      enable = true;
    };

    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Stockholm";

  virtualisation.libvirtd.enable = true;

  console = {
    useXkbConfig = true;
  };

  users = {
    groups.viking = { };
    users.viking = {
      enable = true;

      name = "viking";
      hashedPassword = "$y$j9T$.t.wu6O5RZRooESu9KrBY.$wXp06dcetaWNNnul.7P5poo/G77v65bYU5habrmt0u.";
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
  xdg.portal.config.common.default = "*";
  programs.hyprland.enable = true;

  #----=[ Services ]=----#
  services = {
    # Firmware
    fwupd.enable = true;

    # Keyring
    gnome.gnome-keyring.enable = true;
    dbus.packages = [ pkgs.gnome-keyring ];

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
  };

  system.stateVersion = "25.05";
}
