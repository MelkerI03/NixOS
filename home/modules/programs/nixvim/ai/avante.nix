{
  plugins.avante = {
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
}
