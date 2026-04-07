{ pkgs, ... }:
{
  programs = {
    # virt-manager.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    gparted
    chromium
    librewolf
    git
    zip
    unzip
    libz
    p7zip
    atool
    gnupg
    usbutils
    audit
    polkit_gnome

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
    kitty

    # File tools & misc utilities
    xfce.thunar
    rsyncy
    rclone
    xxd
    dos2unix
    moreutils
    age
    sops
    wireguard-tools
    zap
    graphviz
    python313Packages.pygraphviz
    python313Packages.graphviz
    work-sans
    winboat

    vimgolf
    snicat

    fsuae-launcher
    (callPackage ./vulkan-hdr-layer.nix { pname = "vulkan-hdr-layer"; })
    vesktop
    proton-authenticator
  ];
}
