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
      oil.enable = true;
      lualine.enable = true;
      which-key.enable = true;
  
      wtf.enable = true;                # AI-driven dignostics debugging

      cmp = {
        enable = true;
        autoEnableSources = true;
      };

      cmp-nvim-lsp.enable = true;

      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      luasnip.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-sleuth
      comment-nvim
      nvim-autopairs
    ];

    clipboard.register = "unnamedplus";
  };
}
