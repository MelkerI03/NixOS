{ config, inputs, pkgs, ... }:
{
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim 
    ./hyprland/config.nix
  ];

  home.username = "viking";
  home.homeDirectory = "/home/viking";
  home.stateVersion = "25.05";

  #----=[ Packages ]=----#
  home.packages = with pkgs; [
    # Core
    kitty
    tmux
    hyprland

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

    # Hyprland Utils
    waybar
    swaylock
    rofi
    hyprpaper
  ];

  #----=[ NixVim ]=----#
  programs.nixvim = import ./nixvim/config.nix;

  #----=[ Zsh ]=----#
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -liah";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixosVM";
    };

    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "frontcube";
    };
  };

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
    shortcut = "b";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      catppuccin
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g mouse on
      bind - split-window -v
      bind | split-window -h

      # Enable default pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };

  #----=[ SSH ]=----#
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        IdentityFile = ~/.ssh/id_ed25519
        User git
        StrictHostKeyChecking accept-new
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
