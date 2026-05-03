let
  term = "kitty";
in
{
  wayland.windowManager.hyprland.settings.exec-once = [
    "noctalia-shell"

    "[workspace 1 silent] ${term}"
    "[workspace 2 silent] librewolf"
    "[workspace 3 silent] spotify"
  ];
}
