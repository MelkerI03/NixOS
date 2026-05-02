{ ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu-next";
      profile = "gpu-hq";
      hwdec = "nvdec";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      target-colorspace-hint = "auto";
    };
  };
}
