{ pkgs, ... }:
let  
  mod = "SUPER";
  term = "foot";
in
{
  wayland.windowManager.hyprland = {
    enable = true;


    settings = {
      input = {
        kb_layout = "se";
        kb_options = "caps:escape";
      };

      bind = [
        "${mod}, RETURN, exec, ${term}"
        "${mod}, M, exit"
      ];

      touchpad = {
        # natural_scroll = false;
      };

      decoration = {
      };
    };
  };
}
