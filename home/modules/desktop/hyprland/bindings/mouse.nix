let
  mod = "SUPER_L";
in
{
  wayland.windowManager.hyprland.settings.bindm = [
    "${mod}, mouse:272, movewindow"
    "${mod}, mouse:273, resizewindow"
  ];
}
