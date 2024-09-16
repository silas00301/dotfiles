{
  programs.fish = {
    enable = true;
    functions = {
      gitignore = "curl -sL https://ww.gitignore.io/api/$argv";
      mkcd = "mkdir -p $argv && cd $argv";
      nix-exec = "nix-shell -p $argv[1] --run 'fish -c \"$argv\" '";
      last_history_item = "echo $history[1]";
    };
    shellAliases = {
      ls = "eza -la --git";
      nix-shell = "nix-shell --run fish";
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
    interactiveShellInit = "set -g fish_key_bindings fish_vi_key_bindings";
  };
}
