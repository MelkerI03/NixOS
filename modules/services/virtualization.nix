{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dnsmasq
    phodav
    swtpm
  ];

  security.polkit.enable = true;
  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = false;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    # spiceUSBRedirection.enable = true;
  };

  users.users.viking.extraGroups = [
    "vboxusers"
    "docker"
  ];
}
