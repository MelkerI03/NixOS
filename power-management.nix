{ pkgs, ... }:
{
  services = {
    thermald.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    auto-cpufreq = {
      enable = false;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };
    udev = {
      enable = true;
      extraRules = ''
        # Disable USB autosuspend for mouse
        ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c539", TEST=="power/control", ATTR{power/control}="on"
        # ACTION=="add", ATTR{idVendor}=="046d", ATTR{idProduct}=="c539", RUN="/bin/sh -c 'echo 0 >/sys/bus/usb/devices/3-1/power/control'"
      '';
    };
  };

  # systemd.services."disable-mouse-autosuspend" = {
  #   description = "Disable autosuspend for Logitech mouse reveiver";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.bash}/bin/bash -c 'echo on > /sys/bus/usb/devices/3-1/power/control'";
  #     After = [
  #       "systemd-udev-settle.service"
  #       "multi-user.target"
  #     ];
  #   };
  # };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

}
