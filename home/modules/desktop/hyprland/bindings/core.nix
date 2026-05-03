let
  mod = "SUPER_L";
  term = "kitty";
  ipc = "noctalia-shell ipc call";
in
{
  wayland.windowManager.hyprland.settings.bind = [
    "${mod}, RETURN, exec, ${term}"
    "${mod}, M, exit"

    "${mod}, F, fullscreen"
    "${mod}, SPACE, togglefloating"
    "SUPER, ${mod}, exec, ${ipc} launcher toggle"
    "${mod}, E, exec, thunar"
    "${mod}, P, exec, ${ipc} lockScreen lock"

    "${mod}, Q, killactive"

    "${mod}, TAB, workspace, r+1"
    "${mod} SHIFT, TAB, workspace, r-1"

    "${mod}, S, exec, ${ipc} controlCenter toggle"
    "${mod}, comma, exec, ${ipc} settings toggle"
  ];
}
