{ ... }:

{
  programs.nixvim = {
    enable = true;

    imports = [
      ./core/options.nix
      ./core/keymaps.nix
      ./core/ui.nix

      ./plugins/editor.nix
      ./plugins/navigation.nix
      ./plugins/visuals.nix

      ./completion

      ./lsp

      ./languages/latex.nix

      ./ai/avante.nix
    ];
  };
}
