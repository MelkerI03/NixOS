{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Limit boot menu entries
  boot.loader.systemd-boot.configurationLimit = 7;

  security.pam.services.hyprlock = {};

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  users.groups.viking = {};
  users.users.viking = {
    isNormalUser = true;
    group = "viking";
    extraGroups = [ "wheel" "input" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.ssh.startAgent = true;

  nixpkgs.overlays = [
    (final: prev: {
      bootdev-cli = prev.callPackage ./packages/bootdev.nix { };
    })
  ];

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    gdb
    curl
    gparted
    firefox
    git
    tealdeer
    alacritty
    btop
    zip
    unzip
    gnupg
    brightnessctl

    # Networking & troubleshooting
    inetutils
    netcat
    traceroute
    mtr

    # Development
    gcc
    gnumake
    pkg-config
    python3

    # Utilities & quality of life
    fzf
    ripgrep
    bat
    fd
    tmux
    tree

    # Shells & system tools
    zsh
    fish
    starship
    direnv
    ncdu
    lsof
    file
    man-pages

    # Development
    clang
    cmake
    ninja
    rustc
    cargo
    go
    lua
    jq
    shellcheck
    vale
    ghc 
    cabal-install 
    haskell-language-server
    hlint 
    ormolu 
    fourmolu 
    stylish-haskell 
    ghcid 
    python313Packages.dbus-python

    # Networking & security
    tcpdump
    nmap
    whois
    ipcalc
    bind
    openssh

    # File tools & misc utilities
    atool
    rsync
    rclone
    xxd
    dos2unix
    moreutils
    age

    # Nix helpers
    cabal2nix 

    rpi-imager
    adwaita-qt
    adwaita-icon-theme

    wineWowPackages.stable
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "FiraCode Nerd Font Mono";
      fontSize = "15";

      background = "${./home/wallpapers/camel.png}";
      loginBackground = true;
    })
  ];

  environment.variables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
    SYSTEMD_EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
  };

  #----=[ Fonts ]=----#
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      fira-code
      fira-code-symbols
      proggyfonts
      liberation_ttf
      adwaita-icon-theme
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" ];
	monospace = [ "Fira Code Nerd Font Mono" ];
      };
    };
  };

  programs.hyprland.enable = true;

  xdg.portal.enable = true;

  #----=[ Services ]=----#

  # Configure keymap in X11
  services.xserver.xkb.layout = "se";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.openssh.enable = true;
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  # Enable hardware acceleration
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Enable NVIDIA proprietary driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Power Management
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # ONLY Nvidia
  environment.variables = {
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
  };

  home-manager.backupFileExtension = "backup";

  system.stateVersion = "25.05";
}

