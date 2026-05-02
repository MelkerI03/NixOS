{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    imports = [
      ./lsp.nix
      ./keymaps.nix
      ./opts.nix
    ];

    colorscheme = "monokai-pro";
    colorschemes.monokai-pro.enable = true;

    plugins = {
      web-devicons.enable = true; # Nerd Font additions
      nvim-autopairs.enable = true; # Autopairing
      tmux-navigator.enable = true; # Nice tmux bind integration
      telescope.enable = true; # Fuzzyfinder
      treesitter.enable = true; # Basic linting and syntax highlighting
      treesitter-context.enable = true; # Show current function or context at top of window
      oil.enable = true; # File manager for easy file navigation
      lualine.enable = true; # Status line at the bottom of the editor
      which-key.enable = true; # Displays available key mappings in popup
      bufferline.enable = true; # Shows open buffers as tabs
      lsp-lines.enable = true; # Inline display of LSP diagnostics
      comment.enable = true; # Smart commenting plugin
      sleuth.enable = true; # Automatically adjusts shiftwidth based on file
      vimtex = {
        enable = true; # LaTeX support and compilation
        texlivePackage = pkgs.texlive.combined.scheme-full;
        settings = {
          view_method = "zathura_simple"; # PDF viewer for LaTeX output
          compiler_latexmk = {
            out_dir = "build"; # Output directory for compiled files
            options = [
              "-pdf"
              "-interaction=nonstopmode"
              "-synctex=1"
            ];
          };

          quickfix_mode = 0; # Disable quickfix mode
        };
      };
      cmp-vimtex.enable = true; # Completion source for vimtex
      friendly-snippets.enable = true; # Collection of useful snippets

      # Suggestions & more
      cmp = {
        enable = true; # Completion engine
        autoEnableSources = true; # Automatically enable completion sources
        settings = {
          sources = [
            { name = "vimtex"; } # LaTeX completion
            { name = "nvim_lsp"; } # LSP completion
            { name = "path"; } # Path completion
            { name = "buffer"; } # Buffer text completion
            { name = "luasnip"; } # Snippet completion
          ];

          mapping = {
            "<Tab>" = ''
              function(fallback)
                if require("cmp").visible() then
                  require("cmp").select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  require("luasnip").expand_or_jump()
                else
                  fallback()
                end
              end
            '';

            "<S-Tab>" = ''
              function(fallback)
                if require("cmp").visible() then
                  require("cmp").select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end
            '';

            "<CR>" = "cmp.mapping.confirm({ select = true })"; # Confirm selection on Enter
          };
        };
      };

      nui.enable = true; # UI component library
      plenary.enable = true; # Lua utility functions

      avante = {
        enable = true; # AI-assisted diff and hints plugin
        settings = {
          diff = {
            autojump = true; # Automatically jump to diffs
            debug = false; # Disable debug logging
            list_opener = "copen"; # Command to open quickfix list
          };

          highlights = {
            diff = {
              current = "DiffText"; # Highlight for current diff
              incoming = "DiffAdd"; # Highlight for incoming changes
            };
          };

          hints = {
            enabled = true; # Enable hints
          };

          mappings = {
            diff = {
              both = "cb"; # Show both changes
              next = "]x"; # Next diff
              none = "c0"; # No diff
              ours = "co"; # Our changes
              prev = "[x"; # Previous diff
              theirs = "ct"; # Their changes
            };
          };

          provider = "openai"; # AI provider
          providers = {
            openai = {
              endpoint = "https://api.openai.com/v1";
              extra_request_body = {
                max_tokens = 2048;
                temperature = 0.2;
              };
              model = "gpt-4.1-mini";
            };
          };

          input = {
            provider = "snacks";
            provider_opts = {
              title = "Avante Input";
              icon = " ";
              placeholder = "Enter your API key...";
            };
          };
        };
      };
      snacks.enable = true; # Input provider plugin

      luasnip.enable = true; # Snippet provider
      markdown-preview.enable = true; # Markdown compiler
    };
  };
}
