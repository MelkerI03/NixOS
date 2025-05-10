{ ... }:
{
  programs.git = {
    enable = true;
    userName  = "Melker Isaksson";
    userEmail = "Melker.Isaksson@outlook.com";

    config = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
