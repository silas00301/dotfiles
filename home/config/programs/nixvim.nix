{nixvim, ...}: {
  home.packages = [
    nixvim
  ];

  home.sessionVariables = {
    EDITOR = "${nixvim}/bin/nvim";
  };
}
