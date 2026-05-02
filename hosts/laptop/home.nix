{ config, ... }:
let
  flakeDir = "${config.xdg.configHome}/nixos/";
in
{
  imports = [
    ../../home/profiles/desktop.nix
  ];

  programs.zsh.shellAliases = {
    nixos = "nh os switch ${flakeDir}#laptop";
    test = "nh os test ${flakeDir}#laptop";
  };
}
