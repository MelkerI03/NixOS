{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      gs = "git status --short";
      gd = "git diff";

      ga = "git add";
      gap = "git add --patch";
      gc = "git commit";

      gp = "git push";
      gu = "git pull";

      gl = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n'";
      gb = "git branch";
      gw = "git switch";

      gi = "git init";
      gcl = "git clone";

      vi = "nvim";
      vim = "nvim";
      svim = "sudo -E nvim";

      cd = "z";
      ":q" = "exit";
      ls = "exa -lih";

      "devenv init" = "nix flake init --template github:cachix/devenv#flake-parts";
    };

    history.size = 10000;

    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      VISUAL = "nvim";
      GIT_EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      DIRENV_LOG_FORMAT = "";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "frontcube";
    };
  };
}
