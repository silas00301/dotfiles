{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Silas";
        email = "contact@silash.dev";
      };
      ui = {
        default-command = "log";
        diff-editor = ["nvim" "-c" "DiffEditor $left $right $output"];
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_rsa_private.pub";
      };
      aliases = {
        tug = ["bookmark" "move" "--from" "heads(::@ & bookmarks())" "--to" "@"];
        insert = ["new" "--insert-before" "@"];
      };
    };
  };
}
