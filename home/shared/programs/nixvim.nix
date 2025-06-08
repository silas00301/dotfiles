{ selfPackages, ... }:
{
  home.packages = [
    selfPackages.nixvim
  ];

  home.sessionVariables = {
    EDITOR = "${selfPackages.nixvim}/bin/nvim";
  };
}
