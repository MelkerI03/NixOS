{ pkgs, ... }:
{
  programs = {
    virt-manager.enable = true;
    ssh.startAgent = true;

    hyprland.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    gparted
    chromium
    firefox
    git
    zip
    unzip
    libz
    p7zip
    atool
    gnupg

    adwaita-qt
    adwaita-icon-theme

    # Networking & troubleshooting
    inetutils
    netcat
    traceroute
    mtr

    # Shells & system tools
    ncdu
    lsof
    file
    man-pages
    powertop
    powerstat
    lshw
    openssh

    # File tools & misc utilities
    rsyncy
    rclone
    xxd
    dos2unix
    moreutils
    age
  ];
}
