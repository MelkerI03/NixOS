{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    zip
    unzip
    p7zip
    atool
    gnupg
    usbutils
    file
    man-pages
    openssh
    rsyncy
    rclone
    xxd
    dos2unix
    moreutils
    age
    sops
    ncdu
    lsof
    lshw
  ];
}
