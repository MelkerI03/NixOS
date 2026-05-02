{ pkgs, ... }:

{
  users = {
    groups = {
      viking = { };
      libvirtd.members = [ "viking" ];
      kvm.members = [ "viking" ];
    };

    users.viking = {
      isNormalUser = true;
      home = "/home/viking";
      createHome = true;

      hashedPassword = "$y$j9T$.t.wu6O5RZRooESu9KrBY.$wXp06dcetaWNNnul.7P5poo/G77v65bYU5habrmt0u.";

      group = "viking";
      extraGroups = [
        "wheel"
        "input"
        "network"
      ];
      shell = pkgs.zsh;
    };

    extraGroups.vboxusers.members = [ "viking" ];
  };
}
