{ pkgs, ...}:
let
  # Fetch the onedark theme from Murzchnvok/rofi-collection
  rofi-onedark-theme = pkgs.stdenv.mkDerivation {
    name = "rofi-onedark-theme";
    src = pkgs.fetchFromGitHub {
      owner = "Murzchnvok";
      repo = "rofi-collection";
      rev = "f1f063f"; # Latest commit as of April 2025
      sha256 = "sha256-s1ENTByJuWlL1gYuWgcrNQ+2McLucDjGUwgXBYAwAW4";
    };
    installPhase = ''
      mkdir -p $out/share/rofi/themes
      cp onedark/onedark.rasi $out/share/rofi/themes/onedark.rasi
    '';
  };
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # Use Wayland version for Hyprland
    theme = "${rofi-onedark-theme}/share/rofi/themes/onedark.rasi";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
      font = "FiraCode Nerd Font Mono Medium 10";
      display-drun = " Apps";
      display-run = " Run";
      display-window = " Windows";
    };
  };

}
