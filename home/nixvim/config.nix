{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    imports = [
      ./lsp.nix
      ./keymaps.nix
      ./opts.nix
    ];

    colorschemes.monokai-pro.enable = true;

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

    clipboard.register = "unnamedplus";
  };
}
