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

    "${mod}, 1, workspace, 1"
    "${mod}, 2, workspace, 2"
    "${mod}, 3, workspace, 3"
    "${mod}, 4, workspace, 4"
    "${mod}, 5, workspace, 5"
    "${mod}, 6, workspace, 6"
    "${mod}, 7, workspace, 7"
    "${mod}, 8, workspace, 8"
    "${mod}, 9, workspace, 9"

    "${mod}, H, movefocus, l"
    "${mod}, J, movefocus, d"
    "${mod}, K, movefocus, u"
    "${mod}, L, movefocus, r"

    "${mod} SHIFT, H, movewindow, l"
    "${mod} SHIFT, J, movewindow, d"
    "${mod} SHIFT, K, movewindow, u"
    "${mod} SHIFT, L, movewindow, r"

    "${mod}, TAB, workspace, r+1"
    "${mod} SHIFT, TAB, workspace, r-1"

    "${mod}, S, exec, ${ipc} controlCenter toggle"
    "${mod}, comma, exec, ${ipc} settings toggle"
  ];
}
