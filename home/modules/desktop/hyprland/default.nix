{ config, ... }:

{
  imports = [
    ./packages.nix

    ./core/env.nix
    ./core/exec.nix
    ./core/input.nix

    ./bindings/core.nix
    ./bindings/media.nix
    ./bindings/mouse.nix

    ./layout/monitors.nix
    ./layout/workspaces.nix
    ./layout/rules.nix

    ./ui/decoration.nix
    ./ui/animations.nix
    ./ui/general.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf
    '';
  };

  catppuccin.enable = true;
}
