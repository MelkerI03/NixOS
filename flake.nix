{
  description = "Configuration of vikings systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    determinate-nix.url = "github:DeterminateSystems/nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      determinate-nix,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            nixos-hardware.nixosModules.dell-xps-15-9500-nvidia

            (
              { pkgs, ... }:
              {
                nix.package = determinate-nix.packages.${pkgs.system}.default;
              }
            )
          ];
        };
      };
    };
}
