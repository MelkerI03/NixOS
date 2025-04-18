{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -liah";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      svim = "sudo -E nvim";
      vim = "nvim";
      vi = "nvim";
      cd = "z";
      ":q" = "exit";
    };

    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "frontcube";    # Really nice theme
    };
  };
}
