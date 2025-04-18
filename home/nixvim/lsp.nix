{ ... }:
{
  plugins.lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
      basedpyright.enable = true;
      hls = {
        enable = true;
        installGhc = true;
      };
    };
  };
}
