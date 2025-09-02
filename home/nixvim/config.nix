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
      bufferline.enable = true;
      lsp-lines.enable = true;
  
      wtf.enable = true;                # AI-driven dignostics debugging

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };

      luasnip.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-sleuth
      comment-nvim
      nvim-autopairs
      leetcode-nvim
    ];

    clipboard.register = "unnamedplus";

    extraConfigLua = ''
      require("leetcode").setup({
        lang = "python",
      })

      -- Remove trailing whitespaces on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        -- pattern = "*",
        command = [[%s/\\s\\+$//e]],
      })
    '';
  };
}
