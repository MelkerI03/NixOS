{ inputs, system, ... }:

{
  nix.package = inputs.determinate-nix.packages.${system}.default;
}
