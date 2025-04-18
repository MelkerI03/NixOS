{ inputs, pkgs, ... }:

{
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim 
    ./hyprland/config.nix
    ./nixvim/config.nix
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
    haskell.compiler.native-bignum.ghcHEAD

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

    xfce.thunar

    # Other
    steam
  ];

  # Enable Home-Manager
  programs.home-manager.enable = true;
}
