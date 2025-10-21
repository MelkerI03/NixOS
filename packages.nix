{ pkgs, ... }:
{
  programs = {
    virt-manager.enable = true;
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
    usbutils
    audit

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
    hyprland

    # File tools & misc utilities
    rsyncy
    rclone
    xxd
    dos2unix
    moreutils
    age
  ];
}
