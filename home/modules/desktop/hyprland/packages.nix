{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-themes-extra
    papirus-icon-theme
    adwaita-qt6
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    qt6Packages.qt6ct
    wireplumber
  ];
}
