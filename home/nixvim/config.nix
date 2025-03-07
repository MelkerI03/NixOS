{ pkgs, ... }:
{
  # colorscheme = "catppuccin";
  enable = true;

  plugins = {
    web-devicons.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        basedpyright.enable = true;
      };
    };
    cmp.enable = true;
    oil.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-sleuth
    comment-nvim
  ];

  extraConfigVim = ''
    set number relativenumber
    set tabstop=2
    set shiftwidth=2
  '';
}
