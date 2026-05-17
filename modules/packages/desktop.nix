{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    kitty
    thunar
    vesktop
    proton-authenticator
    gparted
    polkit_gnome
    adwaita-qt
    adwaita-icon-theme
  ];
}
