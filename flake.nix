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
    # ragenix.url = "github:yaxitech/ragenix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      determinate-nix,
      # ragenix,
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
            # ragenix.nixosModules
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            nixos-hardware.nixosModules.lenovo-thinkpad-p1

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
