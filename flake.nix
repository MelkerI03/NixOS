{
  description = "Configuration of vikings systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    oldpkgs.url = "github:NixOS/nixpkgs/7d0ed7f2e5aea07ab22ccb338d27fbe347ed2f11"; # For kibana

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    determinate-nix.url = "github:DeterminateSystems/nix";
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      nixpkgs,
      oldpkgs,
      home-manager,
      nixos-hardware,
      determinate-nix,
      silentSDDM,
      sops-nix,
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

            (
              { pkgs, ... }:
              let
                legacy = import oldpkgs {
                  inherit system;
                  config.allowUnfree = true;
                };
              in
              {
                _module.args.legacy = legacy;

                nix.package = determinate-nix.packages.${pkgs.stdenv.hostPlatform.system}.default;
              }
            )

            { _module.args.silentSDDM = silentSDDM; }
            ./sddm.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            nixos-hardware.nixosModules.lenovo-thinkpad-p1
            sops-nix.nixosModules.sops

            (
              { pkgs, ... }:
              {
                nix.package = determinate-nix.packages.${pkgs.stdenv.hostPlatform.system}.default;
              }
            )
          ];
        };
      };
    };
}
