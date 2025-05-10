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

    # Buffers
    {
      mode = "n";
      key = "<leader>bl";
      action = "<cmd>blast<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bnext<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bprev<CR>";
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
      action = "<cmd>lua vim.lsp.buf.definition()<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
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
      action = "<cmd>lua vim.lsp.buf.hover()<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>lua vim.lsp.buf.rename()<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "]d";
      action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "[d";
      action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
      options.silent = true;
    }
  ];
}
