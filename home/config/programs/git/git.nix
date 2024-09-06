{
  programs.git = {
    enable = true;
    userName = "Silas";
    userEmail = "contact@silash.dev";
    signing = {
      key = "~/.ssh/id_rsa_private.pub";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        pager = "bat";
      };
      gpg = {
        format = "ssh";
      };
      push = {
        autoSetupRemote = true;
      };
      "gpg \"ssh\"" = {
        program = "ssh-keygen";
      };
    };
    aliases = {
      co = "checkout";
    };
    includes = [
      {
        condition = "gitdir:~/code/work/";
        path = "~/code/work/.gitconfig";
      }
    ];
  };
}
