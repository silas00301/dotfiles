{ pkgs, ... }:
{
  programs.zen-browser = {
    enable = true;
    policies = {
      RequestedLocales = [
        "en-US"
        "de"
        "ja"
      ];
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi/";
        };
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi/";
        };
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi/";
        };
        "{bbb880ce-43c9-47ae-b746-c3e0096c5b76}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-web-file-icons/latest.xpi/";
        };
      };
    };
  };
}
