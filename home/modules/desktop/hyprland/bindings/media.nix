let
  ipc = "noctalia-shell ipc call";
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      ", XF86AudioMicMute, exec, ${ipc} volume muteInput"
      ", XF86AudioMute, exec, ${ipc} volume muteOutput"

      ", XF86AudioPlay, exec, ${ipc} media playPause"
      ", XF86AudioNext, exec, ${ipc} media next"
      ", XF86AudioPrev, exec, ${ipc} media previous"

      ", XF86WLAN, exec, ${ipc} airplaneMode toggle"
    ];

    bindel = [
      ", XF86MonBrightnessUp, exec, ${ipc} brightness increase"
      ", XF86MonBrightnessDown, exec, ${ipc} brightness decrease"
      ", XF86AudioRaiseVolume, exec, ${ipc} volume increase"
      ", XF86AudioLowerVolume, exec, ${ipc} volume decrease"
    ];
  };
}
