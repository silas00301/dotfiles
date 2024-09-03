{
  homebrew.enable = true;

  homebrew.casks = [
    # currently needs manual install because of some bug
    #"logi-options+"
    "raycast"
    "arc"
  ];

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
  };
}
