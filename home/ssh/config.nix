{ ... }:
{
    programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        IdentityFile = ~/.ssh/id_ed25519
        User git
        StrictHostKeyChecking accept-new
    '';
  };
}
