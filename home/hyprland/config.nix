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

          "${mod}, 1, workspace, 1"
          "${mod}, 2, workspace, 2"
          "${mod}, 3, workspace, 3"
          "${mod}, 4, workspace, 4"
          "${mod}, 5, workspace, 5"
          "${mod}, 6, workspace, 6"
          "${mod}, 7, workspace, 7"
          "${mod}, 8, workspace, 8"
          "${mod}, 9, workspace, 9"
      ];
    };
  };
}
