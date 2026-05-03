let
  term = "kitty";
in
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      {
        name = "terminal blur";
        "match:class" = "^${term}.*$";
        no_blur = false;
        opacity = "0.95 0.95";
      }
    ];

    layerrule = [
      {
        name = "noctalia-shell";
        "match:namespace" = "noctalia-background-.*$";
        ignore_alpha = 0.5;
        blur = true;
        blur_popups = true;
      }
    ];
  };
}
