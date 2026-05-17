{
  inputs,
  config,
  pkgs,
  ...
}:
let
  configDir = config.xdg.configHome;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    grim # Screenshots
    slurp # Region selector
    wl-clipboard # Clipboard manager
    tesseract # OCR
    imagemagick # Image processing
    zbar # QR/Barcodes
    curl # Network upload
    ffmpeg # Video processing
    jq # Network parsing
    wl-screenrec # Screen recording
  ];
  # programs.tesseract.languages = [
  #   "eng"
  #   "swe"
  # ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        screen-toolkit = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };

    pluginSettings = {
      screen-toolkit = {
        # minimumThreshold = 25;
        # hideBackground = true;
      };
    };
    settings = {
      general = {
        avatarImage = "${configDir}/nixos/home/images/tintin.jpg";

        animationSpeed = 2;
        animationDisabled = true;

        showSessionButtonsOnLockScreen = false;
        showHibernateOnLockScreen = true;
      };
      ui = {
        fontDefault = "FiraCode Nerd Font";
        fontFixed = "FiraCode Nerd Font Mono";

        tooltipsEnabled = false;
      };
      bar = {
        density = "comfortable";
        capsuleOpacity = 0.7;
        frameRadius = 10;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Volume";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
            {
              id = "plugin:screen-toolkit";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              id = "PowerProfile";
            }
            {
              formatHorizontal = "HH:mm:ss";
              formatVertical = "HH mm:ss";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };

      wallpaper = {
        enabled = true;
        directory = "${configDir}/nixos/home/images/wallpapers";

        transitionType = [
          "honeycomb"
        ];

        skipStartupTransition = true;
      };

      location = {
        name = "Enköping, Sweden";

        showWeekNumberInCalendar = false;
        firstDayOfWeek = 0;
        monthBeforeDay = false;
      };

      appLauncher = {
        terminalCommand = "kitty -e";
        showCategories = false;

        enableWindowsSearch = false;
        enableSessionSearch = true;
      };

      dock = {
        enabled = false;
      };

      sessionMenu = {
        enableCountdown = false;

        powerOptions = [
          {
            action = "lock";
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            enabled = true;
            keybind = "2";
          }
          {
            action = "hibernate";
            enabled = true;
            keybind = "3";
          }
          {
            action = "reboot";
            enabled = true;
            keybind = "4";
          }
          {
            action = "logout";
            enabled = true;
            keybind = "5";
          }
          {
            action = "shutdown";
            enabled = true;
            keybind = "6";
          }
        ];

      };

      osd = {
        enabled = true;
        location = "bottom_center";
        autoHideMs = 1500;
      };

      colorSchemes.predefinedScheme = "Catppuccin";

      nightlight = {
        enabled = true;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "05:30";
        manualSunset = "18:30";
      };
    };
  };
}
