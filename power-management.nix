{ ... }:
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
          governor = "performance";
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

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Laptop lid switch handling
  services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";

  systemd.sleep.extraConfig = ''
    AllowSuspend = yes
    AllowHibernation = yes
    AllowHybridSleep = no
    AllowSuspendThenHibernate = yes

    HibernateDelaySec=1m
  '';
}
