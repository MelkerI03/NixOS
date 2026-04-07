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
    ./qemu.nix
  ];

  users.extraGroups.vboxusers.members = [ "viking" ];

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
    loader = {
      # Do not use, It fills the /boot dir
      grub = {
        enable = false;
        efiSupport = true;
        device = "nodev";
      };

      systemd-boot = {
        enable = true;
        configurationLimit = 5; # auto-prune old entries
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    kernelParams = [
      "usbcore.autosuspend=-1"
    ];
    kernelModules = [
      "kvm" # For VMs
      "kvm_intel"

      "uvcvideo" # Webcam
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  networking = {
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Stockholm";

  console = {
    useXkbConfig = true;
  };

  users = {
    groups = {
      viking = { };
      libvirtd.members = [ "viking" ];
      kvm.members = [ "viking" ];
    };
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
        "docker"
      ];
      shell = pkgs.zsh;
    };
  };

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware.enableAllFirmware = true;

  #----=[ Services ]=----#
  services = {
    # Firmware
    fwupd.enable = true;

    # Sound
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Keyring
    gnome.gnome-keyring.enable = true;
    dbus.packages = [ pkgs.gnome-keyring ];

    # Usb
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    # Configure keymap in X11
    xserver.xkb = {
      layout = "se";
      options = "caps:escape";
    };

    # Mouse settings
    libinput = {
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
    };

    qbittorrent.enable = true;

    ntp.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    cups-pdf.enable = true;
    browsed.enable = false;
    # browsedConf = ''
    #   CreateIPPPrinterQueues None
    #   CreateRemoteRawPrinterQueues no
    # '';
    drivers = with pkgs; [
      gutenprint
      hplip
      cnijfilter2
      hplipWithPlugin
      cups-filters
      cups-browsed
    ];
  };
  services.avahi.enable = true;
  # Discover printers
  services.system-config-printer.enable = true;
  systemd.services.add-network-printers = {
    description = "Dynamically add available network printers to CUPS";
    script = ''
      ${pkgs.avahi}/bin/avahi-browse -rtp _ipp._tcp | while read -r line; do
        if [[ "$line" == =* ]]; then
          IP_ADDRESS=$(${pkgs.gawk}/bin/awk -F';' '{print $8}' <<< "$line")
          RAW_NAME=$(${pkgs.gawk}/bin/awk -F';' '{print $4}' <<< "$line")
          if [[ "$IP_ADDRESS" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            CLEAN_NAME=$(echo "$RAW_NAME" | ${pkgs.gnused}/bin/sed 's/\\032/ /g')
            CLEAN_NAME=$(printf '%b\n' "$CLEAN_NAME")
            LAST_OCTET=$(${pkgs.gawk}/bin/awk -F'.' '{print $4}' <<< "$IP_ADDRESS")
            if [[ "$CLEAN_NAME" == *Color* ]]; then
              QUEUE_NAME="COLOR''${LAST_OCTET}"
            else
              QUEUE_NAME="BW''${LAST_OCTET}"
            fi
            DEVICE_URI="ipp://$IP_ADDRESS/ipp/print"
            echo "Adding printer: $QUEUE_NAME at $DEVICE_URI"
            ${pkgs.cups}/bin/lpadmin -p "$QUEUE_NAME" -v "$DEVICE_URI" -m everywhere -E -o printer-is-shared=false
          fi
        fi
      done
    '';

    after = [
      "network-online.target"
      "cups.service"
    ];
    wants = [ "cups.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
  };

  systemd.services.create-user-pdf-links = {
    description = "Create CUPS-PDF symlinks based on directories in /home";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      # This provides all the necessary commands: basename, mkdir, ln, chown, etc.
      path = [ pkgs.coreutils ];
    };
    script = ''
      # Loop through every directory in /home
      for homedir in /home/*; do
        if [ -d "$homedir" ]; then
          # Extract the username from the directory path
          user=$(basename "$homedir")
          # Define the paths
          SPOOL_DIR="/var/spool/cups-pdf-pdf/users/$user"
          LINK_NAME="$homedir/PDF"
          # Create the spool directory as root
          mkdir -p "$SPOOL_DIR"
          # Set its ownership to the correct user
          chown "$user":"users" "$SPOOL_DIR"
          # Check if the symlink exists
          if [ ! -e "$LINK_NAME" ]; then
            # Create the symlink as root
            ln -s "$SPOOL_DIR" "$LINK_NAME"
            # Set the ownership of the symlink itself (-h flag) to the correct user
            chown -h "$user":"users" "$LINK_NAME"
          fi
        fi
      done
    '';
  };

  # Set up virtualisation
  virtualisation.libvirtd = {
    enable = true;

    # Enable TPM emulation (for Windows 11)
    qemu = {
      swtpm.enable = true;
    };
  };

  # Enable USB redirection
  virtualisation.spiceUSBRedirection.enable = true;

  # Allow VM management

  # Enable VM networking and file sharing
  environment.systemPackages = with pkgs; [
    # ... your other packages ...
    gnome-boxes # VM management
    dnsmasq # VM networking
    phodav # (optional) Share files with guest VMs
  ];

  system.stateVersion = "25.05";
}
