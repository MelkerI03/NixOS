{
  plugins.lsp.servers = {
    html.enable = true;
    cssls.enable = true;
    nixd.enable = true;
    vtsls.enable = true;
    tombi.enable = true;
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
}
