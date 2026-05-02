{ ... }:
{
  xdg = {
    configFile."mimeapps.list".force = true;
    mime.enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = {
      "text/html" = [ "librewolf.desktop" ];

      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
      "x-scheme-handler/about" = [ "librewolf.desktop" ];
      "x-scheme-handler/unknown" = [ "librewolf.desktop" ];

      "application/pdf" = [ "librewolf.desktop" ];
      "application/x-extension-htm" = [ "librewolf.desktop" ];
      "application/x-extension-html" = [ "librewolf.desktop" ];
      "application/x-extension-shtml" = [ "librewolf.desktop" ];
      "application/xhtml+xml" = [ "librewolf.desktop" ];
      "application/x-extension-xhtml" = [ "librewolf.desktop" ];
      "application/x-extension-xht" = [ "librewolf.desktop" ];

      "image/png" = [ "pix.desktop" ];
      "image/jpg" = [ "pix.desktop" ];
      "image/webp" = [ "pix.desktop" ];
      "image/svg+xml" = [ "pix.desktop" ];
      "image/jpeg" = [ "pix.desktop" ];
    };
  };
}
