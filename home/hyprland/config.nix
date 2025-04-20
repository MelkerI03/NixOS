{ pkgs, ... }:
let
  mod = "SUPER_L";
  term = "kitty";
in
{
  imports = [
    ./hyprpaper/config.nix
    ./swaylock/config.nix
    ./waybar/config.nix
  ];

  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
    swaynotificationcenter
    swaylock

    gnome-themes-extra
    papirus-icon-theme
    adwaita-qt6
    xdg-desktop-portal-gtk
    qt6ct

    playerctl
    wireplumber
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [ 
        "XCURSOR_SIZE, 24"
        "T_QPA_PLATFORMTHEME, qt6ct"
        "XCURSOR_THEME, Adwaita"
        "TK_THEME, Adwaita-dark"
      ];

       exec-once = [
         "${pkgs.hyprpaper}/bin/hyprpaper"
         "${pkgs.waybar}/bin/waybar"
         "${pkgs.dconf}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'"
         "${pkgs.dconf}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
       ];

      input = {
        kb_layout = "se";               # Keyboard Layout
        kb_options = "caps:escape";     # Rebind CapsLock to Escape
        
        touchpad = {
          natural_scroll = true;        # Normal Person Scroll
          scroll_factor = 0.15;         # Scroll in normal speed
        };
      };

      monitor = [
        "eDP-1, 1920x1200@60, 0x0, 1"
      ];

      bind = [
        "${mod}, RETURN, exec, ${term}"
        "${mod}, M, exit"

        "${mod}, P, exec, hyprpicker -a"
        "${mod}, SPACE, exec, rofi -show drun"

        "${mod}, Q, killactive"

        "${mod}, L, exec, swaylock"

        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        "${mod}, 4, workspace, 4"
        "${mod}, 5, workspace, 5"
        "${mod}, 6, workspace, 6"
        "${mod}, 7, workspace, 7"
        "${mod}, 8, workspace, 8"
        "${mod}, 9, workspace, 9"

        "SUPER_SHIFT, 1, moveToWorkspace, 1" 
        "SUPER_SHIFT, 2, moveToWorkspace, 2" 
        "SUPER_SHIFT, 3, moveToWorkspace, 3" 
        "SUPER_SHIFT, 4, moveToWorkspace, 4" 
        "SUPER_SHIFT, 5, moveToWorkspace, 5" 
        "SUPER_SHIFT, 6, moveToWorkspace, 6" 
        "SUPER_SHIFT, 7, moveToWorkspace, 7" 
        "SUPER_SHIFT, 8, moveToWorkspace, 8" 
        "SUPER_SHIFT, 9, moveToWorkspace, 9" 

        # Multimedia keybindings
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
      ];

      decoration = {
        rounding = 8;
      };

      general = {
        gaps_out = 8;
      };

      animations = {
        enabled = true;
        bezier = [
          "fastBezier, 0.1, 0.8, 0.2, 1.0"
        ];
        animation = [
          "windows, 1, 3, fastBezier"
          "windowsOut, 1, 2, fastBezier, popin 80%"
          "border, 1, 5, fastBezier"
          "fade, 1, 4, fastBezier"
          "workspaces, 1, 3, fastBezier"
        ];
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita"; # Use qt5ct/qt6ct for theme configuration
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };
}
