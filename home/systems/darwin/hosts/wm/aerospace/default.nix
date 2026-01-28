{
  programs.aerospace.settings = builtins.fromTOML (builtins.readFile ./aerospace.toml);
}
