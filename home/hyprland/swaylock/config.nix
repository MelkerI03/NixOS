{ ... }:
{
  xdg.configFile."swaylock/config".text = ''
    # General settings
    image=/home/viking/Pictures/Wallpapers/kizu.jpg
    scaling=fill
    effect-blur=10x5  # Blur the wallpaper
    effect-vignette=0.5:0.5  # Optional vignette

    daemonize=true  # Run in background to ensure input focus
  '';
}
