{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        python = [ "black" ];
        javascript = [ "prettier" ];
        nix = [
          "alejandra"
          # "nixfmt"
        ];
        c = [ "clang-format" ];
        haskell = [ "stylish-haskell" ];
        rust = [ "rustfmt" ];
      };

      format_on_save = ''
        function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          local function on_format(err)
            if err and err:match("timeout$") then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 400, lsp_fallback = true }, on_format
         end
      '';
    };
  };
}
