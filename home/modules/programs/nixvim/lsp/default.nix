{
  plugins.lsp.enable = true;

  imports = [
    ./servers.nix
    ./formatting.nix
    ./ui.nix
  ];
}
