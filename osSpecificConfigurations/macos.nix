{ config, pkgs, ... }:

{
  homebrew.enable = true;

  homebrew.casks = [
    # currently needs manual install because of some bug
    #"logi-options+"
    "amethyst"
    #"bitwarden-cli"
    "obsidian"
    "raycast"
    "arc"
  ];

  environment.interactiveShellInit = ''
    $PATH=/etc/profiles/per-user/${config.username}/bin:$PATH
  '';

  users.users.${config.username}.shell = pkgs.fish;

  system = {
    defaults = {
      WindowManager.EnableStandardClickToShowDesktop = false;
      dock = {
        autohide = true;
        mru-spaces = false;
        magnification = true;
        autohide-time-modifier = 0.5;
        autohide-delay = 0.24;
        persistent-apps = [
          "/Applications/Arc.app/"
          "/Users/${config.username}/Applications/Home Manager Apps/Spotify.app/"
          "/Users/${config.username}/Applications/Home Manager Apps/kitty.app/"
        ];
        persistent-others = [
          "/Users/${config.username}/Downloads/"
        ];
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0;
        ShowDayOfMonth = true;
      };
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        AppleInterfaceStyle = "Dark";
        "com.apple.keyboard.fnState" = true;
      };
      spaces.spans-displays = false;
      trackpad = {
        Clicking = true;
        Dragging = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    startup.chime = false;
  };
}
