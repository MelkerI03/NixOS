{ inputs, ... }:

{
  imports = [
    ../modules/core/home-manager.nix

    ../modules/cli/cli.nix
    ../modules/cli/shell/zsh.nix
    ../modules/cli/shell/direnv.nix
    ../modules/cli/tools/git.nix
    ../modules/cli/tools/tmux.nix
    ../modules/cli/tools/ssh.nix
    ../modules/cli/tools/nh.nix
    ../modules/cli/tools/nix-index.nix

    ../modules/desktop/hyprland
    ../modules/desktop/apps/kitty.nix
    ../modules/desktop/apps/librewolf.nix
    ../modules/desktop/apps/zathura.nix
    ../modules/desktop/apps/noctalia.nix
    ../modules/desktop/fonts.nix

    ../modules/programs/nixvim
    ../modules/programs/mpv.nix

    ../modules/services/udiskie.nix

    ../modules/system/xdg/user-dirs.nix
    ../modules/system/xdg/mime.nix

    ../modules/packages/development.nix
    ../modules/packages/productivity.nix
    ../modules/packages/misc.nix
    ../modules/packages/QoL.nix

    ../users/viking.nix

    # external modules
    inputs.nixvim.homeModules.nixvim
    inputs.nix-index-database.homeModules.default
    inputs.nixploit.homeModules.nixploit
    inputs.catppuccin.homeModules.catppuccin
  ];
}
