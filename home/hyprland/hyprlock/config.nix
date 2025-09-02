{ ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {

      general = {
        hide_cursor = true;
      };

      background = {
        path = "/home/viking/Pictures/Wallpapers/camel.png";
        blur_passes = 1;
      };

      input-field = {
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgb(cba6f7)";
        inner_color = "rgb(313244)";
        font_color = "rgb(cdd6f4)";
        fade_on_empty = false;
        placeholder_text = "<span foreground='##cdd6f4'><i>󰌾 Logged in as </i><span foreground='##cba6f7'>viking</span></span>";
        hide_input = false;
        check_color = "rgb(cba6f7)";
        fail_color = "rgb(f38ba8)";
        fail_text = "<i>$FAIL</i>";
        capslock_color = "rgb(f9e2af)";
        position = "0, -47";
        halign = "center";
        valign = "center";
      };
    };
  };
}
