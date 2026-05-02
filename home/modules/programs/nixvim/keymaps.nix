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
      action = "<cmd>b#<CR>";
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
      key = "<leader>bd";
      action = "<cmd>bd<CR>";
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
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
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
      action = "<cmd>Lspsaga hover_doc<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>Lspsaga code_action<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>Lspsaga rename<CR>";
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

    #-------- ChatGPT ---------#

    # Open main UI
    {
      mode = "n";
      key = "<leader>cc";
      action = "<cmd>ChatGPT<CR>";
    }

    # Edit selected code with instructions
    {
      mode = "v";
      key = "<leader>ce";
      action = "<cmd>ChatGPTEditWithInstructions<CR>";
    }

    # Fix bugs
    {
      mode = "v";
      key = "<leader>cf";
      action = "<cmd>ChatGPTRun fix_bugs<CR>";
    }

    # Explain code
    {
      mode = "v";
      key = "<leader>cx";
      action = "<cmd>ChatGPTRun explain_code<CR>";
    }

    # Optimize code
    {
      mode = "v";
      key = "<leader>co";
      action = "<cmd>ChatGPTRun optimize_code<CR>";
    }

    # Generate docstring
    {
      mode = "v";
      key = "<leader>cd";
      action = "<cmd>ChatGPTRun docstring<CR>";
    }
  ];
}
