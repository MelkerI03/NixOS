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

    # LSP
    {
      mode = "n";
      key = "gd";
      action = "vim.lsp.buf.definition";
      options.silent = true;
    }
    {
      mode = "n";
      key = "gD";
      action = "vim.lsp.buf.declaration";
      options.silent = true;
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>Telescope lsp_references<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "K";
      action = "vim.lsp.buf.hover";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "vim.lsp.buf.code_action";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "vim.lsp.buf.rename";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "vim.diagnostic.open_float";
      options.silent = true;
    }
    {
      mode = "n";
      key = "]d";
      action = "vim.diagnostic.goto_next";
      options.silent = true;
    }
    {
      mode = "n";
      key = "[d";
      action = "vim.diagnostic.goto_prev";
      options.silent = true;
    }
  ];
}
