{ pkgs, ... }:
{
  catppuccin.zathura.enable = false;
  programs.zathura = {
    enable = true;

    package = pkgs.zathura.override {
      useMupdf = true;
    };

    options = {
      synctex = true;
      guioptions = "sv"; # show: Statusbar, vertical scroll

      selection-clipboard = "clipboard";

      page-cache-size = 50;
      render-all = true;
      incremental-search = true;
    };
  };
}
