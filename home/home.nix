{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  home.username = "viking";
  home.homeDirectory = "/home/viking";
  home.stateVersion = "25.05";

  #----=[ Packages ]=----#
  home.packages = with pkgs; [
    # Core
    kitty
    tmux

    # QoL Tools
    eza
    bat
    fzf
    ripgrep
    btop
    zip
    unzip

    # Hyprland Utils
    waybar
    swaylock
    rofi

    # Other
    glfw-wayland
    foot
  ];

  gtk.enable = true;
  qt.enable = true;

  #----=[ NixVim ]=----#
  programs.nixvim = import ./nixvim/config.nix;

  #----=[ Kitty ]=----#
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      wayland_titlebar_color = "background";
    };
    environment = {
      KITTY_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  #----=[ Tmux ]=----#
  programs.tmux = {
    enable = true;
    shortcut = "a";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      catppuccin
    ];
    extraConfig = ''
      set -g mouse on
      bind - split-window -v
      bind | split-window -h
    '';
  };

  #----=[ Foot Terminal ]=----#
  programs.foot = {
    enable = true;
    settings = {
      scrollback.lines = 100000;
      main.font = "Fira Code:size=9";
    };
  };

  # Enable Home-Manager
  programs.home-manager.enable = true;
}
