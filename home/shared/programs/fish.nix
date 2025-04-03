{
  programs.fish = {
    enable = true;
    functions = {
      gitignore = "curl -sL https://ww.gitignore.io/api/$argv";
      mkcd = "mkdir -p $argv && cd $argv";
      last_history_item = "echo $history[1]";
      edit = "$EDITOR $argv";
    };
    shellAliases = {
      ls = "eza -la --git";
      l1 = "eza -1 --icons=never";
      zf = "zellij run -f --";
    };
    shellAbbrs = {
      "!!" = {
        position = "anywhere";
        function = "last_history_item";
      };
    };
    shellInit = ''
      set fish_greeting
    '';
    interactiveShellInit = ''
      set -g fish_key_bindings fish_vi_key_bindings

      for script in ~/scripts/*.fish
        source $script
      end

      zellij pipe "zjstatus::pipe::pipe_current_cmd::fish"
    '';
  };
  home.file."scripts/zjcmd.fish".text = ''
    function zjcmd --on-event fish_preexec
      if set -q ZELLIJ_PANE_ID
        zellij pipe "zjstatus::pipe::pipe_current_cmd::$(string split --max 1 " " $argv[1] | head -n 1)"
      end
    end
  '';
}
