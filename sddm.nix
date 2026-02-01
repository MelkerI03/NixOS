{ pkgs, silentSDDM, ... }:

let
  sddm-theme = silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
  };
in
{
  environment.systemPackages = [
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

  qt.enable = true;
}
