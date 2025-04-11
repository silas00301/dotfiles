{
  config,
  pkgs,
  lib,
  ...
}:

{
  homebrew.enable = true;

  homebrew.casks = [
    # currently needs manual install because of some bug
    "logi-options+"
    "amethyst"
    #"bitwarden-cli"
    #"obsidian"
    "raycast"
    "arc"
    "elgato-stream-deck"
  ];

  environment.interactiveShellInit = ''
    $PATH=/etc/profiles/per-user/${config.username}/bin:$PATH
  '';

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.${config.username}.shell = lib.mkForce pkgs.fish;

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  system = {
    defaults = {
      WindowManager.EnableStandardClickToShowDesktop = false;
      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = false;
        Bluetooth = false;
        Display = false;
        FocusModes = false;
        NowPlaying = false;
        Sound = false;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        magnification = true;
        autohide-time-modifier = 0.2;
        mineffect = "genie";
        show-recents = false;

        autohide-delay = 0.24;
        persistent-apps = [
          "/Applications/Arc.app/"
          "/Users/${config.username}/Applications/Home Manager Apps/Spotify.app/"
          "${pkgs.kitty}/Applications/kitty.app"
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
