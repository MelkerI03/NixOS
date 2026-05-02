{ ... }:
{
  plugins.lsp = {
    enable = true;
    servers = {
      html.enable = true;
      cssls.enable = true;
      nixd.enable = true;
      vtsls.enable = true;
      tombi.enable = true;
      # ltex.enable = true;
      # ltex.settings = {
      #   language = "sv";
      # };
      # texlab.enable = true;
      basedpyright = {
        enable = true;
        settings = {
          basedpyright.analysis = {
            typeCheckingMode = "standard";
          };
          python = {
            venvPath = ".";
            venv = ".venv";
          };
        };
      };

      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;

        settings = {
          check = {
            command = "clippy";
          };
        };
      };

      hls = {
        enable = true;
        installGhc = true;
      };
      zls.enable = true;
      clangd.enable = true;
    };
  };

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

  plugins.lspsaga = {
    enable = true;
    settings = {
      use_saga_diagnostic_sign = true;
      code_action.keys = {
        quit = "<Esc>";
        exec = "<CR>";
      };
      lightbulb.enable = false;
    };
  };
}
