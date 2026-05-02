{ ... }:
{
  plugins = {
    treesitter.enable = true;
    treesitter-context = {
      enable = true;
      settings.max_lines = 3;
    };
    which-key.enable = true;
  };
}
