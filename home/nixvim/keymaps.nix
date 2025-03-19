{ lib, ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "<Leader>w";
      action = ":w<CR>";
      options.silent = true;
    }
  ];
}
