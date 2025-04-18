{ ... }:

{
  programs.waybar = {
    enable = true;
    # package = pkgs.waybar; # Ensure Waybar is installed

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = [ "custom/notification" "clock" "tray"];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "group/expand" "bluetooth" "network" "battery" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "○";
            empty = "○";
          };
          sort-by-number = true;
          persistent-workspaces = {
            "*" = 5; # Show 5 workspaces by default
          };
        };

        "custom/notification" = {
          tooltip = false;
          format = "";
          on-click = "swaync-client -t -sw";
          escape = true;
        };

        clock = {
          format = "{:%H:%M:%S} ";
          interval = 1;  
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
              format = {
                  today = "<span color='#fAfBfC'><b>{}</b></span>";
              };
          };
          actions = {
            on-click-right = "shift_down";
            on-click = "shift_up";
          };
        };

        network = {
            format-wifi = "";
            format-ethernet = "";
            format-disconnected =  "";
            tooltip-format-disconnected = "Error";
            tooltip-format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format-ethernet = "{ifname} 🖧 ";
            on-click = "kitty sudo nmtui";
        };
        
        bluetooth = {
          format-on =  "󰂯";
          format-off =  "BT-off";
          format-disabled =  "󰂲";
          format-connected-battery =  "{device_battery_percentage}% 󰂯";
          format-alt =  "{device_alias} 󰂯";
          tooltip-format =  "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected =  "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected =  "{device_alias}\n{device_address}";
          tooltip-format-enumerate-connected-battery =  "{device_alias}\n{device_address}\n{device_battery_percentage}%";
          on-click-right =  "blueman-manager";
        };

        battery = {
          interval = 30;
          states = {
              good =  95;
              warning =  30;
              critical =  5;
          };
          format =  "{capacity}% {icon}";
          format-charging =  "{capacity}% 󰂄";
          format-plugged =  "{capacity}% 󰂄 ";
          format-alt =  "{time} {icon}";
          format-icons = [
              "󰁻"
          "󰁼"
          "󰁾"
          "󰂀"
          "󰂂"
          "󰁹"
          ];
        };

        "custom/expand" = {
          format = "";
          tooltip = false;
        };

        "custom/endpoint" = {
            format = "|";
            tooltip = false;
        };
      };
    };

    style = ''
      /* @import url('../../.cache/wal/colors-waybar.css'); */

      * {
        font-size:15px;
        font-family: "FiraCode Nerd Font Mono";
      }

      window#waybar{
        all:unset;
      }

      .modules-left {
        padding:7px;
        margin:10 0 5 10;
        border-radius:10px;
        background: alpha(@background,.6);
        box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }

      .modules-center {
        padding:7px;
        margin:10 0 5 0;
        border-radius:10px;
        background: alpha(@background,.6);
        box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }

      .modules-right {
        padding:7px;
        margin: 10 10 5 0;
        border-radius:10px;
        background: alpha(@background,.6);
        box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
      }

      tooltip {
        background:@background;
        color: @color7;
      }

      #clock:hover, #custom-pacman:hover, #custom-notification:hover,#bluetooth:hover,#network:hover,#battery:hover, #cpu:hover,#memory:hover,#temperature:hover{
        transition: all .3s ease;
        color:@color9;
      }

      #custom-notification {
        padding: 0px 5px;
        transition: all .3s ease;
        color:@color7;
      }

      #clock{
        padding: 0px 5px;
        color:@color7;
        transition: all .3s ease;
      }

      #custom-pacman{
        padding: 0px 5px;
        transition: all .3s ease;
        color:@color7;
      }

      #workspaces {
        padding: 0px 5px;
      }

      #workspaces button {
        all:unset;
        padding: 0px 5px;
        color: alpha(@color9,.4);
        transition: all .2s ease;
      }

      #workspaces button:hover {
        color:rgba(0,0,0,0);
        border: none;
        text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
        transition: all 1s ease;
      }

      #workspaces button.active {
        color: @color9;
        border: none;
        text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }

      #workspaces button.empty {
        color: rgba(0,0,0,0);
        border: none;
        text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
      }

      #workspaces button.empty:hover {
        color: rgba(0,0,0,0);
        border: none;
        text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
        transition: all 1s ease;
      }

      #workspaces button.empty.active {
        color: @color9;
        border: none;
        text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }

      #bluetooth{
        padding: 0px 5px;
        transition: all .3s ease;
        color:@color7;
      }

      #network{
        padding: 0px 5px;
        transition: all .3s ease;
        color:@color7;
      }

      #battery{
        padding: 0px 5px;
        transition: all .3s ease;
        color:@color7;
      }

      #battery.charging {
        color: #26A65B;
      }

      #battery.warning:not(.charging) {
        color: #ffbe61;
      }
      
      #battery.critical:not(.charging) {
        color: #f53c3c;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #group-expand{
        padding: 0px 5px;
        transition: all .3s ease; 
      }

      #custom-expand{
        padding: 0px 5px;
        color:alpha(@foreground,.2);
        text-shadow: 0px 0px 2px rgba(0, 0, 0, .7);
        transition: all .3s ease; 
      }

      #custom-expand:hover{
        color:rgba(255,255,255,.2);
        text-shadow: 0px 0px 2px rgba(255, 255, 255, .5);
      }

      #custom-colorpicker{
        padding: 0px 5px;
      }

      #cpu,#memory,#temperature{
        padding: 0px 5px;
        transition: all .3s ease; 
        color:@color7;
      }

      #custom-endpoint{
        color:transparent;
        text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);
      }

      #tray{
        padding: 0px 5px;
        transition: all .3s ease; 
      }

      #tray menu * {
        padding: 0px 5px;
        transition: all .3s ease; 
      }

      #tray menu separator {
        padding: 0px 5px;
        transition: all .3s ease; 
      }
    '';
  };
}
