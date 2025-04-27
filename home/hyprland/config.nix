{ pkgs, config, ... }:
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
    # swaynotificationcenter
    swaylock

    gnome-themes-extra
    papirus-icon-theme
    adwaita-qt6
    xdg-desktop-portal-gtk
    qt6ct

    playerctl
    wireplumber
    dunst
    libnotify
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
        ", XF86AudioPlay, exec, ${config.xdg.configHome}/scripts/media-play-pause.sh"
        ", XF86AudioNext, exec, playerctl next && notify-send -i media-skip-forward 'Media' 'Next Track'"
        ", XF86AudioPrev, exec, playerctl previous && notify-send -i media-skip-backward 'Media' 'Previous Track'"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && ${config.xdg.configHome}/scripts/volume-notification.sh"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${config.xdg.configHome}/scripts/volume-notification.sh"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ${config.xdg.configHome}/scripts/volume-notification.sh"

        # ", XF86AudioPlay, exec, ${config.xdg.configHome}/scripts/media-play-pause.sh"
        # ", XF86AudioNext, exec, playerctl next && notify-send -i media-skip-forward 'Media' 'Next Track'"
        # ", XF86AudioPrev, exec, playerctl previous && notify-send -i media-skip-backward 'Media' 'Previous Track'"
        # ", XF86AudioRaiseVolume, exec, ${config.xdg.configHome}/scripts/volume-up.sh"
        # ", XF86AudioLowerVolume, exec, ${config.xdg.configHome}/scripts/volume-down.sh"
        # ", XF86AudioMute, exec, ${config.xdg.configHome}/scripts/volume-mute.sh"
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

  xdg.configFile."scripts/volume-notification.sh" = {
    text = ''
      #!/bin/sh
      VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}')

      MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]' && echo 1 || echo 0)

      ICON_PATH="${pkgs.papirus-icon-theme}/share/icons/Papirus/24x24/panel"

      ICON="$ICON_PATH/audio-volume-high.svg"
      [ "$VOLUME" -lt 60 ] && ICON="$ICON_PATH/audio-volume-medium.svg"
      [ "$VOLUME" -lt 30 ] && ICON="$ICON_PATH/audio-volume-low.svg"
      [ "$VOLUME" -eq 0 ] || [ "$MUTED" -eq 1 ] && ICON="$ICON_PATH/audio-volume-muted.svg"
  
      dunstify -a "volume" -u low -i "$ICON" -h int:value:"$VOLUME" "Volume" ""
    '';
    executable = true;
  };

  # Notification scripts
  xdg.configFile."scripts/media-play-pause.sh".text = ''
    #!/bin/sh
    playerctl play-pause
    STATUS=$(playerctl status 2>/dev/null)
    if [ "$STATUS" = "Playing" ]; then
      notify-send -i media-playback-start "Media" "Playing"
    elif [ "$STATUS" = "Paused" ]; then
      notify-send -i media-playback-pause "Media" "Paused"
    else
      notify-send -i dialog-error "Media" "No player running"
    fi
  '';

  xdg.configFile."scripts/volume-up.sh" = {
    text = ''
      #!/bin/sh
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
      notify-send -i audio-volume-high "Volume" "$VOLUME%"
    '';
    executable = true;
  };

  xdg.configFile."scripts/volume-down.sh" = {
    text = ''
      #!/bin/sh
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
      notify-send -i audio-volume-low "Volume" "$VOLUME%"
    '';
    executable = true;
  };

  xdg.configFile."scripts/volume-mute.sh" = {
    text = ''
      #!/bin/sh
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)
      if [ "$MUTE" = "MUTED" ]; then
        notify-send -i audio-volume-muted "Volume" "Muted"
      else
        VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
        notify-send -i audio-volume-medium "Volume" "Unmuted ($VOLUME%)"
      fi
    '';
    executable = true;
  };

  # services.dunst = {
  #   enable = true;
  #   settings = {
  #     global = {
  #       origin = "bottom-center";
  #       offset = "(0, 60)";
  #       geometry = "300x60";
  #       icon_position = "left";
  #       padding = 8;
  #       frame_width = 0;
  #       markup = "no";
  #       font = "Monospace 10";
  #       progress_bar = true;
  #       progress_bar_height = 6;
  #       progress_bar_frame_width = 0;
  #       format = "<icon>      ";
  #     };
  #     volume = {
  #       summary = "Volume";
  #       format = "&lt;icon&gt; &lt;progress&gt;";
  #       history_ignore = true;
  #     };
  #   };
  # };

  xdg.configFile."dunst/dunstrc".text = ''
      [global]
      ### Display
      monitor = 0
      follow = none
      width = 300
      height = (50, 50)
      origin = bottom-center
      offset = (0, 50)
      scale = 0
      notification_limit = 0

      ### Geometry
      progress_bar = true
      progress_bar_height = 10
      progress_bar_frame_width = 1
      progress_bar_min_width = 150
      progress_bar_max_width = 150

      ### Text
      font = Monospace 10
      line_height = 0
      format = "%p"  # No text in notification
      alignment = left
      vertical_alignment = center
      show_age_threshold = 60
      word_wrap = no
      ignore_newline = no
      stack_duplicates = false
      hide_duplicate_count = false
      show_indicators = no

      ### Icons
      icon_position = left
      max_icon_size = 32
      icon_path = ${pkgs.papirus-icon-theme}/share/icons/Papirus/24x24/panel/

      ### Appearance
      transparency = 10
      separator_height = 2
      padding = 8
      horizontal_padding = 8
      text_icon_padding = 8
      frame_width = 2
      frame_color = "#89B4FA"
      separator_color = frame
      corner_radius = 10
      background = "#1E1E2E"
      foreground = "#CDD6F4"
      highlight = "#89B4FA"

      ### Behavior
      timeout = 3

      [volume]
      summary = "Volume"
      appname = "volume"
      format = "%p"  # Ensure no text
      set_stack_tag = "volume"
      urgency = low
      timeout = 2
  '';
  
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
    platformTheme.name = "adwaita";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };
}
