{
  programs.lazygit = {
    enable = true;
    settings = {
      paging = {
        colorArg = "always";
      };
      commit.signOff = true;
      os.editPreset = "nvim";
    };
  };
}
