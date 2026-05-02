{ ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";

  services.xserver.xkb = {
    layout = "se";
    options = "caps:escape";
  };

  services.libinput = {
    mouse.accelProfile = "flat";
    touchpad.accelProfile = "flat";
  };

  security.pam.services.sddm.enableGnomeKeyring = true;
}
