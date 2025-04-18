{
  programs.fish = {
    enable = true;
    functions = {
      gitignore = "curl -sL https://ww.gitignore.io/api/$argv";
      mkcd = "mkdir -p $argv && cd $argv";
      nix-exec = "nix-shell -p $argv[1] --run 'fish -c \"$argv\" '";
      last_history_item = "echo $history[1]";
      edit = "$EDITOR $argv";
      rmcont = "fd $argv[1] --exec rm";
    };
    shellAliases = {
      ls = "eza -la --git";
      l1 = "eza -1 --icons=never";
      nix-shell = "nix-shell --run fish";
      zf = "zellij run -f --";
    };
    shellAbbrs = {
      "!!" = {
        position = "anywhere";
        function = "last_history_item";
      };
    };
    shellInit = ''
      clear 
    '';
    interactiveShellInit = ''
      set -g fish_key_bindings fish_vi_key_bindings

      for script in ~/scripts/*.fish; do:
        source $script
      end

      clear
    '';
  };
}
