{ pkgs, ... }:
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
        diff-editor = [
          "nvim"
          "-c"
          "DiffEditor $left $right $output"
        ];
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_rsa_private.pub";
      };
      aliases = {
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@ & bookmarks())"
          "--to"
          "@"
        ];
        insert = [
          "new"
          "--insert-before"
          "@"
        ];
        reheat = [
          "rebase"
          "-d"
          "trunk()"
          "-s"
          "roots(trunk()..stack(@))"
        ];
        flip = [
          "util"
          "exec"
          "--"
          "jj-flip"
        ];
      };
      revset-aliases = {
        "stack()" = "stack(@)";
        "stack(x)" = "stack(x, 2)";
        "stack(x, n)" = "ancestors(reachable(x, mutable()), n)";
      };
      git.private-commits = "description(glob:'private:*')";
    };
  };
  home.packages = [
    (pkgs.writeShellScriptBin
    "jj-flip"
    ''
      #!${pkgs.zsh}/bin/zsh
      ${pkgs.jujutsu}/bin/jj bookmark create current --revision @
      ${pkgs.jujutsu}/bin/jj bookmark create previous --revision @-
      ${pkgs.jujutsu}/bin/jj parallelize current previous
      ${pkgs.jujutsu}/bin/jj rebase --branch previous --destination current
      ${pkgs.jujutsu}/bin/jj bookmark forget current
      ${pkgs.jujutsu}/bin/jj bookmark forget previous 
    '')
  ];
}
