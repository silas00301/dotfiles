{
  programs.git = {
    enable = true;
    userName = "Silas";
    userEmail = "contact@silash.dev";
    delta.enable = true;
    signing = {
      key = "~/.ssh/id_rsa_private.pub";
      signByDefault = true;
    };
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      push = {
        autoSetupRemote = true;
      };
      "gpg \"ssh\"" = {
        program = "ssh-keygen";
      };
      init.defaultBranch = "main";
    };
    aliases = {
      co = "checkout";
    };
    includes = [
      {
        condition = "gitdir:~/Developer/work/";
        path = "~/Developer/work/.gitconfig";
      }
    ];
  };
}
