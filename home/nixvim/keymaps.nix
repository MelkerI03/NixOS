{
  globals.mapleader = " ";

  keymaps = [
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>write<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = "<cmd>lua vim.lsp.buf.format()<CR>";
      options.silent = true;
    }

    # Telescope
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.silent = true;
    }
  ];
}
