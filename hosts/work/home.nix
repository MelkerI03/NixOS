{ config, ... }:
let
  flakeDir = "${config.xdg.configHome}/nixos/";
in
{
  imports = [
    ../../home/profiles/work.nix
  ];

  programs.zsh.shellAliases = {
    nixos = "nh os switch ${flakeDir}#work";
    test = "nh os test ${flakeDir}#work";
  };
}
