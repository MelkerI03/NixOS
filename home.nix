{ 
  config, 
  pkgs, 
  lib, 
  ... 
}: 

{
  home.username = "viking";
  home.homeDirectory = "/home/viking";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; 
    [ 
      htop 
      git
      alacritty
      tmux
      fish
      starship
    ];

  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # luaLoader.enable = true;
    };

    starship.enable = true;

    alacritty = {
      enable = true;

      settings = {
        window = {
	  startup_mode = "Maximized";

	  padding.x = 15;
	  padding.y = 10;

	  decorations = "none";
	};
      };
    };
  };
}
