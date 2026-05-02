{ pkgs, ... }:
{
  home.packages = with pkgs; [
    eza
    fzf
    tree
    ripgrep
    btop
    tealdeer
    nemo
    fd
    pix
    wev
    btop
    blueman
    pywal
    bc
    eva
    fastfetch
    pipes-rs
    warpinator
    jellyfin-desktop
  ];
}
