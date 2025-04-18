{ ... }:
{
  programs.kitty = {
    enable = true;

    themeFile = "Catppuccin-Mocha";
    shellIntegration.enableZshIntegration = true;
  
    settings = {
      scrollback_lines = 10000;

      font_family = "FiraCode Nerd Font Mono";
      font_size = 15;

      enable_audio_bell = false;
  
      wayland_titlebar_color = "background";
      window_padding_width = 10;
    };

    extraConfig = ''
      background #101218
      shell tmux
    '';
  };
}
