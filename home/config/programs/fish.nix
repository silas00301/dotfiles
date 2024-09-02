{
  programs.fish = {
    enable = true;
    functions = {
      gitignore = "curl -sL https://ww.gitignore.io/api/$argv";
      mkcd = "mkdir -p $argv && cd $argv";
      nix-exec = "nix-shell -p $argv[1] --run 'fish -c \"$argv\" '";
    };
    shellAliases = {
      ls = "eza -la --git";
      nix-shell = "nix-shell --run fish";
    };
    shellInit = ''
      clear 
    '';
    interactiveShellInit = "set -g fish_key_bindings fish_vi_key_bindings";
  };
}
