{ pkgs, ... }:
{
  plugins.vimtex = {
    enable = true; # LaTeX support and compilation
    texlivePackage = pkgs.texlive.combined.scheme-full;
    settings = {
      view_method = "zathura"; # PDF viewer for LaTeX output
      compiler_latexmk = {
        out_dir = "build"; # Output directory for compiled files
        options = [
          "-pdf"
          "-interaction=nonstopmode"
          "-synctex=1"
        ];
      };

      quickfix_mode = 0; # Disable quickfix mode
    };
  };

  plugins.cmp-vimtex.enable = true;
}
