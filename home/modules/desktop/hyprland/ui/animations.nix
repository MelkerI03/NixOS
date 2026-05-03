{
  wayland.windowManager.hyprland.settings.animations = {
    enabled = true;
    bezier = [ "fastBezier, 0.1, 0.8, 0.2, 1.0" ];
    animation = [
      "windows, 1, 3, fastBezier"
      "windowsOut, 1, 2, fastBezier, popin 80%"
      "border, 1, 5, fastBezier"
      "fade, 1, 4, fastBezier"
      "workspaces, 1, 3, fastBezier"
    ];
  };
}
