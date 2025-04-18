{ ... }:
{
  programs.atuin = {
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
