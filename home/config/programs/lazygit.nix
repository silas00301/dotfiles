{
  programs.lazygit = {
    enable = true;
    settings = {
      paging = {
        colorArg = "always";
        pager = "delta --paging=never";
      };
      commit.signOff = true;
    };
  };
}
