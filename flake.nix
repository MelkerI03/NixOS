{
  description = "Configuration of vikings systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate-nix = {
      url = "github:DeterminateSystems/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      determinate-nix,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              home-manager
              nixos-hardware
              sops-nix
              determinate-nix
              system
              ;
          };

          modules = [
            ./hosts/laptop
          ];
        };

        work = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              home-manager
              nixos-hardware
              sops-nix
              determinate-nix
              system
              ;
          };

          modules = [
            ./hosts/work
          ];
        };
      };
    };
}
