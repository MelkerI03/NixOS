{ pkgs, ... }:
{
  programs = {
    atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        auto_sync = true;
        sync_frequency = "10m";
        sync_address = "https://api.atuin.sh";
        search_mode = "fuzzy";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batman
        batpipe
      ];
    };
  };
}
