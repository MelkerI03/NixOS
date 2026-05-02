{ inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    ../modules/nix/determinate.nix
  ];
}
