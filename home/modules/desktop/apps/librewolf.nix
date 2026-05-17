{ ... }:
{
  programs.librewolf = {
    enable = true;
    settings = {
      "identity.fxaccounts.enabled" = true;

      "browser.startup.page" = 3;

      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.formdata" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.cache" = false;
      "privacy.clearOnShutdown.sessions" = false;
      "browser.sessionstore.max_resumed_crashes" = -1;
      "signon.rememberSignons" = true;
      "webgl.disabled" = false;

      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";

      # Clicked links open in suitable tab
      "browser.link.open_newwindow" = 3;
      "browser.link.open_newwindow.restriction" = 2;
    };
  };
}
