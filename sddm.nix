{ inputs, pkgs, ... }:

let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "rei"; # select the config of your choice
  };
in
{
  environment.systemPackages = with pkgs; [

    sddm-theme
    sddm-theme.test
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm; # use qt6 version of sddm
    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs;
  };
}
