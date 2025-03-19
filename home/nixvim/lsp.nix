{ lib, ... }:
{
  plugins.lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
      basedpyright.enable = true;
    };
  };
}
