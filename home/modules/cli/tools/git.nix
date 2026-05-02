{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    git
    git-credential-manager
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "MelkerI03";
        email = "Melker.Isaksson@outlook.com";
      };

      credential = {
        helper = "manager";
        "https://github.com".username = "MelkerI03";
        credentialStore = "cache";
      };

      init = {
        defaultBranch = "master";
      };

      merge = {
        tool = "nvimdiff";
      };

      mergetool.nvimdiff = {
        layout = "LOCAL,REMOTE / MERGED";
      };

      mergetool = {
        keepBackup = false;
        prompt = false;
      };

      core = {
        compression = 9;
        whitespace = "error";
        preload = true;
      };

      advice = {
        addEmptyPathspec = false;
        pushNonFastForward = false;
        statusHints = false;
      };

      url = {
        "git@github.com:MelkerI03/" = {
          insteadOf = [
            "mi:"
            "MelkerI03:"
          ];
        };

        "git@github.com:" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };

      interactive = {
        singleKey = true;
      };

      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = "all";
      };

      commit = {
        verbose = true;
        template = "${config.xdg.configHome}/git/commit-template.txt";
      };

      push = {
        default = "current";
        autoSetupRemote = true;

        followTags = true;
      };

      pull = {
        default = "current";
        rebase = true;
      };

      rebase = {
        autoStash = true;
        missingCommitsCheck = "warn";
      };

      branch = {
        sort = "-committerdate";
      };

      tag = {
        sort = "-taggerdate";
      };
    };

  };

  programs.delta = {
    enable = true;
    options = {
      navigate = true; # use n and N to move between diff sections
      dark = true;
    };
    enableGitIntegration = true;
  };

  home.file.".config/git/commit-template.txt".text = ''
    # ✅ CATEGORIES (pick one per commit):
    #
    # ✨ feat: 
    # 🐛 fix: 
    # 🧹 refactor: 
    # 🧪 test: 
    # 🧩 chore: 
    # 🎨 style: 
    # 📝 docs: 
    # 🚀 perf: 
    # 🔒 security: 
    # 🔧 config: 
    # ⏪ revert: 
    #
    # ────────────────────────────────────────────────
    #
    # 💡 STRUCTURE:
    # <type>: <short summary>
    #
    # [blank line]
    # (optional) <detailed description explaining what and why>
    #
    # ────────────────────────────────────────────────
  '';
}
