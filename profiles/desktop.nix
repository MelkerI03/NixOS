{ home-manager, ... }:

{
  imports = [
    ../modules/system/sddm.nix

    # home-manager setup grouped here
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
}
