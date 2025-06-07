{ pkgs, zen-browser, ... }:
{
  programs.firefox = {
    enable = true;
    package = zen-browser.packages.${pkgs.system}.default;
    languagePacks = [
      "en-US"
      "de"
      "ja"
    ];
  };
}
