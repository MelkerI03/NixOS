{
  plugins.lspsaga = {
    enable = true;
    settings = {
      use_saga_diagnostic_sign = true;
      code_action.keys = {
        quit = "<Esc>";
        exec = "<CR>";
      };
      lightbulb.enable = false;
    };
  };
}
