{ pkgs, ... }:

{
  boot = {
    loader = {
      grub.enable = false;

      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    kernelParams = [ "usbcore.autosuspend=300" ];
    kernelModules = [
      "kvm"
      "kvm_intel"
      "uvcvideo"
    ];

    resumeDevice = "/dev/disk/by-uuid/98e5f53b-7c04-430b-bd9b-baa5a88e2d65";
  };

  systemd.services."unload-thinkpad-acpi" = {
    description = "Unload thinkpad_acpi before suspend";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kmod}/bin/modprobe -r thinkpad_acpi";
      ExecStop = "${pkgs.kmod}/bin/modprobe thinkpad_acpi";
    };
  };
}
