{ inputs, pkgs, ... }:

{
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim 
    ./hyprland/config.nix
    ./nixvim/config.nix
    ./direnv/config.nix
    ./kitty/config.nix
    ./tmux/config.nix
    ./rofi/config.nix
    ./zsh/config.nix
    ./cli/config.nix
    ./ssh/config.nix
  ];

  home.username = "viking";
  home.homeDirectory = "/home/viking";
  home.stateVersion = "25.05";

  #----=[ Packages ]=----#
  home.packages = with pkgs; [
    # Languages
    python314
    zig_0_13

    # QoL Tools
    eza
    bat
    fzf
    ripgrep
    btop
    zip
    unzip
    thefuck
    fd
    feh
    wev

    xfce.thunar

    # Other
    steam
    lutris
    spotify
  ];

  # Enable Home-Manager
  programs.home-manager.enable = true;
}
