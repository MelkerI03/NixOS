{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pulseaudioFull
    libreoffice
    gimp
    pinta
    vlc
    cheese
    firefox # Here for debugging purposes
    zoom-us
    polkit_gnome
    tailscale
  ];
}
