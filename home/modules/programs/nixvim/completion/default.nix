{
  luasnip.enable = true;
  friendly-snippets.enable = true;

  plugins.cmp = {
    enable = true; # Completion engine
    autoEnableSources = true; # Automatically enable completion sources
    settings = {
      sources = [
        { name = "vimtex"; } # LaTeX completion
        { name = "nvim_lsp"; } # LSP completion
        { name = "path"; } # Path completion
        { name = "buffer"; } # Buffer text completion
        { name = "luasnip"; } # Snippet completion
      ];

      mapping = {
        "<Tab>" = ''
          function(fallback)
            if require("cmp").visible() then
              require("cmp").select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end
        '';

        "<S-Tab>" = ''
          function(fallback)
            if require("cmp").visible() then
              require("cmp").select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end
        '';

        "<CR>" = "cmp.mapping.confirm({ select = true })"; # Confirm selection on Enter
      };
    };
  };
}
