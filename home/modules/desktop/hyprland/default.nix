{ config, pkgs, ... }:
let
  mod = "SUPER_L";
  term = "kitty";

  ipc = "noctalia-shell ipc call";
in
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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE, 24"
        "T_QPA_PLATFORMTHEME, qt6ct"
        "XCURSOR_THEME, Adwaita"
        "TK_THEME, Adwaita-dark"
        "GTK_THEME, Adwaita:dark"
        "AQ_DRM_DEVICES, /dev/dri/card1:/dev/dri/card0" # Disable nvidia for hyprland
      ];

      exec-once = [
        "noctalia-shell"

        # Default workspace programs
        "[workspace 1 silent] kitty"
        "[workspace 2 silent] firefox"
        "[workspace 3 silent] spotify"
      ];

      input = {
        kb_layout = "se"; # Keyboard Layout
        kb_options = "caps:escape"; # Rebind CapsLock to Escape

        touchpad = {
          natural_scroll = true; # Normal Person Scroll
          scroll_factor = 0.15; # Scroll in normal speed
        };
      };

      monitor = [
        "eDP-1, 1920x1200@60, 0x0, 1.0, bitdepth, 10"
        "DP-1, 3840x2160@100, 0x0, 1.5, bitdepth, 10"

        # "DP-7, 2560x1440@60, auto, 1"
        "DP-7, 1920x1080@60, auto, 1"
        "DP-8, 1920x1080@60, auto, 1"
      ];

      bind = [
        "${mod}, RETURN, exec, ${term}"
        "${mod}, M, exit"

        "${mod}, F, fullscreen"
        "${mod}, SPACE, togglefloating"
        "SUPER, ${mod}, exec, ${ipc} launcher toggle"
        "${mod}, E, exec, thunar"
        "${mod}, P, exec, ${ipc} lockScreen lock"

        "${mod}, Q, killactive"

        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        "${mod}, 4, workspace, 4"
        "${mod}, 5, workspace, 5"
        "${mod}, 6, workspace, 6"
        "${mod}, 7, workspace, 7"
        "${mod}, 8, workspace, 8"
        "${mod}, 9, workspace, 9"

        "${mod}, H, movefocus, l"
        "${mod}, J, movefocus, d"
        "${mod}, K, movefocus, u"
        "${mod}, L, movefocus, r"

        "${mod} SHIFT, H, movewindow, l"
        "${mod} SHIFT, J, movewindow, d"
        "${mod} SHIFT, K, movewindow, u"
        "${mod} SHIFT, L, movewindow, r"

        "${mod}, TAB, workspace, r+1"
        "${mod} SHIFT, TAB, workspace, r-1"

        "${mod} SHIFT, 1, moveToWorkspace, 1"
        "${mod} SHIFT, 2, moveToWorkspace, 2"
        "${mod} SHIFT, 3, moveToWorkspace, 3"
        "${mod} SHIFT, 4, moveToWorkspace, 4"
        "${mod} SHIFT, 5, moveToWorkspace, 5"
        "${mod} SHIFT, 6, moveToWorkspace, 6"
        "${mod} SHIFT, 7, moveToWorkspace, 7"
        "${mod} SHIFT, 8, moveToWorkspace, 8"
        "${mod} SHIFT, 9, moveToWorkspace, 9"

        "${mod}, S, exec, ${ipc} controlCenter toggle"
        "${mod}, comma, exec, ${ipc} settings toggle"

        # Multimedia keybindings
        ", XF86AudioMicMute, exec, ${ipc} volume muteInput"
        ", XF86AudioMute, exec, ${ipc} volume muteOutput"

        ", XF86AudioPlay, exec, ${ipc} media playPause"
        ", XF86AudioNext, exec, ${ipc} media next"
        ", XF86AudioPrev, exec, ${ipc} media previous"

        ", XF86WLAN, exec, ${ipc} airplaneMode toggle"
        ", XKB_KEY_XF86NotificationCenter, exec, ${ipc} notifications toggleHistory"
      ];

      bindel = [
        ", XF86MonBrightnessUp, exec, ${ipc} brightness increase"
        ", XF86MonBrightnessDown, exec, ${ipc} brightness decrease"
        ", XF86AudioRaiseVolume, exec, ${ipc} volume increase"
        ", XF86AudioLowerVolume, exec, ${ipc} volume decrease"
      ];

      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];

      decoration = {
        rounding = 10;
        rounding_power = 2;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      workspace = [
        "1,, persistent:true"
        "2,, persistent:true"
        "3,, persistent:true"
        "4,, persistent:true"
        "5,, persistent:true"
      ];

      windowrule = [
        # Blurring on terminal
        {
          name = "terminal blur";
          "match:class" = "^${term}.*$";
          no_blur = false;
          opacity = "0.95 0.95";
        }
      ];

      layerrule = [
        {
          name = "noctalia-shell";
          "match:namespace" = "noctalia-background-.*$";
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
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

    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf
    '';
  };

  catppuccin.enable = true;
}
