{ pkgs, ... }:
{
  imports = [
    ./lsp.nix
    ./keymaps.nix
    ./vars.nix
  ];

  enable = true;

  # colorschemes.catppuccin.enable = true;
  colorschemes.monokai-pro.enable = true;
  globals.mapleader = " ";

  plugins = {
    web-devicons.enable = true;       # Nerd Font additions
    nvim-autopairs.enable = true;     # Autopairing
    tmux-navigator.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    cmp.enable = true;
    oil.enable = true;
    lualine.enable = true;
    which-key.enable = true;

    wtf.enable = true;                # AI-driven dignostics debugging
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-sleuth
    comment-nvim
    nvim-autopairs
  ];
}
