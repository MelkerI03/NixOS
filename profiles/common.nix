{ sops-nix, ... }:

{
  imports = [
    sops-nix.nixosModules.sops
    ../modules/nix/determinate.nix
  ];
}
