{ determinate-nix, system, ... }:

{
  nix.package = determinate-nix.packages.${system}.default;
}
