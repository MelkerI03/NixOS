# Edit this configuration file to define what should be installed on your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

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

  networking.hostName = "nixosVM";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  # i18n.defaultLocale = "sv_SE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account.
  users.groups.viking = {};
  users.users.viking = {
    isNormalUser = true;
    group = "viking";
    extraGroups = [ "wheel" "input" "vboxsf" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;


  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    firefox
    git
    tealdeer
    file
    fish
    alacritty
    # wayland
    # wlroots
    # xorg.libX11
    # xorg.libXcursor
    # xorg.libXrandr
    # xorg.libXi
  ];

  environment.variables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
    SYSTEMD_EDITOR = "nvim";
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
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" ];
	monospace = [ "Fira Code Mono" ];
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

  services.openssh.enable = true;
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };


  services.xserver.videoDrivers = [ "virtio" ];
  hardware.graphics.enable = true;

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  # };

  virtualisation.virtualbox.guest.enable = true;
  home-manager.backupFileExtension = "backup";

  system.stateVersion = "25.05";

}

