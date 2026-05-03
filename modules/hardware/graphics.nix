{
  config,
  lib,
  ...
}:

let
  cfg = config.my.graphics;
in
{
  options.my.graphics = {
    mode = lib.mkOption {
      type = lib.types.enum [
        "intel"
        "nvidia"
        "offload"
      ];
      default = "intel";
    };

    nvidia = {
      intelBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
    };
  };

  config = lib.mkMerge [

    # Intel only
    (lib.mkIf (cfg.mode == "intel") {
      services.xserver.videoDrivers = [ "modesetting" ];
    })

    # NVIDIA only
    (lib.mkIf (cfg.mode == "nvidia") {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesetting.enable = true;
        open = false; # Proprietary drivers
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        powerManagement = {
          enable = false;
          finegrained = false;
        };

        prime = {
          intelBusId = cfg.nvidia.intelBusId;
          nvidiaBusId = cfg.nvidia.nvidiaBusId;
        };
      };

      boot.initrd.kernelModules = [
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
      ];
    })

    # PRIME OFFLOAD
    (lib.mkIf (cfg.mode == "offload") {

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesetting.enable = true;

        powerManagement = {
          enable = false;
          finegrained = false;
        };

        open = false; # Proprietary drivers
        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.stable;

        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          intelBusId = cfg.nvidia.intelBusId;
          nvidiaBusId = cfg.nvidia.nvidiaBusId;
        };
      };

      boot.initrd.kernelModules = [
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
      ];
    })
  ];
}
